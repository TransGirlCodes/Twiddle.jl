#=
Nibble operations
=================

Copyright (c) 2017 Ben J. Ward & Luis Yanes

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
=#

"""
    enumerate_nibbles(abxor::UInt64)

Count the number of set bits in each nibble (aligned 4 bit segments) of an unsigned 64 bit integer.

E.g. An input of:

0100 0010 0001 0110 1100 1110 1101 1111

Would result in:

0001 0001 0001 0010 0010 0011 0011 0100

This is used to identify different occurances of certain bit patterns.
"""
@inline function enumerate_nibbles{T<:Unsigned}(x::T)
    x = x - ((x >> 1) & repeatbyte(T,0x55))
    return (x & repeatbyte(T,0x33)) + ((x >> 2) & repeatbyte(T,0x33))
end

"""
    count_nonzero_nibbles(x::UInt64)

Count the number of nibbles (aligned 4 bit segments) in an unsigned integer which have at least one
bit set.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 15.
"""
@inline function count_nonzero_nibbles(x::UInt64)
    out = UInt64(0)
    out |= x & 0x1111111111111111
    out |= (x & 0x2222222222222222) >> 1
    out |= (x & 0x4444444444444444) >> 2
    out |= (x & 0x8888888888888888) >> 3
    return count_ones(out)
end

"""
    count_zero_nibbles(x::UInt64)

Counts the number of nibbles (aligned 4 bit segments) in a UInt64 `x` that have all their bits unset i.e.
nibbles of 0000.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 1.
"""
@inline function count_zero_nibbles(x::UInt64)
    return 16 - count_nonzero_nibbles(x)
end

"""
    count_one_nibbles(x::UInt64)

Counts the number of nibbles (aligned 4 bit segments) in a UInt64 `x` that have all their bits set i.e.
all nibbles of 1111.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 4.
"""
@inline function count_one_nibbles(x::UInt64)
    out = x & 0x1111111111111111
    out &= (x & 0x2222222222222222) >> 1
    out &= (x & 0x4444444444444444) >> 2
    out &= (x & 0x8888888888888888) >> 3
    return count_ones(out)
end

"""
    nibble_mask(x::UInt64, value::UInt64)

Create a mask for the nibbles (aligned 4 bit segments) in a 64 bit integer `x`
that match a given value dictated by the pattern in `value`.
"""
@inline function nibble_mask(value::UInt64, x::UInt64)
    # XOR with the desired values. So matching nibbles will be 0000.
    x $= value
    # Horizontally OR the nibbles.
    x |= (x >> 1)
    x |= (x >> 2)
    # AND removes junk, we then widen x by multiplication and return
    # the inverse.
    x &= 0x1111111111111111
    x *= 15
    return ~x
end
