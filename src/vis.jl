using GMT

import GMT: plot

const PAR_LAT = [5, 5, 25, 25, 21, 15, 5]
const PAR_LON = [115, 135, 135, 120, 120, 115, 115]    

function concat(::Type{BestTrack{JMAData}}, data::DataFrame)
    @info "initial preprocessing"
    rawdat[!, :speed] = map(x -> try parse.(Float64, string.(x)); catch; 0 end, data[!, :speed])
    rawdat[!, :quarter] = map(x -> 1 <= x <= 3 ? :q1 : 4 <= x <= 6 ? :q2 : 7 <= x <= 9 ? :q3 : :q4, rawdat[!, :month])
    rawdat[!, :semester] = map(x -> 1 <= x <= 6 ? :sem1 : :sem2, rawdat[!, :month])
    
    @info "plotting tracks"
    grp = groupby(rawdat, :international_id)
    grpdat = combine(grp) do sdf
        DataFrame(latitude = vec(sdf.latitude), longitude = vec(sdf.longitude))
    end
    return grpdat
end

function GMT.plot(::Type{BestTrack{JMAData}}, data::DataFrame, 
    region::String="115/0.1/180/40+r", proj::NamedTuple=(name=:stereographic, center=(135,90)), frame::Symbol=:a15g15, res::Symbol=:low,
    area::Int64=250, land::Symbol=:darkgreen, shore::Symbol=:thinnest, water::Symbol=:seashell, figsize::Int64=11,
    lw::Int64=1, lc::Symbol=:red, alpha::Float64=0.5, par::NamedTuple=(FONT_ANNOT_PRIMARY=12,))
    data[!, :speed] = map(x -> try parse.(Float64, string.(x)); catch; 0 end, data[!, :speed])
    coast(region=region, proj=proj, frame=frame, res=res, area=area, land=land, shore=shore, water=water, figsize=figsize, par=par)
    GMT.plot!(PAR_LON, PAR_LAT, lw=lw, lc=lc, alpha=alpha)

    idcs = unique(data[!, :international_id])
    typhoon = DataFrame()
    for i in 1:(length(idcs))
        if i % 100 == 0
            @info "Processing $(i)th track"
        end
        typhoon = filter(x -> x.international_id === idcs[i], data)
        GMT.plot!(typhoon[!, :longitude]./10, typhoon[!, :latitude]./10, lw=1, lc=:darkorange, alpha=0.6)
    end
    GMT.plot!(typhoon[!, :longitude]./10, typhoon[!, :latitude]./10, lw=1, lc=:darkorange, alpha=0.98, show=true, fmt=:png)
end
