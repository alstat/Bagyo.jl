# Bagyo.jl
[![codecov](https://codecov.io/gh/alstat/Bagyo.jl/branch/master/graph/badge.svg?token=AkqhQYSEsn)](https://codecov.io/gh/alstat/Bagyo.jl)
[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/alstat/Bagyo.jl/blob/master/LICENSE)

Bagyo.jl is a package for extraction and analysis of typhoon and climate data affecting the Philippine Area of Responsibility (PAR). As such, it is a very specific package with interest on PAR only. Therefore, in terms of data, the main interest are those commonly used in literatures for understanding the cyclones in NWP (North-Western Pacific) region, such as the JMA and JTWC data.

Lastly, "typhoons" and "storms" in Filipino are generally referred to as "bagyo."

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
