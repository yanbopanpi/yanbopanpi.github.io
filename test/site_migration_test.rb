require "date"
require "digest"
require "minitest/autorun"
require "yaml"

class SiteMigrationTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  LEGACY = "/yanbo_pan.github.io"
  SOURCE_DIRS = %w[_pages _posts _talks _teaching _portfolio].freeze

  def read_yaml(text)
    YAML.respond_to?(:unsafe_load) ? YAML.unsafe_load(text) : YAML.load(text)
  end

  def documents
    SOURCE_DIRS.flat_map do |dir|
      Dir.glob(File.join(ROOT, dir, "*.{md,html}"))
    end.map do |path|
      text = File.read(path)
      front = text.match(/\A---\r?\n(.*?)\r?\n---(?:\r?\n|$)/m)
      [path, read_yaml(front[1]), text] if front
    end.compact
  end

  def test_root_site_configuration
    config = read_yaml(File.read(File.join(ROOT, "_config.yml")))
    assert_equal "https://yanbopanpi.github.io", config["url"]
    assert_equal "", config["baseurl"]
    assert_equal "yanbopanpi/yanbopanpi.github.io", config["repository"]
    assert_includes config["plugins"], "jekyll-redirect-from"
    assert_includes config["whitelist"], "jekyll-redirect-from"
    %w[scripts test].each { |path| assert_includes config["exclude"], path }
  end

  def test_each_published_document_has_its_old_address
    documents.each do |path, data, _|
      route = data["permalink"] || "/portfolio/#{File.basename(path, '.*')}/"
      assert_includes Array(data["redirect_from"]), LEGACY + route, path
    end
  end

  def test_redirects_have_one_destination_and_do_not_loop
    destinations = {}
    documents.each do |path, data, _|
      target = data["permalink"] || "/portfolio/#{File.basename(path, '.*')}/"
      Array(data["redirect_from"]).each do |old_path|
        refute_equal target, old_path, "Self redirect: #{path}"
        assert_equal target, destinations[old_path], "Conflicting redirect: #{old_path}" if destinations.key?(old_path)
        destinations[old_path] = target
      end
    end
    assert_equal "/", destinations[LEGACY + "/"]
    assert_equal "/", destinations[LEGACY + "/index.html"]
    assert_equal "/", destinations["/about/"]
    assert_equal "/", destinations[LEGACY + "/about/"]
    assert_equal "/publications/", destinations[LEGACY + "/publications/"]
    assert_equal "/talks/", destinations[LEGACY + "/talks/"]
    assert_equal "/markdown/", destinations[LEGACY + "/markdown/"]
  end

  def test_content_does_not_link_to_the_old_site
    documents.each do |path, _, text|
      refute_includes text, "https://yanbopanpi.github.io/yanbo_pan.github.io/", path
    end
  end

  def test_legacy_downloads_are_identical_to_current_files
    files = Dir.glob(File.join(ROOT, "files", "**", "*")).select { |path| File.file?(path) }
    refute_empty files
    files.each do |path|
      relative = path.delete_prefix(ROOT + "/")
      legacy = File.join(ROOT, LEGACY.delete_prefix("/"), relative)
      assert File.file?(legacy), "Missing legacy download: #{relative}"
      assert_equal Digest::SHA256.file(path).hexdigest, Digest::SHA256.file(legacy).hexdigest, relative
    end
  end
end
