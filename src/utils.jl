using ZipFile

function unzip(file, exdir="")
    @info "Unzipping file"
    file_fullpath = isabspath(file) ?  file : joinpath(pwd(), file)
    basepath = dirname(file_fullpath)
    outpath = (exdir == "" ? basepath : (isabspath(exdir) ? exdir : joinpath(pwd(), exdir)))
    isdir(outpath) ? "" : mkdir(outpath)
    zarchive = ZipFile.Reader(file_fullpath)
    for f in zarchive.files
        full_filepath = joinpath(outpath, f.name)
        @info "Zip file path " * full_filepath
        if (endswith(f.name,"/") || endswith(f.name,"\\"))
            try
                mkdir(full_filepath)
            catch
                rm(full_filepath, recursive=true)
                mkdir(full_filepath)
            end
        else
            write(full_filepath, read(f))
        end
    end
    close(zarchive)
    @info "Deleting zip file"
    rm(file)
end