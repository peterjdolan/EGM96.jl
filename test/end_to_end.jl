@testset "EGM96 End to End Tests" begin
    @testset "EGM96 F477 Reference Implementation Tests" begin
        @test_approx_eq_eps undulation(38.6281550, 269.7791550) -31.629 1e-3
        @test_approx_eq_eps undulation(-14.6212170, 305.0211140) -2.966 1e-3
        @test_approx_eq_eps undulation(46.8743190, 102.4487290) -43.572 1e-3
        @test_approx_eq_eps undulation(-23.6174460, 133.8747120) 15.868 1e-3
        @test_approx_eq_eps undulation(38.6254730, 359.9995000) 50.065 1e-3
        @test_approx_eq_eps undulation(-.4667440, .0023000) 17.330 1e-3
    end
end
