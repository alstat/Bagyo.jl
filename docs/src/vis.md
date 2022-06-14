# Visualization
This section will illustrate how to use some visualization API of Bagyo.jl. This is currently at early stage, and further customization on the target countries will be added, at the moment we have Philippine Area of Responsibility (PAR) as the region of interest.
```@repl abc
using Bagyo
f0, a0 = plot(PHL(), :stere);
f0
```
```@raw html
<img src="https://github.com/alstat/Bagyo.jl/raw/master/docs/src/assets/phl0.svg" align="center"/>
```
To plot the JMA Best Tracks, we use the `lines!` function as follows:
```@repl abc
using Bagyo
get(BestTrack, :jma)
meta, data = load(BestTrack, :jma);
f1, a1 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot(PHL(), :stere);
end;
lines!(a1, data, :jma, linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15));
a1.xtickformat = "\n\n{:d}ᵒ"; 
a1.ytickformat = "{:d}ᵒ ";
a1.title = "Tropical Cyclone in Western-North Pacific";
a1.titlesize = 25;
a1.titlealign = :left;
a1.xlabel = "Longitude";
a1.ylabel = "Latitude";
a1.ylabelpadding = 15;
a1.xlabelpadding = -30;
```
```@raw html
<img src="https://github.com/alstat/Bagyo.jl/raw/master/docs/src/assets/phl1.svg" align="center"/>
```