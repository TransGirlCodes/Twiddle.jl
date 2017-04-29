module Twiddle

export enumerate_nibbles,
    count_nonzero_nibbles,
    count_zero_nibbles,
    count_one_nibbles,
    nibble_mask,

    count_nonzero_bitpairs,
    count_zero_bitpairs,
    count_one_bitpairs

include("nibbles.jl")
include("bitpairs.jl")

end
