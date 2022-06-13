using Bagyo
using Dates
using Test

delete!(BestTrack, :jma)
delete!(:jma)
delete!(BestTrack, :ibtracs)
delete!(:ibtracs)
get(BestTrack, :jma)
get(BestTrack, :jma) # it should skip the download
get(BestTrack, :ibtracs)
get(BestTrack, :ibtracs) # it should skip the download
meta, data = load(BestTrack, :jma)
@test meta[!, :STORM_NAME][2] == "GEORGIA"
@test data[!, :DATE_TIME][1] == DateTime(1951, 2, 19, 06)

data = load(BestTrack, :ibtracs)
@test data[1, :ISO_TIME] == "1884-06-24 16:00:00"
@test data[1, :LAT] == 16.5
@test data[1, :LON] == 124.0