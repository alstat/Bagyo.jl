using CairoMakie
using Colors
using GeoInterface
using GeoJSON
using GeoMakie
using Makie

abstract type AbstractCountry end

struct PHL <: AbstractCountry
    lon_0::Int64
    lat_0::Int64
    lonlims::Tuple
    latlims::Tuple
    area_monitored::Tuple
end
par_lon = [115, 135, 135, 120, 120, 115, 115]    
par_lat = [5, 5, 25, 25, 21, 15, 5]
PHL() = PHL(150, 10, (100, 185), (-5, 55), (par_lon, par_lat))

function Makie.plot(country::AbstractCountry, proj::Symbol=:gall,
	countrystyle::NamedTuple=(
		color=colorant"#c9007c",
		strokecolor=:gray, 
		strokewidth=1), 
	landstyle::NamedTuple=(
		color=:black,
		strokecolor=:gray, 
		strokewidth=1)
	)
	if country isa PHL
		get(CountryPoly, :phl)
		countryland = GeoJSON.read(read(joinpath(PHL_POLY, "phl_geo.json"), String));
		asialand = GeoJSON.read(read(ASIA_POLY, String))
		fig = Figure();
		ax = GeoAxis(fig[1, 1], 
			dest="+proj=$proj +lon_0=$(country.lon_0) +lat_0=$(country.lat_0)", lonlims=country.lonlims, latlims=country.latlims, coastlines=false)
		poly!(ax, asialand; landstyle...)
		poly!(ax, countryland; countrystyle...)
		lines!(ax, country.area_monitored[1], country.area_monitored[2])
		return fig, ax
	end
end

function Makie.lines!(axis::Makie.Axis, data::DataFrame, 
	trackstype::Symbol; kwargs...)
	if trackstype == :jma
		track = DataFrame()
		idcs = unique(data[!, :INTERNATIONAL_ID])
		for i in 1:(length(idcs))
			if i % 100 == 0
				@info "Processing $(i)th track"
			end
			track = filter(x -> x.INTERNATIONAL_ID === idcs[i], data)
			lines!(axis, track[!, :LONGITUDE]./10, track[!, :LATITUDE]./10; kwargs...)
		end
		lines!(axis, track[!, :LONGITUDE]./10, track[!, :LATITUDE]./10; kwargs...)
	end
end