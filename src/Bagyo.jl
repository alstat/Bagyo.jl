module Bagyo

include("constants.jl")
include("country_data.jl")
include("utils.jl")
include("tracks_data.jl")
include("vis.jl")
include("poly_data.jl")

export delete!, load, plot, lines!
import Base: get
export AbstractCountry, BestTrack, CountryPoly
export BRN, CHN, JPN, KHM, KOR, LAO, MMR, MYS, PHL, PRK, RUS, THA, TWN, VNM
export BRN_AR_LON, CHN_AR_LON, JPN_AR_LON, KHM_AR_LON, KOR_AR_LON, LAO_AR_LON, 
    MMR_AR_LON, MYS_AR_LON, PHL_AR_LON, PRK_AR_LON, RUS_AR_LON, THA_AR_LON, TWN_AR_LON, VNM_AR_LON
export BRN_AR_LAT, CHN_AR_LAT, JPN_AR_LAT, KHM_AR_LAT, KOR_AR_LAT, LAO_AR_LAT, 
    MMR_AR_LAT, MYS_AR_LAT, PHL_AR_LAT, PRK_AR_LAT, RUS_AR_LAT, THA_AR_LAT, TWN_AR_LAT, VNM_AR_LAT

end # module
