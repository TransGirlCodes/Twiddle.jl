#=
Bitpair operations
==================

Copyright (c) 2017 Ben J. Ward & Luis Yanes

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
=#

@inline function count_nonzero_bitpairs(x::UInt64)
    out = x & 0x5555555555555555
    out |= (x & 0xAAAAAAAAAAAAAAAA) >> 1
    return count_ones(out)
end

@inline function count_zero_bitpairs(x::UInt64)
    return 32 - count_nonzero_bitpairs(x)
end

@inline function count_one_bitpairs(x::UInt64)
    out = x & 0x5555555555555555
    out &= (x & 0xAAAAAAAAAAAAAAAA) >> 1
    return count_ones(out)
end
