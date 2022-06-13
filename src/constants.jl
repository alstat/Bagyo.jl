const JMA_BT = "https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/Besttracks/bst_all.zip"
const IBTRACS_WP_BT = "https://www.ncei.noaa.gov/data/international-best-track-archive-for-climate-stewardship-ibtracs/v04r00/access/csv/ibtracs.WP.list.v04r00.csv"

const DB = joinpath(@__DIR__, "../db")
const DB_POLY = joinpath(DB, "poly")
const JMA_DB = joinpath(DB, "jma")
const JMA_BT_DB = joinpath(JMA_DB, "bt")
const IBTRACS_DB = joinpath(DB, "ibtracs")
const IBTRACS_BT_DB = joinpath(IBTRACS_DB, "bt")
const PHL = joinpath(@__DIR__, "../assets/phl_geo.json")
const ASIA = joinpath(@__DIR__, "../assets/asia_geo.json")

# URLs
PH_LOWRES_GEOJSON = "https://raw.githubusercontent.com/faeldon/philippines-json-maps/master/geojson/country/lowres/country.0.001.json";