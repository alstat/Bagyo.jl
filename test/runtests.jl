using Bagyo
using Dates
using Test

delete!(JMAData)
bst = BestTrack(JMAData())
download(bst)
meta, data = load(typeof(bst))
@test meta[!, :storm_name][2] == "GEORGIA"
@test data[!, :date_time][1] == DateTime(1951, 2, 19, 06)