#=
Copyright (c) 2017 Ben J. Ward & Luis Yanes

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
=#

module TestTwiddle

using Twiddle, Base.Test

@testset "Enumerating nibbles" begin
    @test Twiddle.enumerate_nibbles(0x4216CEDF4216CEDF) == 0x1112233411122334
end

@testset "Counting nibbles" begin
    @test Twiddle.count_nonzero_nibbles(0x0F11F111F11111F1) == 15
    @test Twiddle.count_zero_nibbles(0x0F11F111F11111F1) == 1
    @test Twiddle.count_one_nibbles(0x0F11F111F11111F1) == 4
end

@testset "Counting bitpairs" begin
    @test Twiddle.count_zero_bitpairs(0x185DF69C185DF69C) == 6
    @test Twiddle.count_nonzero_bitpairs(0x185DF69C185DF69C) == 26
    @test Twiddle.count_one_bitpairs(0x185DF69C185DF69C) == 8
end

@testset "Masking nibbles" begin
    @test Twiddle.nibble_mask(0x185DF69C185DF69C, 0xDDDDDDDDDDDDDDDD) == 0x000F0000000F0000
end

end
