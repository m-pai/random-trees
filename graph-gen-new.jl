using Catlab
using Graphs 
using Random
using GraphPlot
using Combinatorics


function graphgen(g)
    graphs = []
    if nv(g) == 0
        return graphs
    else
        for i in Int(nv(g))
            for j in permutations(1:Int(nv(g)), i)
                k = g[1:nv(g)]
                add_vertex!(k)
                while length(j)!=0
                    add_edge!(k, pop!(j), nv(k))
                    l = union(k, g)
                    push!(graphs, l)
                end
            end
        end
        return graphs
    end
end

function reflexive_conv(n)
    ref_graphs = []
    for i in graphgen(n)
        push!(ref_graphs, Catlab.Graphs.BasicGraphs.ReflexiveGraph(i))
    end
    return ref_graphs
end

reflexive_conv(path_graph(2))