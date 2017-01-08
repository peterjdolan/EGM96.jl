module EGM96

    if isfile(joinpath(dirname(@__FILE__),"..","deps","deps.jl"))
        include("../deps/deps.jl")
    else
        error("EGM96 not properly installed. Please run Pkg.build(\"EGM96\")")
    end
    
    export undulation
    export legendre_cos
    include("f477.jl")
    include("legendre_cos.jl")
end
