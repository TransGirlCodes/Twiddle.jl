#=
Bit counting operations
=======================

Copyright (c) 2017 Ben J. Ward & Luis Yanes

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
=#

@inline function count_nonzero_bitpairs(x::Unsigned)
    return count_ones((x | (x >> 1)) & repeatpattern(typeof(x), 0x55))
end

@inline function count_00_bitpairs(x::Unsigned)
    return count_11_bitpairs(~x)
end

function count_zero_bitpairs(x::Unsigned)
    Base.depwarn("count_zero_bitpairs is deprecated, use count_00_bitpairs instead", :count_zero_bitpairs)
    return count_00_bitpairs(x)
end

@inline function count_11_bitpairs(x::Unsigned)
    return count_ones((x & (x >> 1)) & repeatpattern(typeof(x), 0x55))
end

function count_one_bitpairs(x::Unsigned)
    Base.depwarn("count_one_bitpairs is deprecated, use count_11_bitpairs instead", :count_one_bitpairs)
    return count_11_bitpairs(x)
end



"""
    count_nonzero_nibbles(x::Unsigned)

Count the number of nibbles (aligned 4 bit segments) in an unsigned integer `x`
which have at least one bit set.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 15.
"""
@inline function count_nonzero_nibbles(x::Unsigned)
    return count_ones((x | (x >> 1) | (x >> 2) | (x >> 3)) & repeatpattern(typeof(x), 0x11))
end

"""
    count_zero_nibbles(x::Unsigned)

Counts the number of nibbles (aligned 4 bit segments) in an unsigned integer `x`
that have all their bits unset i.e.
nibbles of 0000.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 1.
"""
@inline function count_zero_nibbles(x::Unsigned)
    return count_one_nibbles(~x)
end

"""
    count_one_nibbles(x::Unsigned)

Counts the number of nibbles (aligned 4 bit segments) in an unsigned integer `x`
that have all their bits set i.e. counts all nibbles of 1111 in an integer.

E.g. An input of:

0x0F11F111F11111F1

Would give the answer: 4.
"""
@inline function count_one_nibbles(x::Unsigned)
    return count_ones(x & (x >> 1) & (x >> 2) & (x >> 3) & repeatpattern(typeof(x), 0x11))
end