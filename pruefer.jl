using Random

function print_tree_edges(prufer, n)
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
                
                vertex_set[p] -= 1
                break
            end
        end
    end
    
    j=false
    
    for i in 1:n
        if vertex_set[i] == 0 && !j
            print(@sprintf "(%d, " i)
            j = true
        elseif vertex_set[i] == 0 && j
            print(@sprintf "%d)" i)
            break
        end
    end
end

function generate_random_tree(n)
    arr = rand(1:n-1, n-2)
    println(arr)
    
    print_tree_edges(arr,n)
end

n = 5
generate_random_tree(n)
