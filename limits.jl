include("Decompositions.jl")
using Catlab.CategoricalAlgebra

include("random-trees-new.jl")
include("graph-gen-new.jl")
include("code-for-h-new.jl")
include("decomp.jl")

function apex(sol)
    arr = []
    for i in sol 
        push!(arr, Catlab.CategoricalAlgebra.FreeDiagrams.apex(Catlab.CategoricalAlgebra.Limits.limit(i)))
    end
    return arr
end