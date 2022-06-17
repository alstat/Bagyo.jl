abstract type AbstractCountry end

macro country(iso3, lon_0, lat_0, lonlims, latlims, area_monitored)
    esc(quote
        mutable struct $iso3 <: AbstractCountry
            lon_0::Int64
			lat_0::Int64
			lonlims::Tuple
			latlims::Tuple
			area_monitored::Tuple
        end
        
        $iso3() = $iso3($lon_0, $lat_0, $lonlims, $latlims, $area_monitored)
    end)
end

const BRN_AR_LON = [110, 110, 120, 120, 110]; 
const BRN_AR_LAT = [8, 0, 0, 8, 8];
const CHN_AR_LON = [105, 105, 130, 130, 105]; 
const CHN_AR_LAT = [45, 15, 15, 45, 45];
const JPN_AR_LON = [125, 125, 150, 150, 125]; 
const JPN_AR_LAT = [50, 20, 20, 50, 50];
const KHM_AR_LON = [100, 100, 112, 112, 100]; 
const KHM_AR_LAT = [18, 5, 5, 18, 18];
const KOR_AR_LON = [120, 120, 132, 132, 120]; 
const KOR_AR_LAT = [43, 26, 26, 43, 43];
const PRK_AR_LON = [120, 120, 132, 132, 120]; 
const PRK_AR_LAT = [48, 31, 31, 48, 48];
const LAO_AR_LON = [97, 97, 113, 113, 97]; 
const LAO_AR_LAT = [25, 7, 7, 25, 25];
const MMR_AR_LON = [90, 90, 115, 115, 90]; 
const MMR_AR_LAT = [30, 13, 13, 30, 30];
const MYS_AR_LON = [97, 97, 125, 125, 97]; 
const MYS_AR_LAT = [10, -2, -2, 10, 10];
const PHL_AR_LON = [115, 135, 135, 120, 120, 115, 115]    
const PHL_AR_LAT = [5, 5, 25, 25, 21, 15, 5]
const RUS_AR_LON = [127, 127, 180, 180, 127]; 
const RUS_AR_LAT = [63, 37, 37, 63, 63];
const THA_AR_LON = [90, 90, 120, 120, 90]; 
const THA_AR_LAT = [23, 3, 3, 23, 23];
const TWN_AR_LON = [115, 115, 130, 130, 115]; 
const TWN_AR_LAT = [30, 18, 18, 30, 30];
const VNM_AR_LON = [100, 100, 105, 115, 120, 120, 118, 116, 100]; 
const VNM_AR_LAT = [23, 11, 4, 4, 11, 20, 20, 23, 23];

@country BRN 150 10 (100, 185) (-5, 55) (BRN_AR_LON, BRN_AR_LAT)
@country CHN 150 10 (100, 185) (-5, 55) (CHN_AR_LON, CHN_AR_LAT)
@country JPN 150 10 (100, 185) (-5, 55) (JPN_AR_LON, JPN_AR_LAT)
@country KHM 150 10 (100, 185) (-5, 55) (KHM_AR_LON, KHM_AR_LAT)
@country KOR 150 10 (100, 185) (-5, 55) (KOR_AR_LON, KOR_AR_LAT)
@country LAO 150 10 (100, 185) (-5, 55) (LAO_AR_LON, LAO_AR_LAT)
@country MMR 150 10 (100, 185) (-5, 55) (MMR_AR_LON, MMR_AR_LAT)
@country MYS 150 10 (100, 185) (-5, 55) (MYS_AR_LON, MYS_AR_LAT)
@country PHL 150 10 (100, 185) (-5, 55) (PHL_AR_LON, PHL_AR_LAT)
@country PRK 150 10 (100, 185) (-5, 55) (PRK_AR_LON, PRK_AR_LAT)
@country RUS 150 10 (100, 185) (-5, 55) (RUS_AR_LON, RUS_AR_LAT)
@country THA 150 10 (100, 185) (-5, 55) (THA_AR_LON, THA_AR_LAT)
@country TWN 150 10 (100, 185) (-5, 55) (TWN_AR_LON, TWN_AR_LAT)
@country VNM 150 10 (100, 185) (-5, 55) (VNM_AR_LON, VNM_AR_LAT)

function countrydata(country::AbstractCountry)
	if country isa BRN
		return (:brn, BRN_POLY, "brn_geo.json")
	elseif country isa CHN
		return (:chn, CHN_POLY, "chn_geo.json")
	elseif country isa JPN
		return (:jpn, JPN_POLY, "jpn_geo.json")
	elseif country isa KHM
		return (:khm, KHM_POLY, "khm_geo.json")
	elseif country isa KOR
		return (:kor, KOR_POLY, "kor_geo.json")
	elseif country isa LAO
		return (:lao, LAO_POLY, "chn_geo.json")
	elseif country isa MMR
		return (:mmr, MMR_POLY, "mmr_geo.json")
	elseif country isa MYS
		return (:mys, MYS_POLY, "mys_geo.json")
	elseif country isa PHL
		return (:phl, PHL_POLY, "phl_geo.json")
	elseif country isa PRK
		return (:prk, PRK_POLY, "prk_geo.json")
	elseif country isa RUS
		return (:rus, RUS_POLY, "rus_geo.json")
	elseif country isa THA
		return (:tha, THA_POLY, "tha_geo.json")
	elseif country isa TWN
		return (:twn, TWN_POLY, "twn_geo.json")
	elseif country isa VNM
		return (:vnm, VNM_POLY, "vnm_geo.json")
	else
		throw("Unknown input country")
	end
end
