using CairoMakie
using Colors
using GeoInterface
using GeoJSON
using GeoMakie

function plot_ph(proj::String)
    geo = GeoJSON.read(read(joinpath(PHL_POLY, "phl_geo.json"), String));
	asia_poly = GeoJSON.read(read(ASIA_POLY, String))
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

plot_ph_gall() = plot_ph("gall")
plot_ph_stere() = plot_ph("stere")

function plot(data::DataFrame, tracks::Symbol, proj::Symbol=:gall, country::Symbol=:phl)
    if country == :phl
        @info "Downloading PHL polygon (this only happens on first time plotting of PHL polygon)"
        get(CountryPoly, :phl)
        @info "Plotting"
        plot_ph(data, tracks, proj)
    else
        throw("Current choices are :phl and :jpy.")
    end
end

function plot_ph(data::DataFrame, tracks::Symbol, proj::Symbol=:gall)
	if tracks == :jma
        if proj == :gall
            fig, ax = with_theme(plot_ph_gall, theme_dark())
            idcs = unique(data[!, :INTERNATIONAL_ID])
            typhoon = DataFrame()
            for i in 1:(length(idcs))
                if i % 100 == 0
                    @info "Processing $(i)th track"
                end
                typhoon = filter(x -> x.INTERNATIONAL_ID === idcs[i], data)
                lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                    linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
            end
            lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                    linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
            return fig
        elseif proj == :stere
            fig, ax = with_theme(plot_ph_stere, theme_dark())
            idcs = unique(data[!, :INTERNATIONAL_ID])
            typhoon = DataFrame()
            for i in 1:(length(idcs))
                if i % 100 == 0
                    @info "Processing $(i)th track"
                end
                typhoon = filter(x -> x.INTERNATIONAL_ID === idcs[i], data)
                lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                    linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
            end
            lines!(typhoon[!, :LONGITUDE]./10, typhoon[!, :LATITUDE]./10,
                    linewidth=1, color=RGBAf(0.941176, 0.0, 1.0, 0.15))
            return fig
        else
            throw("Unknown projection type, choices are :gall and :stere")
        end
	end
end