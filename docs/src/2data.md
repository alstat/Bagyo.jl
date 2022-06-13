# Best Track Data
This section will discuss the process of downloading and loading Best Track data both from JMA and IBTrACS.

## Downloading
To download the JMA Best Track data, simply run the following:
```@repl abc
using Bagyo
get(BestTrack, :jma)
```
As for IBTrACS, we use `:ibtracs` instead of `:jma`:
```@repl abc
get(BestTrack, :ibtracs)
```
Bagyo.jl only downloads the Western-North Pacific data of IBTrACS.

## Loading
To load the JMA Best Track data, we run the following:
```@repl abc
meta, data = load(BestTrack, :jma);
meta
data
```
Note that JMA returns two datasets, the `meta`data which contains the information about the storm, whose data is given by the `data` object above. For the description of the columns, please refer to [JMA documentation](https://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/Besttracks/e_format_bst.html).

As for IBTrACS, we only have one data.
```@repl abc
data = load(BestTrack, :ibtracs);
data
```
Please refer to [IBTrACS documentation](https://www.ncei.noaa.gov/sites/default/files/2021-07/IBTrACS_v04_column_documentation.pdf) for the description of the columns of the data above.

## Deleting Local DB
The downloaded data are saved in the local directory of your machine, and we have the following APIs for deleting the data.
```@repl abc
# delete only the Best Track of JMA Data folders and files
delete!(BestTrack, :jma)

# delete all JMA Data folders and files
delete!(:jma)
```
For IBTrACS, we have
```@repl abc
# delete only the Best Track of IBTrACS Data folders and files
delete!(BestTrack, :ibtracs)

# delete all IBTrACS Data folders and files
delete!(:ibtracs)
```