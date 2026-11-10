---
layout: archive
title: "Research"
permalink: /publications/
author_profile: true
redirect_from:
  - /yanbo_pan.github.io/publications/
---

# Welcome to My Research Website!
# Research

I use stellar dynamics and statistical modeling to study nearby galaxies and develop tools that help astronomers choose informative observations.

## Sagittarius dSph: Mapping the Mass of a Disrupting Galaxy

I combine Gaia measurements of stellar motions with estimates of stellar chemistry to investigate the mass distribution within the Sagittarius dwarf galaxy. My analysis uses chemically distinct stellar populations as complementary tracers of its gravitational field. I am preparing a manuscript and assessing how observational uncertainties and tidal disruption affect the interpretation.

**Status:** Manuscript in preparation.

## HARLEE: Choosing the Next Binary-Star Observation

Sparse velocity measurements can leave several possible binary-star orbits consistent with the data. Building on [theJoker](https://thejoker.readthedocs.io/en/latest/), I developed HARLEE’s forecasting and observation-selection workflow to identify times when those orbits predict different velocities. I am evaluating the workflow using archival observations and preparing documentation and benchmarks for a public release.

Check out my previous [work](https://aas244-aas.ipostersessions.com/default.aspx?s=97-48-6D-B3-10-A4-DC-41-AF-20-C0-B5-14-D8-9F-7D&guestview=true) on binary orbits. 

**Status:** Research software in development.

## Selected publications

I also have studied exoplanet atmospheres. 
- **Pan et al. (2026), Astronomical Journal:** [WASP-52b with JWST NIRSpec](https://doi.org/10.3847/1538-3881/ae9cbc). JWST MEP—A World Under Spotty Starlight: Detection of CO2 and H2O in the Hot Saturn WASP-52b with JWST NIRSpec G395H

- **Fournier-Tondreau, Pan et al. (2025), MNRAS:** [WASP-52b with JWST NIRISS](https://doi.org/10.1093/mnras/staf489). Transmission spectroscopy of WASP-52 b with JWST NIRISS: water and helium atmospheric absorption, alongside prominent star-spot crossings

## Earlier research

My earlier work includes searches for faint galaxies in the Local Group, stellar kinematics in ultra-faint dwarf galaxies, and binary-orbit modeling with the WIYN Open Cluster Survey.



  




{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}



