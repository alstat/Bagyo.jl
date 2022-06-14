var documenterSearchIndex = {"docs":
[{"location":"vis/#Visualization","page":"Data Visualization","title":"Visualization","text":"","category":"section"},{"location":"vis/","page":"Data Visualization","title":"Data Visualization","text":"This section will illustrate how to use some visualization API of Bagyo.jl. This is currently at early stage, and further customization on the target countries will be added, at the moment we have Philippine Area of Responsibility (PAR) as the region of interest.","category":"page"},{"location":"vis/","page":"Data Visualization","title":"Data Visualization","text":"using Bagyo\nusing Colors\nusing Makie\nf0, a0 = plot(PHL(), :stere);\nf0","category":"page"},{"location":"vis/","page":"Data Visualization","title":"Data Visualization","text":"<img src=\"https://github.com/alstat/Bagyo.jl/raw/master/docs/src/assets/phl0.svg\" align=\"center\"/>","category":"page"},{"location":"vis/","page":"Data Visualization","title":"Data Visualization","text":"To plot the JMA Best Tracks, we use the lines! function as follows:","category":"page"},{"location":"vis/","page":"Data Visualization","title":"Data Visualization","text":"get(BestTrack, :jma)\nmeta, data = load(BestTrack, :jma);\nf1, a1 = with_theme(theme_dark(), resolution=(850, 650)) do\n\tplot(PHL(), :stere);\nend;\nlines!(a1, data, :jma, linewidth=1, color=RGBAf(1.0, 0.678431, 0.0, 0.15))\na1.title = \"Tropical Cyclone in Western-North Pacific\";\na1.titlesize = 25;\na1.titlealign = :left;\na1.xlabel = \"Longitude\";\na1.ylabel = \"Latitude\";\na1.xlabelpadding = -30;\na1.ylabelpadding = 15;\na1.xtickformat = \"\\n\\n{:d}ᵒ\"; \na1.ytickformat = \"{:d}ᵒ \";\nf1","category":"page"},{"location":"vis/","page":"Data Visualization","title":"Data Visualization","text":"<img src=\"https://github.com/alstat/Bagyo.jl/raw/master/docs/src/assets/phl1.svg\" align=\"center\"/>","category":"page"},{"location":"api/#API-References","page":"API","title":"API References","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"Modules = [Bagyo]","category":"page"},{"location":"api/#Bagyo.JMAData","page":"API","title":"Bagyo.JMAData","text":"JMAData(best_track::String)\n\nInstantiate JMAData by specifying the url for the best_track data.\n\n\n\n\n\n","category":"type"},{"location":"api/#Bagyo.load-Tuple{Type{BestTrack}, Symbol}","page":"API","title":"Bagyo.load","text":"load(::Type{BestTrack}, data::Symbol)\n\nLoad the Best Track data.\n\n\n\n\n\n","category":"method"},{"location":"api/#Bagyo.parse_track-Tuple{Type{BestTrack{Bagyo.JMAData}}}","page":"API","title":"Bagyo.parse_track","text":"parse_track(::Type{BestTrack{JMAData}}, file::Union{Nothing,String}=nothing)\n\nParse the local JMAData Best Track file. If file is nothing, Bagyo.jl will  locate the file in its default DB folder.\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.delete!-Tuple{Symbol}","page":"API","title":"Base.delete!","text":"delete!(data::Symbol)\n\nDelete all files/folders (Best Tracks, Sea Surface Temperatures, etc.) of local data. data takes :jma as input.\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.delete!-Tuple{Type{BestTrack}, Symbol}","page":"API","title":"Base.delete!","text":"delete!(::Type{BestTrack}, data::Symbol)\n\nDelete the local data for Best Track files/folders. data takes :jma as input.\n\n\n\n\n\n","category":"method"},{"location":"api/#Base.get-Tuple{Type{BestTrack}, Symbol}","page":"API","title":"Base.get","text":"get(data::BestTrack)\n\nDownload the BestTrack data.\n\n\n\n\n\n","category":"method"},{"location":"data/#Best-Track-Data","page":"Data Extraction","title":"Best Track Data","text":"","category":"section"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"This section will discuss the process of downloading and loading Best Track data both from JMA and IBTrACS.","category":"page"},{"location":"data/#Downloading","page":"Data Extraction","title":"Downloading","text":"","category":"section"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"To download the JMA Best Track data, simply run the following:","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"using Bagyo\nget(BestTrack, :jma)","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"As for IBTrACS, we use :ibtracs instead of :jma:","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"get(BestTrack, :ibtracs)","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"Bagyo.jl only downloads the Western-North Pacific data of IBTrACS.","category":"page"},{"location":"data/#Loading","page":"Data Extraction","title":"Loading","text":"","category":"section"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"To load the JMA Best Track data, we run the following:","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"meta, data = load(BestTrack, :jma);\nmeta\ndata","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"Note that JMA returns two datasets, the metadata which contains the information about the storm, whose data is given by the data object above. For the description of the columns, please refer to JMA documentation.","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"As for IBTrACS, we only have one data.","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"data = load(BestTrack, :ibtracs);\ndata","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"Please refer to IBTrACS documentation for the description of the columns of the data above.","category":"page"},{"location":"data/#Deleting-Local-DB","page":"Data Extraction","title":"Deleting Local DB","text":"","category":"section"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"The downloaded data are saved in the local directory of your machine, and we have the following APIs for deleting the data.","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"# delete only the Best Track of JMA Data folders and files\ndelete!(BestTrack, :jma)\n\n# delete all JMA Data folders and files\ndelete!(:jma)","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"For IBTrACS, we have","category":"page"},{"location":"data/","page":"Data Extraction","title":"Data Extraction","text":"# delete only the Best Track of IBTrACS Data folders and files\ndelete!(BestTrack, :ibtracs)\n\n# delete all IBTrACS Data folders and files\ndelete!(:ibtracs)","category":"page"},{"location":"#Welcome-to-Bagyo.jl-Documentation","page":"Home","title":"Welcome to Bagyo.jl Documentation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: codecov) (Image: MIT License)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Bagyo.jl is a package for extraction and analysis of typhoon and climate data in the WNP (Western-North Pacific) region (at least for now). As such, it is a very specific package focusing only on WNP. Therefore, in terms of data, the main interest are those commonly used in literatures for understanding the cyclones in the said region, which covers the Philippine Area of Responsibility (PAR), and other neighboring South-East Asian regions. These data are usually from the Japan Meteorological Agency (JMA), Regional Specialized Meteorological Center (RSMC) Tokyo - Typhoon Center, Joint Typhoon Warning Center (JTWC), and the consolidations of all tracks by the International Best Track Archive for Climate Stewardship (IBTrACS). Bagyo.jl currently offers JMA and IBTrACS data, but skips JTWC as it is not timely released (last updated 2020). The package is actively being developed and functionalities for downloading, loading, visualizing and modeling the data are expected to be added.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Lastly, \"typhoon\" and \"storm\" in Filipino are generally referred to as \"bagyo.\"","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To install the package, run the following:","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using Pkg\njulia> Pkg.add(\"Bagyo\")","category":"page"},{"location":"#Outline","page":"Home","title":"Outline","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\n    \"data.md\",\n    \"vis.md\"\n    \"api.md\"\n]\nDepth = 2","category":"page"}]
}
