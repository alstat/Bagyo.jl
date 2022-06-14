const JMA_BT = "https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/Besttracks/bst_all.zip"
const IBTRACS_WP_BT = "https://www.ncei.noaa.gov/data/international-best-track-archive-for-climate-stewardship-ibtracs/v04r00/access/csv/ibtracs.WP.list.v04r00.csv"

const DB = joinpath(@__DIR__, "../db")
const DB_POLY = joinpath(DB, "poly")
const JMA_DB = joinpath(DB, "jma")
const JMA_BT_DB = joinpath(JMA_DB, "bt")
const IBTRACS_DB = joinpath(DB, "ibtracs")
const IBTRACS_BT_DB = joinpath(IBTRACS_DB, "bt")
const PHL_POLY = joinpath(DB_POLY, "phl")
const JPN_POLY = joinpath(DB_POLY, "jpn")
const ASIA_POLY = joinpath(@__DIR__, "../assets/asia_geo.json")

# URLs
CHN_GEOJSON = "https://raw.githubusercontent.com/alstat/BagyoData/main/CHN/chn_geo.json";
PHL_GEOJSON = "https://raw.githubusercontent.com/alstat/BagyoData/main/PHL/phl_geo.json";
JPN_GEOJSON = "https://raw.githubusercontent.com/alstat/BagyoData/main/JPN/jpn_geo.json";