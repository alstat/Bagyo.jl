using HTTP

struct CountryPoly
    data::Symbol
end

function Base.get(::Type{CountryPoly}, country::Symbol)
    if country == :phl
        Base.download(CountryPoly(:phl))
    else 
        throw("Unknown input data, current choice is :phl only")
    end
end

function Base.download(file::CountryPoly)
    try mkdir(DB) catch end
    try mkdir(DB_POLY) catch end
    if (file.data == :phl)
        try
            mkdir(PHL_POLY)
        catch end
        
        len_dir = false
        try 
            len_dir = length(readdir(PHL_POLY)) > 0 
        catch 
            len_dir = false
        end

        if len_dir
            @info "Skipping download of PHL polygon, local DB folder has the file already. Run delete!(CountryPoly, :phl) to delete and redownload again."
        else
            try
                mkdir(PHL_POLY)
            catch end
            HTTP.download(PH_LOWRES_GEOJSON, joinpath(PHL_POLY, "phl_geo.json"))
        end
    else
        throw("Unknown input type $(file.data)")
    end
end

function Base.delete!(::Type{CountryPoly}, data::Symbol)
    try
        if data == :phl
            rm(PHL_POLY, recursive=true)
            @info "$(uppercase(string(data))) polygon data successfully deleted."
        else
            throw("Unknown input data, choices is :phl only.")
        end
    catch
        @info "Skipping deletion of $(uppercase(string(data))) polygon data folder since it does not exists."
    end
end

function Base.delete!(::Type{CountryPoly})
    try
        rm(DB_POLY, recursive=true)
        @info "All polygon data successfully deleted."
    catch
        @info "Skipping deletion of all polygon data folder since it does not exists."
    end
end