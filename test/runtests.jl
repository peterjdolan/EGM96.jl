using EGM96
using Base.Test

tests = ["end_to_end", "legendre_cos"]
for t in tests
  include("$(t).jl")
end
