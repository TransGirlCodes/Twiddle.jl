using Documenter, Twiddle

makedocs(
    format = :html,
    sitename = "Twiddle.jl",
    pages = [
        "Home" => "index.md",
        "Manual" => [
            "Counting bits" => "bitcounting.md",
            "Reference Manual" => "reference.md",
            "Working with Nibbles" => "nibbles.md",
            "Glossary" => "glossary.md"
        ]
    ]
)
deploydocs(
    repo = "github.com/Ward9250/Twiddle.jl.git",
    julia = "1.0",
    osname = "linux",
    target = "build",
    deps = nothing,
    make = nothing
)
