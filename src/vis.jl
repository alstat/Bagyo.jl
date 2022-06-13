using CairoMakie
using Colors
using Downloads
using GeoInterface
using GeoJSON
using GeoMakie

function plotPH(proj="gall")
    phmap = Downloads.download(PH_LOWRES_GEOJSON);
    geo = GeoJSON.read(read(phmap, String));
	par_lat = [5, 5, 25, 25, 21, 15, 5]
	par_lon = [115, 135, 135, 120, 120, 115, 115]    
	fig = Figure(resolution = (1050, 800), fontsize = 22);
	ax = GeoAxis(fig[1, 1], dest="+proj=$proj +lon_0=150 +lat_0=10",
    	title ="Tropical Cyclones in the Western-North Pacific Region\n\n", 
		lonlims=(100, 200), latlims=(-5, 60), coastlines=true, 
		coastline_attributes=(color=:white, linewidth=0.35, fill=:black))
	poly!(ax, geo, color=colorant"#85754e",
		strokecolor = :white, strokewidth = 0.35)
	lines!(ax, par_lon, par_lat)
	ax.titlesize = 30
	ax.xlabel = "Longitude\n\n"
	ax.ylabel = "Latitude"
	ax.ylabelpadding = 15
	ax.xlabelpadding = -30
 	ax.xtickformat = "\n\n{:d}ᵒ"
	ax.ytickformat = "{:d}ᵒ "
	colsize!(fig.layout, 1, Aspect(1, 2.0))
	fig
end