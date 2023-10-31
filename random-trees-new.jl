using Random
using Printf
using Graphs
using GraphPlot
using Catlab
using Catlab.Graphs.BasicGraphs
using Catlab.CategoricalAlgebra
using DataFrames

# Generating random trees
n = 5
T = Graphs.Graph(n)

function print_tree_edges(prufer, n)
    edgelist = Vector{Tuple{Int, Int}}()
    vertex_set = zeros(Int, n)
    
    # Number of occurrences of vertex in code
    for p in prufer
        vertex_set[p] += 1
    end

    println("The edge set E(G) is:")

    # Find the smallest label not present in prufer[].
    for p in prufer
        for j in 1:n
            # If j is not present in prufer set
            if vertex_set[j] == 0
                # Remove from Prufer set and print pair
                vertex_set[j] = -1
                print(@sprintf "(%d, %d) " j p)
                Graphs.add_edge!(T, j, p)
                push!(edgelist, (j,p))
                vertex_set[p] -= 1
                break
            end
        end
    end
    
    j=false

    e=0
    f=0
    
    for i in 1:n
        if vertex_set[i] == 0 && !j
            print(@sprintf "(%d, " i)
            e = i
            j = true
        elseif vertex_set[i] == 0 && j
            print(@sprintf "%d)" i)
            f = i
            break
        end
    end

    Graphs.add_edge!(T,e,f)
    push!(edgelist, (e,f))
    return edgelist

end

function generate_random_tree(n)
    arr = rand(1:n-1, n-2)
    println(arr)
    
    edgelist = print_tree_edges(arr,n)
    return edgelist
end

println(generate_random_tree(5))