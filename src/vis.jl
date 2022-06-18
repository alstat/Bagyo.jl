using CairoMakie
using Colors
using GeoInterface
using GeoJSON
using GeoMakie
using Makie

function Makie.plot(countries::Array{AbstractCountry}, 
	proj::Symbol=:gall;
	countrystyle::NamedTuple=(
		color=colorant"#c9007c",
		strokecolor=:gray, 
		strokewidth=1), 
	landstyle::NamedTuple=(
		color=:black,
		strokecolor=:gray, 
		strokewidth=1)
	)
	asialand = GeoJSON.read(read(ASIA_POLY, String))
	fig = Figure();
	ax = GeoAxis(fig[1, 1], 
			dest="+proj=$proj +lon_0=$(countries[1].lon_0) +lat_0=$(countries[1].lat_0)", lonlims=countries[1].lonlims, latlims=countries[1].latlims, coastlines=false)
	poly!(ax, asialand; landstyle...)
	countrylon0 = []
	countrylat0 = []
	countrylonlims = []
	countrylatlims = []
	j = 1
	for country in countries
		ccode, cfolder, cfile = countrydata(country)
		get(CountryPoly, ccode)
		countryland = GeoJSON.read(read(joinpath(cfolder, cfile), String));
		push!(countrylon0, country.lon_0)
		push!(countrylat0, country.lat_0)
		push!(countrylonlims, country.lonlims)
		push!(countrylatlims, country.latlims)
		if j > 1
			if countrylon0[end] != countrylon0[end-1]
				throw("Multiple plotting of countries requires all countries to have the same lon_0, lat_0, lonlims, latlims")
			elseif countrylat0[end] != countrylat0[end-1]
				throw("Multiple plotting of countries requires all countries to have the same lon_0, lat_0, lonlims, latlims")
			elseif countrylonlims[end] != countrylonlims[end-1]
				throw("Multiple plotting of countries requires all countries to have the same lon_0, lat_0, lonlims, latlims")
			elseif countrylatlims[end] != countrylatlims[end-1]
				throw("Multiple plotting of countries requires all countries to have the same lon_0, lat_0, lonlims, latlims")
			end
		end
		poly!(ax, countryland; countrystyle...)
		lines!(ax, country.area_monitored[1], country.area_monitored[2])		
	end
	ax.xlabel = "Longitude";
	ax.ylabel = "Latitude";
	ax.xtickformat = "\n\n{:d}ᵒ"; 
	ax.ytickformat = "{:d}ᵒ ";
	return fig, ax
end

function Makie.plot(country::AbstractCountry, proj::Symbol=:gall;
	countrystyle::NamedTuple=(
		color=colorant"#c9007c",
		strokecolor=:gray, 
		strokewidth=1), 
	landstyle::NamedTuple=(
		color=:black,
		strokecolor=:gray, 
		strokewidth=1)
	)
	ccode, cfolder, cfile = countrydata(country)
	get(CountryPoly, ccode)
	countryland = GeoJSON.read(read(joinpath(cfolder, cfile), String));
	asialand = GeoJSON.read(read(ASIA_POLY, String))
	fig = Figure();
	ax = GeoAxis(fig[1, 1], 
		dest="+proj=$proj +lon_0=$(country.lon_0) +lat_0=$(country.lat_0)", lonlims=country.lonlims, latlims=country.latlims, coastlines=false)
	poly!(ax, asialand; landstyle...)
	poly!(ax, countryland; countrystyle...)
	lines!(ax, country.area_monitored[1], country.area_monitored[2])
	ax.xlabel = "Longitude";
	ax.ylabel = "Latitude";
	ax.xtickformat = "\n\n{:d}ᵒ"; 
	ax.ytickformat = "{:d}ᵒ ";
	return fig, ax
end

function Makie.lines!(axis::Makie.Axis, data::DataFrame, 
	trackstype::Symbol; kwargs...)
	if trackstype == :jma
		trackid = :INTERNATIONAL_ID
		longitude = :LONGITUDE
		latitude = :LATITUDE
	elseif trackstype == :ibtracs
		trackid = :SID
		longitude = :LON
		latitude = :LAT
	end
	track = DataFrame(); 
	idcs = unique(data[!, trackid])
	for i in 1:(length(idcs))
		if i % 100 == 0
			@info "Processing $(i)th track"
		end
		if trackstype == :jma
			track = filter(x -> x.INTERNATIONAL_ID === idcs[i], data)
			lines!(axis, track[!, longitude]./10, track[!, latitude]./10; kwargs...)
		elseif trackstype == :ibtracs
			track = filter(x -> x.SID === idcs[i], data)
			lines!(axis, track[!, longitude], track[!, latitude]; kwargs...)
		end
	end
	if trackstype == :jma
		lines!(axis, track[!, longitude]./10, track[!, latitude]./10; kwargs...)
	elseif trackstype == :ibtracs
		lines!(axis, track[!, longitude], track[!, latitude]; kwargs...)
	end
end