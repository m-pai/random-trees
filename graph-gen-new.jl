using Catlab
using Graphs 
using Random
using GraphPlot
using Combinatorics


function add_neighbour(g, s) 
    add_vertex!(g)
    for i in s 
        add_edge!(g, i, nv(g))
    end
    return g
end


function vertex_subsets(g) 
    sub = collect(powerset(1:Int(nv(g))))
    return sub
end

function grow(g)
    set = []
    for i in vertex_subsets(g)
        k = g[1:nv(g)]
            push!(set, add_neighbour(k, i))
    end
    return set
end

function graphs(n)
    arr = []
    if n == 0
        push!(arr, Graph(0))
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
    ref_graphs = []
    for i in graphgen(n)
        push!(ref_graphs, Catlab.Graphs.BasicGraphs.ReflexiveGraph(i))
    end
    return unique(ref_graphs)
end