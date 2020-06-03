using Documenter, Twiddle

makedocs(
    format = Documenter.HTML(),
    sitename = "Twiddle.jl",
    pages = [
        "Home" => "index.md",
        "Manual" => [
            "Counting bits" => "bitcounting.md",
            "Reference Manual" => "reference.md",
            "Working with Nibbles" => "nibbles.md",
            "Glossary" => "glossary.md"
        ]
    ],
    authors = "Ben J. Ward & Luis Yanes."
)
deploydocs(
    repo = "github.com/BenJWard/Twiddle.jl.git",
    deps = nothing,
    make = nothing,
    push_preview = true
)
