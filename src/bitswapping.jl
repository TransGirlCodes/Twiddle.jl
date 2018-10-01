
"""
    xor_swap(a, b)

This is an old trick to exchange the values of variables a and b without using
an additional temporary variable.
"""
macro xor_swap(a, b)
    esc(:($a ⊻= $b; $b ⊻= $a; $a ⊻= $b)) 
end

"""
    swapbits{T<:Unsigned}(x::T, i::Integer, j::Integer)

Swap the i'th and j'th bits in an unsigned integer.
Note this uses zero based indexes for `i` and `j`.

E.g. to swap the LSB and MSB of a byte: 1001 1000 (0x98) -> 0001 1001 (0x19)

```@example
swapbits(0x98, 0, 7)
```
"""
@inline function swapbits(x::T, i::Integer, j::Integer) where {T <: Unsigned}
    ibit = (x >> i) & T(1)
    jbit = (x >> j) & T(1)
    ixj = ibit ⊻ jbit
    ixj = (ixj << i) | (ixj << j)
    return x ⊻ ixj
end

@inline function swap_odd_even_bits(x::Unsigned)
    msk = repeatpattern(typeof(x), 0x55)
    return ((x >> 1) & msk) | ((x & msk) << 1)
end

@inline function swap_consecutive_bitpairs(x::Unsigned)
    msk = repeatpattern(typeof(x), 0x33)
    return ((x >> 2) & msk) | ((x & msk) << 2)
end

@inline function swap_nibbles(x::Unsigned)
    msk = repeatpattern(typeof(x), 0x0F)
    return ((x >> 4) & msk) | ((x & msk) << 4)
end

@inline function swap_bytes(x::Unsigned)
    msk = repeatpattern(typeof(x), 0x00FF)
    return ((x >> 8) & msk) | ((x & msk) << 8)
end

@inline function swap_bytepairs(x::Unsigned)
    msk = repeatpattern(typeof(x), 0x0000FFFF)
    return ((x >> 16) & msk) | ((x & msk) << 16)
end

@inline function swap_32bitpairs(x::Unsigned)
    msk = repeatpattern(typeof(x), 0x00000000FFFFFFFF)
    return ((x >> 32) & msk) | ((x & msk) << 32)
end

