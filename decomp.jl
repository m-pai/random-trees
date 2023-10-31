using Catlab
using Graphs
using Random
using Combinatorics
using Printf

decomp = []

# generating graphs on size n
ngs = reflexive_conv(Graph(2))

# generating random tree of size m
T = generate_random_tree(5)

key = [1:length(ngs)]
gs =  rand(Dict(zip(key, ngs)))[2]