# Visualization
This section will illustrate how to helper functions for visualizing the data. This is currently at the early stage, and further customization on the target countries will be added, at the moment it supports all countries affected by the Western-North Pacific cyclones. These are:
```@raw html
<table>
	<thead>
		<th>Country</th>
		<th>ISO3</th>
	</thead>
	<tbody>
		<tr>
			<td>Brunie</td>
			<td>BRN</td>
		</tr>
		<tr>
			<td>China</td>
			<td>CHN</td>
		</tr>
		<tr>
			<td>Japan</td>
			<td>JPN</td>
		</tr>
		<tr>
			<td>Cambodia</td>
			<td>KHM</td>
		</tr>
		<tr>
			<td>South Korea</td>
			<td>KOR</td>
		</tr>
		<tr>
			<td>Laos</td>
			<td>LAO</td>
		</tr>
		<tr>
			<td>Myanmar</td>
			<td>MMR</td>
		</tr>
		<tr>
			<td>Malaysia</td>
			<td>MYS</td>
		</tr>
		<tr>
			<td>Philippines</td>
			<td>PHL</td>
		</tr>
		<tr>
			<td>North Korea</td>
			<td>PRK</td>
		</tr>
		<tr>
			<td>Russia</td>
			<td>RUS</td>
		</tr>
		<tr>
			<td>Thailand</td>
			<td>THA</td>
		</tr>
		<tr>
			<td>Taiwand</td>
			<td>TWN</td>
		</tr>
		<tr>
			<td>Vietnam</td>
			<td>VNM</td>
		</tr>
	</tbody>
</table>
```
The countries' ISO3 are used in all APIs of Bagyo.jl for representing the country.

## First Plot
To start with the base plot---a plot of the Western-North Pacific region and the countries surrounding it---with emphasis on a particular country and its climate region of interest, is done as follows:
```@setup abc
using Pkg 
Pkg.add("Makie")
Pkg.add("CairoMakie")
Pkg.add("Colors")
using CairoMakie
CairoMakie.activate!(type = "svg")
```
```@example abc
using Bagyo
f0, a0 = plot(PHL(), :stere);
f0
```
The plot above gives emphasis on the Philippine Area of Responsibility (PAR).
## Adding Best Tracks
From the base plot, we can then add the Best Track using the `lines!` function.
```@example abc
using Bagyo
using Colors
using Makie

get(BestTrack, :jma) # download the JMA Best Track
meta, data = load(BestTrack, :jma);
f1, a1 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot(PHL(), :stere);
end;
lines!(a1, data, :jma, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a1.title = "Tropical Cyclone Tracks in Western-North Pacific using JMA";
a1.titlesize = 25;
a1.titlealign = :left;
a1.xlabelpadding = -30;
a1.ylabelpadding = 15;
f1
```
!!! note Note
    To run the above code, you need to install the Colors.jl and Makie.jl as follows:
	```julia
	using Pkg
	Pkg.add("Colors")
	Pkg.add("Makie")
	```
!!! note Note
    The code `get(BestTrack, :jma)` downloads the JMA Best Track data from the JMA website. Once downloaded, succeeding run will skip this.
!!! note Note
    First time plot of the target country, in this case, the Philippines (specified by `PHL()` in the `plot` function), downloads the polygon for this country. Once downloaded, succeeding run will skip this.

We added extra theming from the plot above.

## Multiple Climate Regions
The example above shows us examples of highlighting one specific country's climate of interest. The following illustrates how to highlight or plot multiple countries' climate regions, these regions correspond to the following countries: Japan, Philippines, Thailand, Taiwan and Vietnam, respectively.
```@example abc
using Bagyo
using Colors
using Makie

f2, a2 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot([JPN(), PHL(), THA(), TWN(), VNM()], :stere);
end;
get(BestTrack, :jma) # download the JMA Best Track, Bagyo.jl automatically skips this if data previously downloaded already
meta, data = load(BestTrack, :jma)
lines!(a2, data, :jma, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a2.title = "Tropical Cyclone Tracks in Western-North Pacific using JMA";
a2.titlesize = 25;
a2.titlealign = :left;
a2.ylabelpadding = 15;
a2.xlabelpadding = -30;
f2
```
!!! warning "Countries' Climate Boundaries"
    The climate boundary above are not official, except for the Philippines. The rest of the climate boundaries of other countries were subjectively provided. Users can specify this, see example in [Zooming to Countries' Climate Boundary](https://alstat.github.io/Bagyo.jl/dev/vis/#Zooming-to-Countries'-Climate-Boundary).

## Using IBTrACS
Another example using IBTrACS,
```@example abc
using Bagyo
using Colors
using Makie

f3, a3 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot([JPN(), PHL(), THA(), TWN(), VNM()], :stere);
end;
get(BestTrack, :ibtracs) # download the IBTrACS Best Track, Bagyo.jl automatically skips this if data previously downloaded already
data = load(BestTrack, :ibtracs)
lines!(a3, data, :ibtracs, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a3.title = "Tropical Cyclone Tracks in Western-North Pacific using IBTrACS";
a3.titlesize = 25;
a3.titlealign = :left;
a3.ylabelpadding = 15;
a3.xlabelpadding = -30;
f3
```
IBTrACS has 4000+ tropical cyclone tracks compared to only 1800+ cyclone tracks recorded by JMA. 

