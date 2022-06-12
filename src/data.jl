using CSV
using DataFrames
using Dates
using HTTP
import Base: download, delete!
"""
    JMAData(best_track::String)

Instantiate JMADAta by specifying the url for the best_track data.
"""
struct JMAData
    best_track::String
end
JMAData() = JMAData(JMA_BST)

struct BestTrack{T}
    data::T
end

"""
    download(file::BestTrack)

Download the BestTrack data.
"""
function Base.download(file::BestTrack)
    try mkdir(DB) catch end
    if (file.data isa JMAData)
        try
            mkdir(JMA_DB)
            mkdir(JMA_BST_DB)
        catch end
        HTTP.download(file.data.best_track, joinpath(JMA_BST_DB, "bst_all.zip"))
        unzip(joinpath(JMA_BST_DB, "bst_all.zip"))

        @info "Parsing raw data"
        meta, data = parse(BestTrack{JMAData})

        @info "Saving cleaned data"
        CSV.write(joinpath(JMA_BST_DB, "track_meta.csv"), meta)
        CSV.write(joinpath(JMA_BST_DB, "track_data.csv"), data)
    else
        throw("Unknown input type $(file.data)")
    end
end

"""
    delete!(::Type{JMAData})

Delete the local JMAData files/folders
"""
function Base.delete!(::Type{JMAData})
    try
        rm(JMA_DB, recursive=true)
        @info "JMA DB successfully deleted."
    catch
        @info "Skipping: Skipping deletion of JMA DB since it does not exists."
    end
end

"""
    delete!(::Type{BestTrack{JMAData}})

Delete the local JMAData Best Track files/folders
"""
function Base.delete!(::Type{BestTrack{JMAData}})
    try
        rm(JMA_BST_DB, recursive=true)
        @info "JMA Best Track DB successfully deleted."
    catch
        @info "Skipping: Skipping deletion of JMA Best Track DB since it does not exists."
    end
end

