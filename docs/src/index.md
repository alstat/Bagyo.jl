# Bagyo.jl
[![codecov](https://codecov.io/gh/alstat/Bagyo.jl/branch/master/graph/badge.svg?token=AkqhQYSEsn)](https://codecov.io/gh/alstat/Bagyo.jl)
[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/alstat/Bagyo.jl/blob/master/LICENSE)

Bagyo.jl is a package for extraction and analysis of typhoon and climate data affecting the [Philippine Area of Responsibility (PAR)](https://en.wikipedia.org/wiki/Philippine_Area_of_Responsibility#:~:text=The%20Philippine%20Area%20of%20Responsibility,are%20given%20Philippine%2Dspecific%20names.). As such, it is a very specific package with interest on PAR only. Therefore, in terms of data, the main interest are those commonly used in literatures for understanding the cyclones in [WNP (Western-North Pacific)](https://en.wikipedia.org/wiki/Tropical_cyclone_basins#Northwestern_Pacific_Ocean) region, which include the PAR. These data are usually from the [Japan Meteorological Agency (JMA), Regional Specialized Meteorological Center (RSMC) Tokyo - Typhoon Center](https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/RSMC_HP.htm), and the [Joint Typhoon Warning Center (JTWC)](https://www.metoc.navy.mil/jtwc/jtwc.html).

Lastly, _"typhoon"_ and _"storm"_ in Filipino are generally referred to as _"bagyo."_

## Installation
To install the package, run the following:
```julia
julia> using Pkg
julia> Pkg.add("Bagyo")
```
## Outline
```@contents
Pages = [
    "data.md",
    "api.md"
]
Depth = 2
```
