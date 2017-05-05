#=
Nibble operations
=================

Copyright (c) 2017 Ben J. Ward & Luis Yanes

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
=#

"""
    nibble_capacity{T<:Unsigned}(::Type{T})

Returns the number of nibbles that an unsigned integer of type `T`
holds. This is essentially twice the size of the type (in bytes).
"""
@inline function nibble_capacity{T<:Unsigned}(::Type{T})
    return sizeof(T) * 2
end

"""
    enumerate_nibbles{T<:Unsigned}(x::T)

Count the number of set bits in each nibble (aligned 4 bit segments) of an
unsigned integer `x`.

E.g. An input of:

0100 0010 0001 0110 1100 1110 1101 1111

Would result in:

0001 0001 0001 0010 0010 0011 0011 0100

This is used to identify different occurances of certain bit patterns.
"""
@inline function enumerate_nibbles{T<:Unsigned}(x::T)
    x = x - ((x >> 1) & repeatbyte(T, 0x55))
    return (x & repeatbyte(T, 0x33)) + ((x >> 2) & repeatbyte(T, 0x33))
end

"""
    count_nonzero_nibbles{T<:Unsigned}(x::T)

Count the number of nibbles (aligned 4 bit segments) in an unsigned integer `x`
which have at least one bit set.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 15.
"""
@inline function count_nonzero_nibbles{T<:Unsigned}(x::T)
    out = UInt64(0)
    out |= x & repeatbyte(T, 0x11)
    out |= (x & repeatbyte(T, 0x22)) >> 1
    out |= (x & repeatbyte(T, 0x44)) >> 2
    out |= (x & repeatbyte(T, 0x88)) >> 3
    return count_ones(out)
end

"""
    count_zero_nibbles{T<:Unsigned}(x::T)

Counts the number of nibbles (aligned 4 bit segments) in an unsigned integer `x`
that have all their bits unset i.e.
nibbles of 0000.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 1.
"""
@inline function count_zero_nibbles{T<:Unsigned}(x::T)
    return nibble_capacity(T) - count_nonzero_nibbles(x)
end

"""
    count_one_nibbles{T<:Unsigned}(x::T)

Counts the number of nibbles (aligned 4 bit segments) in an unsigned integer `x`
that have all their bits set i.e. counts all nibbles of 1111 in an integer.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 4.
"""
@inline function count_one_nibbles{T<:Unsigned}(x::T)
    out = x & repeatbyte(T, 0x11)
    out &= (x & repeatbyte(T, 0x22)) >> 1
    out &= (x & repeatbyte(T, 0x44)) >> 2
    out &= (x & repeatbyte(T, 0x88)) >> 3
    return count_ones(out)
end

"""
    nibble_mask{T<:Unsigned}(value::T, x::T)

Create a mask for the nibbles (aligned 4 bit segments) in an unsigned integer
`x` that filter nibbles matching the corresponding nibble in `value`.
"""
@inline function nibble_mask{T<:Unsigned}(value::T, x::T)
    # XOR with the desired values. So matching nibbles will be 0000.
    x $= value
    # Horizontally OR the nibbles.
    x |= (x >> 1)
    x |= (x >> 2)
    # AND removes junk, we then widen x by multiplication and return
    # the inverse.
    x &= repeatbyte(T, 0x11)
    x *= 0x0F
    return ~x
end
