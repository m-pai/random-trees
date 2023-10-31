using IterTools

A = collect(IterTools.Iterators.product(1:2, 1:2, 1:4))

for i in eachindex(A)
    print(A[i])
end

B = [1:2, 1:2, 1:4]

A = collect(IterTools.Iterators.product(B...))
