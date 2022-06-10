# JMA Best Track
This section will discuss the process of downloading and loading the JMA Best Track data.

## Downloading
To download the JMA Best Track data, we run the following:
```@repl abc
using Bagyo
bst = BestTrack(JMAData())
download(bst)
```
## Loading
To download the JMA Best Track data, we run the following:
```@repl abc
meta, data = load(BestTrack{JMAData}) # or load(typeof(bst));
meta
data
```
## Deleting Local DB
To delete the local DB for storing the downloaded files, run the following:
```@repl abc
# delete only the Best Track of JMAData folders and files
delete!(BestTrack{JMAData})

# delete all JMAData folders and files
delete!(JMAData)
```