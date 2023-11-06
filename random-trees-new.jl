using Random
using Catlab

# Generating random trees


function print_tree_edges(prufer, n)
    edgelist = Vector{Tuple{Int, Int}}()
    vertex_set = zeros(Int, n)
    
    # Number of occurrences of vertex in code
    for p in prufer
        vertex_set[p] += 1
    end

    # Find the smallest label not present in prufer[].
    for p in prufer
        for j in 1:n
            # If j is not present in prufer set
            if vertex_set[j] == 0
                # Remove from Prufer set and print pair
                vertex_set[j] = -1
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
            e = i
            j = true
        elseif vertex_set[i] == 0 && j
            f = i
            break
        end
    end

    push!(edgelist, (e,f))
    return edgelist

end

function generate_random_tree(n)
    arr = rand(1:n-1, n-2)
    edgelist = print_tree_edges(arr,n)
    return edgelist
end

function rand_tree(m) 
    T = Catlab.Graphs.BasicGraphs.Graph(m)
    for i in generate_random_tree(m)
        Catlab.Graphs.BasicGraphs.add_edge!(T, i[1], i[2])
    end
    return T
end