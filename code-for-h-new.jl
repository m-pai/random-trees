using IterTools

function h(lengths)
    k = []
    for i in lengths
        push!(k, (1:i)) 
    end
    A = collect(IterTools.Iterators.product(k...))
    return A
end