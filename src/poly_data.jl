using HTTP

struct CountryPoly
    data::Symbol
end

function Base.get(::Type{CountryPoly}, country::Symbol)
    if (country == :brn)
        Base.download(CountryPoly(:brn))
    elseif (country == :chn)
        Base.download(CountryPoly(:chn))
    elseif country == :jpn
        Base.download(CountryPoly(:jpn))
    elseif (country == :khm)
        Base.download(CountryPoly(:khm))
    elseif (country == :kor)
        Base.download(CountryPoly(:kor))
    elseif (country == :lao)
        Base.download(CountryPoly(:lao))
    elseif (country == :mmr)
        Base.download(CountryPoly(:mmr))
    elseif (country == :mys)
        Base.download(CountryPoly(:mys))
    elseif (country == :phl)
        Base.download(CountryPoly(:phl))
    elseif (country == :rus)
        Base.download(CountryPoly(:rus))
    elseif (country == :tha)
        Base.download(CountryPoly(:tha))
    elseif (country == :twn)
        Base.download(CountryPoly(:twn))
    elseif (country == :vnm)
        Base.download(CountryPoly(:vnm))
    else
        throw("Unknown country code name, see ISO3 codes. Otherwise, the country code is not part of South East Asian countries.")
    end
end

function download_poly(poly_folder::String, poly_url::String, poly_name::String)
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
        @info "Skipping download of $(uppercase(poly_name[1:3])) polygon, local DB folder has the file already. Run delete!(CountryPoly, :$(poly_name[1:3])) to delete and redownload again."
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
    if (file.data == :brn)
        download_poly(BRN_POLY, BRN_GEOJSON, "brn_geo.json")
    elseif (file.data == :chn)
        download_poly(CHN_POLY, CHN_GEOJSON, "chn_geo.json")
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
    elseif (file.data == :mys)
        download_poly(MYS_POLY, MYS_GEOJSON, "mys_geo.json")
    elseif (file.data == :phl)
        download_poly(PHL_POLY, PHL_GEOJSON, "phl_geo.json")
    elseif (file.data == :rus)
        download_poly(RUS_POLY, RUS_GEOJSON, "rus_geo.json")
    elseif (file.data == :tha)
        download_poly(THA_POLY, THA_GEOJSON, "tha_geo.json")
    elseif (file.data == :twn)
        download_poly(TWN_POLY, TWN_GEOJSON, "twn_geo.json")
    elseif (file.data == :vnm)
        download_poly(VNM_POLY, VNM_GEOJSON, "vnm_geo.json")
    else
        throw("Unknown input type $(file.data)")
    end
end

function Base.delete!(::Type{CountryPoly}, data::AbstractCountry)
    try
        _, cfolder, _ = countrydata(country)
        rm(cfolder, recursive=true)
        @info "$(uppercase(string(data))) polygon data successfully deleted."
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