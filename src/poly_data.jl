using HTTP

struct CountryPoly
    data::Symbol
end

function Base.get(::Type{CountryPoly}, country::Symbol)
    if country == :phl
        Base.download(CountryPoly(:phl))
    elseif country == :jpn
        Base.download(CountryPoly(:jpn))
    else 
        throw("Unknown input data, current choice is :phl only")
    end
end

function download_poly(poly_url::String, poly_folder::String, poly_name::String)
    try
        mkdir(poly_folder)
    catch end
    
    len_dir = false
    try 
        len_dir = length(readdir(poly_folder)) > 0 
    catch 
        len_dir = false
    end

    if len_dir
        @info "Skipping download of PHL polygon, local DB folder has the file already. Run delete!(CountryPoly, :phl) to delete and redownload again."
    else
        try
            mkdir(poly_folder)
        catch end
        HTTP.download(poly_url, joinpath(poly_folder, poly_name))
    end
end

function Base.download(file::CountryPoly)
    try mkdir(DB) catch end
    try mkdir(DB_POLY) catch end
    if (file.data == :phl)
        download_poly(PHL_POLY, PHL_GEOJSON, "phl_geo.json")
    elseif (file.data == :jpn)
        download_poly(JPN_POLY, JPN_GEOJSON, "jpn_geo.json")
    elseif (file.data == :khm)
        download_poly(KHM_POLY, KHM_GEOJSON, "khm_geo.json")
    elseif (file.data == :kor)
        download_poly(KOR_POLY, KOR_GEOJSON, "kor_geo.json")
    elseif (file.data == :lao)
        download_poly(LAO_POLY, LAO_GEOJSON, "lao_geo.json")
    elseif (file.data == :mmr)
        download_poly(MMR_POLY, MMR_GEOJSON, "mmr_geo.json")
    elseif (file.data == :mng)
        download_poly(MNG_POLY, MNG_GEOJSON, "mng_geo.json")
    elseif (file.data == :mys)
        download_poly(MYS_POLY, MYS_GEOJSON, "mys_geo.json")
    elseif (file.data == :phl)
        download_poly(PHL_POLY, PHL_GEOJSON, "phl_geo.json")
    elseif (file.data == :RUS)
        download_poly(RUS_POLY, RUS_GEOJSON, "rus_geo.json")
    elseif (file.data == :THA)
        download_poly(THA_POLY, THA_GEOJSON, "tha_geo.json")
    elseif (file.data == :TWN)
        download_poly(TWN_POLY, TWN_GEOJSON, "twn_geo.json")
    elseif (file.data == :VNM)
        download_poly(VNM_POLY, VNM_GEOJSON, "vnm_geo.json")
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