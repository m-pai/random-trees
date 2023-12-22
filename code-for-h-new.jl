using IterTools

A = collect(IterTools.Iterators.product(1:2, 1:2, 1:4))

for i in eachindex(A)
    print(A[i])
end

B = [1:2, 1:2, 1:4]

A = collect(IterTools.Iterators.product(B...))

function h(lengths)
    k = []
    for i in lengths
        push!(k, (1:i)) 
    end
    A = collect(IterTools.Iterators.product(k...))
    return A
end