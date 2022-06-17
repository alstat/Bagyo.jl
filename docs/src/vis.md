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
using Colors
using Makie
f0, a0 = plot(PHL(), :stere);
f0
```
The plot above gives emphasis on the Philippine Area of Responsibility (PAR).
## Adding Best Tracks
From the base plot, we can then add the Best Track using the `lines!` function.
```@example abc
get(BestTrack, :jma) # download the JMA Best Track
meta, data = load(BestTrack, :jma);
f1, a1 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot(PHL(), :stere);
end;
lines!(a1, data, :jma, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a1.title = "Tropical Cyclone in Western-North Pacific";
a1.titlesize = 25;
a1.titlealign = :left;
a1.xlabelpadding = -30;
a1.ylabelpadding = 15;
f1
```
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
a2.title = "Tropical Cyclone in Western-North Pacific";
a2.titlesize = 25;
a2.titlealign = :left;
a2.ylabelpadding = 15;
a2.xlabelpadding = -30;
f2
```
## Using IBTrACS
Another example using IBTrACS,
```@example abc
using Bagyo
using Colors
using Makie

f3, a3 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot([JPN(), PHL(), THA(), TWN(), VNM()], :stere);
end;
get(BestTrack, :ibtracs) # download the JMA Best Track, Bagyo.jl automatically skips this if data previously downloaded already
data = load(BestTrack, :ibtracs)
lines!(a3, data, :ibtracs, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a3.title = "Tropical Cyclone in Western-North Pacific";
a3.titlesize = 25;
a3.titlealign = :left;
a3.ylabelpadding = 15;
a3.xlabelpadding = -30;
f3
```