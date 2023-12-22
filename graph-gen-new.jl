using Catlab
using Graphs 
using Combinatorics

function add_neighbour(g, s) 
    Graphs.add_vertex!(g)
    for i in s 
        Graphs.add_edge!(g, i, Graphs.nv(g))
    end
    return g
end


function vertex_subsets(g) 
    sub = collect(Combinatorics.powerset(1:Int(Graphs.nv(g))))
    return sub
end

function grow(g)
    set = map(s -> add_neighbour(g[1:Graphs.nv(g)],s), vertex_subsets(g))
    return set
end

function graphs(n)
    arr = []
    if n == 0
        push!(arr, Graphs.Graph(0))
        return arr
    else
        for i in graphs(n-1)
            for j in grow(i)
                push!(arr, j)
            end
        end
        return arr
    end
end

function reflexive_conv(n)
    ref_graphs = map(i -> Catlab.Graphs.BasicGraphs.ReflexiveGraph(i), graphs(n))
    return ref_graphs
end