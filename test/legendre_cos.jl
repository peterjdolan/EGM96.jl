@testset "Legendre function implementation tests" begin
    @testset "Base cases" begin
        @test_approx_eq_eps legendre_cos(0, 0, 0) 1 1e-9
        @test_approx_eq_eps legendre_cos(1, 0, pi/4) 1 1e-9
    end

    @testset "Jacobi.jl reference tests with order 0, degree 2" begin
        # Reference value computed using Jacobi.jl -- jacobi(cos(0), 2)
        @test_approx_eq_eps legendre_cos(0, 2, 0) 1.0 1e-9
        @test_approx_eq_eps legendre_cos(0, 2, pi/6) 0.625 1e-9
        @test_approx_eq_eps legendre_cos(0, 2, 0.1) 0.9850499333809315 1e-9
    end

    @testset "Jacobi.jl reference tests with order 0, degree 5" begin
        @test_approx_eq_eps legendre_cos(0, 5, 0) 1.0 1e-9
        @test_approx_eq_eps legendre_cos(0, 5, pi/6) -0.2232721744131756 1e-9
        @test_approx_eq_eps legendre_cos(0, 5, 0.1) 0.9263640896627391 1e-9
    end
end
