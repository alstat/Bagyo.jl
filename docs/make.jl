using Documenter
using Bagyo

makedocs(
    sitename = "Bagyo.jl",
    format = Documenter.HTML(
        assets = ["assets/favicon.ico"]
    ),
    authors = "Al-Ahmadgaid B. Asaad",
    modules = [Bagyo],
    pages = [
        "Home" => "index.md",
        "Data" => "data.md",
        "API" => "api.md"
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/alstat/Bagyo.jl.git"
)