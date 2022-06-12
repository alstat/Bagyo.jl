# Bagyo.jl <img src="docs/src/assets/logo.svg" align="right" width="100"/>
[![CI](https://github.com/alstat/Bagyo.jl/actions/workflows/ci.yml/badge.svg)](https://github.com/alstat/Bagyo.jl/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/alstat/Bagyo.jl/branch/master/graph/badge.svg?token=AkqhQYSEsn)](https://codecov.io/gh/alstat/Bagyo.jl)
[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/alstat/Bagyo.jl/blob/master/LICENSE)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://alstat.github.io/Bagyo.jl/dev/)

Bagyo.jl is a package for extraction and analysis of typhoon and climate data in the [WNP (Western-North Pacific)](https://en.wikipedia.org/wiki/Tropical_cyclone_basins#Northwestern_Pacific_Ocean) region (at least for now). As such, it is a very specific package with interest on WNP only. Therefore, in terms of data, the main interest are those commonly used in literatures for understanding the cyclones in the said region, which covers the [Philippine Area of Responsibility (PAR)](https://en.wikipedia.org/wiki/Philippine_Area_of_Responsibility#:~:text=The%20Philippine%20Area%20of%20Responsibility,are%20given%20Philippine%2Dspecific%20names.), and other neighboring South-East Asian regions. These data are usually from the [Japan Meteorological Agency (JMA), Regional Specialized Meteorological Center (RSMC) Tokyo - Typhoon Center](https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/RSMC_HP.htm), and the [Joint Typhoon Warning Center (JTWC)](https://www.metoc.navy.mil/jtwc/jtwc.html).

Lastly, _"typhoon"_ and _"storm"_ in Filipino are generally referred to as _"bagyo."_

## Installation
To install the package, run the following:
```julia
julia> using Pkg
julia> Pkg.add("Bagyo")
```
