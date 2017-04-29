# Bitpair operations
# ==================
#
# Copyright Ben J. Ward and Luis Yanes.
# License is MIT.

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
