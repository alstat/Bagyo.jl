# Visualization
This section will illustrate how to use some visualization API of Bagyo.jl. This is currently at early stage, and further customization on the target countries will be added, at the moment we have Philippine Area of Responsibility (PAR) as the region of interest.
```@repl abc
using Bagyo
get(BestTrack, :jma)
plot(BestTrack, :jma)
```
<img src="https://github.com/alstat/Bagyo.jl/raw/master/docs/src/assets/phl1.png" align="center"/>

The above codes uses Gall Stereographic projection. For Stereographic projection, we have
```@repl abc
plot(BestTrack, :jma, :stere)
```
<img src="https://github.com/alstat/Bagyo.jl/raw/master/docs/src/assets/phl.png" align="center"/>