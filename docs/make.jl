using Documenter
using Bagyo

makedocs(
    sitename = "Bagyo",
    format = Documenter.HTML(),
    modules = [Bagyo]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
