using EGM96
using Base.Test

tests = ["end_to_end"]
for t in tests
  include("$(t).jl")
end
