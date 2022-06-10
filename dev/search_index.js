var documenterSearchIndex = {"docs":
[{"location":"api/#API-References","page":"API","title":"API References","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"Modules = [Bagyo]","category":"page"},{"location":"api/#Bagyo.JMAData","page":"API","title":"Bagyo.JMAData","text":"JMAData(best_track::String)\n\nInstantiate JMADAta by specifying the url for the best_track data.\n\n\n\n\n\n","category":"type"},{"location":"api/#Bagyo.load-Tuple{Type{BestTrack{JMAData}}}","page":"API","title":"Bagyo.load","text":"load(::Type{BestTrack{JMAData}})\n\nLoad the JMAData Best Track data.\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.delete!-Tuple{Type{BestTrack{JMAData}}}","page":"API","title":"Base.delete!","text":"delete!(::Type{BestTrack{JMAData}})\n\nDelete the local JMAData Best Track files/folders\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.delete!-Tuple{Type{JMAData}}","page":"API","title":"Base.delete!","text":"delete!(::Type{JMAData})\n\nDelete the local JMAData files/folders\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.download-Tuple{BestTrack}","page":"API","title":"Base.download","text":"download(file::BestTrack)\n\nDownload the BestTrack data.\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.parse-Tuple{Type{BestTrack{JMAData}}}","page":"API","title":"Base.parse","text":"parse(::Type{BestTrack{JMAData}}, file::Union{Nothing,String}=nothing)\n\nParse the local JMAData Best Track file. If file is nothing, Bagyo.jl will  locate the file in its default DB folder.\n\n\n\n\n\n","category":"method"},{"location":"data/#JMA-Best-Track","page":"Data","title":"JMA Best Track","text":"","category":"section"},{"location":"data/","page":"Data","title":"Data","text":"This section will discuss the process of downloading and loading the JMA Best Track data.","category":"page"},{"location":"data/#Downloading","page":"Data","title":"Downloading","text":"","category":"section"},{"location":"data/","page":"Data","title":"Data","text":"To download the JMA Best Track data, we run the following:","category":"page"},{"location":"data/","page":"Data","title":"Data","text":"using Bagyo\nbst = BestTrack(JMAData())\ndownload(bst)","category":"page"},{"location":"data/#Loading","page":"Data","title":"Loading","text":"","category":"section"},{"location":"data/","page":"Data","title":"Data","text":"To download the JMA Best Track data, we run the following:","category":"page"},{"location":"data/","page":"Data","title":"Data","text":"meta, data = load(BestTrack{JMAData}) # or load(typeof(bst));\nmeta\ndata","category":"page"},{"location":"data/#Deleting-Local-DB","page":"Data","title":"Deleting Local DB","text":"","category":"section"},{"location":"data/","page":"Data","title":"Data","text":"To delete the local DB for storing the downloaded files, run the following:","category":"page"},{"location":"data/","page":"Data","title":"Data","text":"# delete only the Best Track of JMAData folders and files\ndelete!(BestTrack{JMAData})\n\n# delete all JMAData folders and files\ndelete!(JMAData)","category":"page"},{"location":"#Bagyo.jl","page":"Home","title":"Bagyo.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Bagyo.jl is a package for extraction and analysis of typhoon and weather data affecting the Philippine Area of Responsibility (PAR).","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To install the package, run the following:","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using Pkg\njulia> Pkg.add(\"Bagyo\")","category":"page"},{"location":"#Outline","page":"Home","title":"Outline","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\n    \"api.md\"\n]\nDepth = 2","category":"page"}]
}
