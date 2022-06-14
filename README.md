# Bagyo.jl <img src="docs/src/assets/logo.svg" align="right" width="100"/>
[![CI](https://github.com/alstat/Bagyo.jl/actions/workflows/ci.yml/badge.svg)](https://github.com/alstat/Bagyo.jl/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/alstat/Bagyo.jl/branch/master/graph/badge.svg?token=AkqhQYSEsn)](https://codecov.io/gh/alstat/Bagyo.jl)
[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/alstat/Bagyo.jl/blob/master/LICENSE)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://alstat.github.io/Bagyo.jl/dev/)

Bagyo.jl is a package for extraction and analysis of typhoon and climate data in the [WNP (Western-North Pacific)](https://en.wikipedia.org/wiki/Tropical_cyclone_basins#Northwestern_Pacific_Ocean) region (at least for now). As such, it is a very specific package focusing only on WNP. Therefore, in terms of data, the main interest are those commonly used in literatures for understanding the cyclones in the said region, which covers the [Philippine Area of Responsibility (PAR)](https://en.wikipedia.org/wiki/Philippine_Area_of_Responsibility#:~:text=The%20Philippine%20Area%20of%20Responsibility,are%20given%20Philippine%2Dspecific%20names.), and other neighboring South-East Asian regions. These data are usually from the [Japan Meteorological Agency (JMA), Regional Specialized Meteorological Center (RSMC) Tokyo - Typhoon Center](https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/RSMC_HP.htm), [Joint Typhoon Warning Center (JTWC)](https://www.metoc.navy.mil/jtwc/jtwc.html), and the consolidations of all tracks by the [International Best Track Archive for Climate Stewardship (IBTrACS)](https://www.ncei.noaa.gov/products/international-best-track-archive?name=ib-v4-access). Bagyo.jl currently offers JMA and IBTrACS data, but skips JTWC as it is not timely released (last updated 2020). The package is actively being developed and functionalities for downloading, loading, visualizing and modeling the data are expected to be added.

Lastly, _"typhoon"_ and _"storm"_ in Filipino are generally referred to as _"bagyo."_

## Installation
To install the package, run the following:
```julia
julia> using Pkg
julia> Pkg.add("Bagyo")
```

## Usage
The following is an example of downloading and visualizing JMA RSMC best track data with emphasis on Philippine Area of Responsibility:
```julia
using Bagyo
using Colors
using Makie
get(BestTrack, :jma)
meta, data = load(BestTrack, :jma);
f1, a1 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot(PHL(), :stere);
end;
lines!(a1, data, :jma, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a1.title = "Tropical Cyclone in Western-North Pacific";
a1.titlesize = 25;
a1.titlealign = :left;
a1.xlabel = "Longitude";
a1.ylabel = "Latitude";
a1.xlabelpadding = -30;
a1.ylabelpadding = 15;
a1.xtickformat = "\n\n{:d}ᵒ"; 
a1.ytickformat = "{:d}ᵒ ";
f1
```
<img src="docs/src/assets/phl1.svg" align="center"/>
See the <a href="https://alstat.github.io/Bagyo.jl/dev/">documentation</a> for more.