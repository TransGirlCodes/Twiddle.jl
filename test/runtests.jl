module TestTwiddle

using Twiddle, Base.Test

@testset "Enumerating nibbles" begin
    @test Twiddle.enumerate_nibbles(0x4216CEDF4216CEDF) == 0x1112233411122334
end

end
