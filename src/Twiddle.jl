module Twiddle

"""
    repeatpattern{T<:Unsigned}(::Type{T}, pattern::Unsigned)

Repeats the bitpattern of the `pattern` integer throughout the an
Unsigned integer of type `T`. Note that this assumed the size of T (in bits)
is larger than that of the `pattern` integer.

This is useful for bit-twiddling code that is to work on any word size.

Let's use a very simple example to show why this is useful.
Let's say you have a function in which a byte is masked with a bitmask
0x33.

```julia
f(x::UInt8) = x & 0x33
```

Suppose you wanted this to work for any word size, so 8 bit, 16 bit, 32 bit, 64
bit, and 128 bit words? One way is to write `f` as a set of seperate methods:

```julia
f(x::UInt8) = x & 0x33
f(x::UInt16) = x & 0x3333
f(x::UInt32) = x & 0x33333333
f(x::UInt64) = x & 0x3333333333333333
f(x::UInt128) = x & 0x33333333333333333333333333333333
```

This is clearly not ideal, you would be writing out the same method multiplet
times, but with a differently sized literal for the mask each time.

Alternatively, you could write one parametric function with repeatbyte:

```julia
f2(x::T) where {T<:Unsigned} = x & Twiddle.repeatpattern(T, 0x33)
# Or a non-parametric version using `typeof`.
f3(x::Unsigned) = x & Twiddle.repeatpattern(typeof(x), 0x33)
```

You might expect this to be less efficient - `repeatpattern` uses several operations
to generate the values 0x33, 0x3333 and so on, whereas in the seperate methods,
those literal values are hard coded. However, thanks to constant folding during
compilation, those operations are done once at compilation time and so the
native instructions generated are identical. You can check this with `@code_llvm`
or `@code_native`.
"""
@inline function repeatpattern(::Type{T}, pattern::Unsigned) where {T<:Unsigned}
    return div(typemax(T), typemax(pattern)) * pattern
end

@inline function repeatbyte(::Type{T}, byte::UInt8) where {T<:Unsigned}
    Base.depwarn("repeatbyte is deprecated, use repeatpattern instead", :repeatbyte)
    return repeatpattern(T, byte)
end

"""
    mask{T<:Unsigned}(::Type{T}, n::Integer)

Creates a bit mask for given number of bits `n`.

The mask starts from the least significant bit, and end at bit `n`.

e.g:

```jldoctest
julia> Twiddle.mask(UInt64, 8)
0x00000000000000ff
```
"""
@inline mask(::Type{T}, n::Integer) where {T<:Unsigned} = (T(1) << n) - 0x1
@inline mask(n::Integer) = mask(UInt64, n)

"""
    swapbits{T<:Unsigned}(x::T, i::Integer, j::Integer)

Swap the i'th and j'th bits in an unsigned integer.
Note this uses zero based indexes for `i` and `j`.

E.g. to swap the LSB and MSB of a byte: 1001 1000 (0x98) -> 0001 1001 (0x19)

```@example
swapbits(0x98, 0, 7)
```
"""
@inline function swapbits(x::T, i::Integer, j::Integer) where {T<:Unsigned}
    ibit = (x >> i) & T(1)
    jbit = (x >> j) & T(1)
    ixj = ibit ⊻ jbit
    ixj = (ixj << i) | (ixj << j)
    return x ⊻ ixj
end

include("nibbles.jl")
include("bitpairs.jl")

end
