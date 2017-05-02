using Documenter, Twiddle

makedocs()
deploydocs(
    deps = Deps.pip("mkdocs", "pygments", "mkdocs-material"),
    repo = "github.com/Ward9250/Twiddle.jl.git",
    julia = "0.5",
    osname = "linux",
)
