using Random
using Printf
using Graphs
using GraphPlot
using Catlab
using Catlab.Graphs.BasicGraphs
using Catlab.CategoricalAlgebra

# Generating random trees
n = 5
T = Graph(n)

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
    
    print_tree_edges(arr,n)
end

edgelist = generate_random_tree(n)
println()

key =[1,2,3,4]

edge_dict = Dict(zip(key, edgelist))

# Aim: To make a list of all graphs on two vertices.

#one-vertex graphs
j1 = Catlab.Graphs.BasicGraphs.ReflexiveGraph(1)

#two-vertex graphs 
k1 = Catlab.Graphs.BasicGraphs.ReflexiveGraph(2)

k2 = Catlab.Graphs.BasicGraphs.ReflexiveGraph(2)
Catlab.Graphs.BasicGraphs.add_edge!(k2, 1, 2)

#three-vertex graphs
l1 = Catlab.Graphs.BasicGraphs.ReflexiveGraph(3)

l2 = Catlab.Graphs.BasicGraphs.ReflexiveGraph(3)
Catlab.Graphs.BasicGraphs.add_edges!(l2, [1,2], [2,3])

l3 = Catlab.Graphs.BasicGraphs.ReflexiveGraph(3)
Catlab.Graphs.BasicGraphs.add_edges!(l3, [1,2,3],[2,3,1])

graphs = Dict(1=>j1, 2=>k1, 3=>k2, 4=>l1, 5=>l2, 6=>l3)

vertex_dict = Dict()

for i in 1:5
    vertex_dict[i] = (vertex_dict, rand(Dict(1=>l1, 2=>l2, 3=>l3))[2])
end

G_e = 0
G_x = 0 
G_y = 0

for i in 1:4
   p = collect(edge_dict[i])
   G_e = rand(Dict(1=>l1, 2=>l2, 3=>l3))[2]
   q = collect(vertex_dict[p[1]])
   r = collect(vertex_dict[p[2]])
   G_x = q[2]
   G_y = r[2]
   hsx = homomorphism(G_x, G_e)
   if isempty(hsx) == false
        hsy = homomorphism(G_y, G_e)
        if isempty(hsy) == false
            hx = hsx[1]
            hy = hsy[1]
        end
   end
end