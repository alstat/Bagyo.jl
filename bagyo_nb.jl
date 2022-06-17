using Bagyo
using Colors
using Makie

f3, a3 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot([JPN(), PHL(), THA(), TWN(), VNM()], :stere);
end;
meta, data = load(BestTrack, :jma)
lines!(a3, data, :jma, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a3.title = "Tropical Cyclone in Western-North Pacific";
a3.titlesize = 25;
a3.titlealign = :left;
a3.ylabelpadding = 15;
a3.xlabelpadding = -30;
save("five_countries.svg", f3)

using Bagyo
using Colors
using Makie

f4, a4 = with_theme(theme_dark(), resolution=(850, 650)) do
	plot([JPN(), PHL(), THA(), TWN(), VNM()], :stere);
end;
get(BestTrack, :ibtracs) # download the JMA Best Track, Bagyo.jl automatically skips this if data previously downloaded already
data = load(BestTrack, :ibtracs)
using DataFrames
track = DataFrame(); 
idcs = unique(data[!, :SID])
i = 1
track = filter(x -> x.SID === idcs[i], data)
if trackstype == :jma
	trackid = :INTERNATIONAL_ID
	longitude = :LONGITUDE
	latitude = :LATITUDE
elseif trackstype == :ibtracs
	trackid = :SID
	longitude = :LON
	latitude = :LAT
end

lines!(a4, track[!, longitude]./10, track[!, latitude]./10)

lines!(a4, data, :ibtracs, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))
a4.title = "Tropical Cyclone in Western-North Pacific";
a4.titlesize = 25;
a4.titlealign = :left;
a4.ylabelpadding = 15;
a4.xlabelpadding = -30;
f4
save("five_countries_ibtracs.svg", f4)