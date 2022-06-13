using CairoMakie
using Colors
using GeoInterface
using GeoJSON
using GeoMakie

function plotPH(proj::String)
    geo = GeoJSON.read(read(PHL, String));
	asia_poly = GeoJSON.read(read(ASIA, String))
	par_lat = [5, 5, 25, 25, 21, 15, 5]
	par_lon = [115, 135, 135, 120, 120, 115, 115]    
	fig = Figure(resolution = (1150, 900), fontsize = 22);
	ax = GeoAxis(fig[1, 1], dest="+proj=$proj +lon_0=150 +lat_0=10",
    	title ="Tropical Cyclones in the Western-North Pacific Region", 
		lonlims=(100, 185), latlims=(-5, 55), coastlines=false)
	poly!(ax, asia_poly, color=:black,
		strokecolor=colorant"#58666e", strokewidth=0.35)
	poly!(ax, geo, color=colorant"#85754e",
		strokecolor=colorant"#fff7e3", strokewidth=0.35)
	lines!(ax, par_lon, par_lat)
	ax.titlesize = 30
	ax.xlabelsize = 27
	ax.ylabelsize = 27
	ax.xlabel = "Longitude\n\n"
	ax.ylabel = "Latitude"
	ax.ylabelpadding = 15
	ax.xlabelpadding = -30
	ax.titlegap = 20
	ax.titlealign = :left
	ax.titlecolor = colorant"#ffe700"
 	ax.xtickformat = "\n\n{:d}ᵒ"
	ax.ytickformat = "{:d}ᵒ "
	colsize!(fig.layout, 1, Aspect(1, 2.0))
	return fig, ax
end

plotPHGall() = plotPH("gall")
plotPHStere() = plotPH("stere")

function plot(::Type{BestTrack}, data::Symbol, type::Symbol=:gall)
	if data == :jma
        try
            ty_data = CSV.read(joinpath(JMA_BT_DB, "track_data.csv"), DataFrame)
            if type == :gall
                fig, ax = with_theme(plotPHGall, theme_dark())
                idcs = unique(ty_data[!, :INTERNATIONAL_ID])
                typhoon = DataFrame()
                for i in 1:(length(idcs))
                    if i % 100 == 0
                        @info "Processing $(i)th track"
                    end
                    typhoon = filter(x -> x.INTERNATIONAL_ID === idcs[i], ty_data)
                    lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                        linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
                end
                lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                        linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
                return fig
            elseif type == :stere
                fig, ax = with_theme(plotPHStere, theme_dark())
                idcs = unique(ty_data[!, :INTERNATIONAL_ID])
                typhoon = DataFrame()
                for i in 1:(length(idcs))
                    if i % 100 == 0
                        @info "Processing $(i)th track"
                    end
                    typhoon = filter(x -> x.INTERNATIONAL_ID === idcs[i], ty_data)
                    lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                        linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
                end
                lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                        linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
                return fig
            else
                throw("Unknown projection type, choices are :gall and :stere")
            end
        catch  
            throw("JMA Data not available locally yet, you need to download it first, run get()")
        end
	end
end