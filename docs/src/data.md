# Best Track Data
This section will discuss the process of downloading and loading Best Track data both from JMA and IBTrACS.

## Downloading
To download the JMA Best Track data, simply run the following:
```@repl abc
using Bagyo
get(BestTrack, :jma)
```
As for IBTrACS, replace `:jma` with `:ibtracs`:
```@repl abc
get(BestTrack, :ibtracs)
```
Bagyo.jl only downloads the Western-North Pacific data of IBTrACS.

## Loading
To load the JMA Best Track data, run the following:
```@repl abc
meta, data = load(BestTrack, :jma);
meta
data
```
Note that JMA returns two datasets, the `meta`data which contains the information about the storm, and the corresponding `data` of the storm tracks. For the description of the columns, please refer to [JMA documentation](https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/Besttracks/e_format_bst.html).

As for IBTrACS, there is only one data containing all the information about the cyclone.
```@repl abc
data = load(BestTrack, :ibtracs);
data
```
Please refer to [IBTrACS documentation](https://www.ncei.noaa.gov/sites/default/files/2021-07/IBTrACS_v04_column_documentation.pdf) for the description of the columns of the data above.

## Deleting
The downloaded data are saved in the local directory of your machine, and the following APIs helps on managing this data, in particular for deleting the said data.
```@repl abc
# delete only the Best Track of JMA Data
delete!(BestTrack, :jma)

# delete all JMA Data folders and files
delete!(:jma)
```
For IBTrACS,
```@repl abc
# delete only the Best Track of IBTrACS Data
delete!(BestTrack, :ibtracs)

# delete all IBTrACS Data folders and files
delete!(:ibtracs)
```