## Zooming to Countries' Climate Boundary
To zoom in and focus on one country, the configuration needs to be specified at a country Bagyo.jl type. For example,
```@example abc
get(BestTrack, :ibtracs) # download the IBTrACS Best Track
data = load(BestTrack, :ibtracs);
country = PHL(
	125, # set the center longitude of the map
	10, # set the center latitude of the map
	(110, 145), # set the longitude limits of the map
	(0, 28), # set the latitude limits of the map
	(PHL_AR_LON, PHL_AR_LAT) # add the tuples of arrays for the
							 # longitude and latitude of the climate area monitored
)	
f4, a4 = with_theme(theme_dark(), resolution=(770, 650)) do
	plot(country, :gall);
end;
lines!(a4, data, :ibtracs, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a4.title = "Tropical Cyclone Tracks in the PAR using IBTrACS";
a4.titlesize = 25;
a4.titlealign = :left;
a4.xlabelpadding = -25;
a4.ylabelpadding = 15;
f4
```
!!! note "Country Geodata Specification"
    The specification of the geodata for the `PHL` above is also available for other countries available for plotting in Bagyo.jl

## Theming
[Theming](https://makie.juliaplots.org/stable/documentation/theming/predefined_themes/) is done by using Makie.jl. You can also take inspiration from [Beautiful Makie](https://lazarusa.github.io/BeautifulMakie/). 
```@example abc
get(BestTrack, :ibtracs) # download the IBTrACS Best Track
data = load(BestTrack, :ibtracs);
country = PHL(
	125, # set the center longitude of the map
	10, # set the center latitude of the map
	(110, 145), # set the longitude limits of the map
	(0, 28), # set the latitude limits of the map
	(PHL_AR_LON, PHL_AR_LAT) # add the tuples of arrays for the
							 # longitude and latitude of the climate area monitored
)	
f5, a5 = with_theme(theme_light(), resolution=(770, 650)) do
	Bagyo.plot(country, :gall; 
	countrystyle = (
		color=colorant"#32a836", # color of the lands of the target country
		strokecolor=:gray, # color of the coastlines of the target country
		strokewidth=1 # width of the coastlines
		),
	landstyle = (
		color=colorant"#1e1c8c", # color of the lands of non-target countries
		strokecolor=:gray, # color of the coastlines of the non-target countries
		strokewidth=1 # width of the coastlines of the non-target countries
	)
	)
end;
lines!(a5, data, :ibtracs, linewidth=1, color=RGBAf(1.0, 0.180, 0.356, 0.15))
a5.title = "Tropical Cyclone Tracks in the PAR using IBTrACS";
a5.titlesize = 25;
a5.titlealign = :left;
a5.xlabelpadding = -25;
a5.ylabelpadding = 15;
f5
```
!!! tip "Theming"
    Other arguments for theming the `countrystyle` is available using `Makie.lines` arguments. This is true for `landstyle` and track styles as specified by the `lines!` function above.

## Map Projection
Bagyo.jl uses two main projections, the [Gall Stereographic](https://en.wikipedia.org/wiki/Gall_stereographic_projection) specified by `:gall` symbol, and the [Stereographic](https://en.wikipedia.org/wiki/Stereographic_projection#:~:text=In%20geometry%2C%20the%20stereographic%20projection,mapping%20is%20smooth%20and%20bijective.) specified by `:stere`. Although you can explore other projections like Cassini projection, it is mainly based on the [Proj Project](https://proj.org/operations/projections/index.html). Also it is further limited to those projection that supports `lon_0` and `lat_0` parameters.
```@example abc
get(BestTrack, :ibtracs) # download the IBTrACS Best Track
data = load(BestTrack, :ibtracs);
f6, a6 = with_theme(theme_light(), resolution=(850, 650)) do
	plot([JPN(), PHL(), THA(), TWN(), VNM()], :cass;
		countrystyle = (
			color=colorant"#32a836", # color of the lands of the target country
			strokecolor=:gray, # color of the coastlines of the target country
			strokewidth=1 # width of the coastlines
			),
		landstyle = (
			color=colorant"#1e1c8c", # color of the lands of non-target countries
			strokecolor=:gray, # color of the coastlines of the non-target countries
			strokewidth=1 # width of the coastlines of the non-target countries
		)
	);
end;
meta, data = load(BestTrack, :jma)
lines!(a6, data, :jma, linewidth=1, color=RGBAf(1.0, 0.180, 0.356, 0.15))
a6.title = "Tropical Cyclone Tracks under Cassini Projection";
a6.titlesize = 25;
a6.titlealign = :left;
a6.ylabelpadding = 15;
a6.xlabelpadding = -30;
f6
```