"""
    parse(::Type{BestTrack{JMAData}}, file::Union{Nothing,String}=nothing)

Parse the local JMAData Best Track `file`. If `file` is `nothing`, Bagyo.jl will 
locate the file in its default DB folder.
"""
function Base.parse(::Type{BestTrack{JMAData}}; file::Union{Nothing,String}=nothing)
    if file isa Nothing
        raw = readlines(joinpath(JMA_BST_DB, "bst_all.txt"));
    else
        raw = readlines(file);
    end
    indcs = map(x -> occursin(r"6{4}", x), raw)
    raw_meta = raw[indcs]

    intern_id = Union{Missing,String}[]; num_lines = Union{Missing,Int64}[]
    cyclnenum = Union{Missing,Int64}[]; last_flag = Union{Missing,Int64}[]; stormname = Union{Missing,String}[];
    date_time = Union{Missing,Date}[]; time_diff = Union{Missing,Int64}[];

    for m in raw_meta
        push!(intern_id, m[7:10])
        try
            push!(num_lines, parse(Int64, m[13:15]))
        catch
            push!(num_lines, missing)
        end

        try 
            push!(cyclnenum, parse(Int64, m[17:20]))
        catch
            push!(cyclnenum, missing)
        end

        try
            push!(last_flag, parse(Int64, m[27]))
        catch
            push!(last_flag, missing)
        end

        try
            push!(time_diff, parse(Int64, m[39]))
        catch
            push!(time_diff, missing)
        end 

        if strip(m[31:50]) == ""
            push!(stormname, missing)
        else
            push!(stormname, strip(m[31:51]))
        end

        if strip(m[65:72]) == ""
            push!(date_time, missing)
        else
            push!(date_time, Date(strip(m[53:end]), dateformat"yyyymmdd"))
        end
    end
    typhoon_meta = DataFrame([
        intern_id, num_lines, cyclnenum, last_flag, time_diff, stormname, date_time],
        [:international_id, :number_of_lines, :cyclone_number, :last_flag, :time_diff, :storm_name, :date_time]
    )
    
    raw_data = raw[.!indcs]
    numlines = vcat([0], num_lines)

    int_id = Union{Missing,String}[]; datetime = Union{Missing,DateTime}[]; yy = Union{Missing,Int64}[];
    mm = Union{Missing,Int64}[]; dd = Union{Missing,Int64}[]; hh = Union{Missing,Int64}[]; storm_name = Union{Missing,String}[]; tygrade = Union{Missing,Int64}[];
    lat = Union{Missing,Float64}[]; long = Union{Missing,Float64}[]; pressure = Union{Missing,Float64}[]; speed = Union{Missing,Float64}[];
    rad50_dir = Union{Missing,Int64}[]; long_rad50 = Union{Missing,Float64}[]; short_rad50 = Union{Missing,Float64}[];
    rad30_dir = Union{Missing,Int64}[]; long_rad30 = Union{Missing,Float64}[]; short_rad30 = Union{Missing,Float64}[];
    jpfallpass = Union{Missing,Char}[];

    start = 0
    for nl in 2:length(numlines)
        final = start + numlines[nl]
        for i in (start + 1):final
            tydata = raw_data[i]
            push!(int_id, intern_id[nl-1])
            if parse(Int64, tydata[1:2]) < 30
                push!(yy, parse(Int64, "20" * tydata[1:2]))
            else
                push!(yy, parse(Int64, "19" * tydata[1:2]))
            end        
            push!(mm, parse(Int64, tydata[3:4]))
            push!(dd, parse(Int64, tydata[5:6]))
            push!(hh, parse(Int64, tydata[7:8]))
            push!(datetime, DateTime(yy[end], mm[end], dd[end], hh[end]))
            push!(storm_name, stormname[nl-1])
            try
                push!(tygrade, parse(Int64, tydata[14]))
            catch
                push!(tygrade, missing)
            end

            try
                push!(lat, parse(Float64, tydata[16:18]))
            catch
                push!(lat, missing)
            end

            try
                push!(long, parse(Float64, tydata[20:23]))
            catch
                push!(long, missing)
            end

            try
                push!(pressure, parse(Float64, tydata[25:28]))
            catch
                push!(pressure, missing)
            end

            try
                push!(speed, parse(Float64, tydata[34:36]))
            catch
                push!(speed, missing)
            end

            try
                push!(rad50_dir, parse(Int64, tydata[42]))
            catch
                push!(rad50_dir, missing)
            end

            try
                push!(long_rad50, parse(Float64, tydata[43:46]))
            catch
                push!(long_rad50, missing)
            end

            try
                push!(short_rad50, parse(Float64, tydata[48:51]))
            catch   
                push!(short_rad50, missing)
            end

            try
                push!(rad30_dir, parse(Int64, tydata[53]))
            catch
                push!(rad30_dir, missing)
            end

            try
                push!(long_rad30, parse(Float64, tydata[54:57]))
            catch
                push!(long_rad30, missing)
            end

            try
                push!(short_rad30, parse(Float64, tydata[59:62]))
            catch
                push!(short_rad30, missing)
            end

            if tydata == ""
                push!(jpfallpass, missing)
            else
                push!(jpfallpass, tydata[72])
            end
        end
        start = final
    end

    typhoon_data = DataFrame([
        int_id, datetime, yy, mm, dd, hh, storm_name, tygrade, lat, long, 
        pressure, speed, rad50_dir, long_rad50, 
        short_rad50, rad30_dir, long_rad30, 
        short_rad30, jpfallpass],
        [:international_id, :date_time, :year, :month, :day, :hour, :storm_name, :typhoon_grade, :latitude, :longitude,
            :pressure, :speed, :long_radius50_direction, :long_radius50, :short_radius50,
            :long_radius30_direction, :long_radius30, :short_radius30, :japan_fallpass
        ]
    )

    return typhoon_meta, typhoon_data
end

"""
    load(::Type{BestTrack{JMAData}})

Load the JMAData Best Track data.
"""
function load(::Type{BestTrack{JMAData}}; file::Union{Nothing,String}=nothing)
    meta = CSV.read(joinpath(JMA_BST_DB, "track_meta.csv"), DataFrame)
    data = CSV.read(joinpath(JMA_BST_DB, "track_data.csv"), DataFrame)
    return meta, data
end