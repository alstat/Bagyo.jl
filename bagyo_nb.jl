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

get(BestTrack, :ibtracs)
ibtracs = load(BestTrack, :ibtracs)
ibtracs

