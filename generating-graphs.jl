using Graphs
using GraphPlot

function graph_gen(x)
    graphs = [x]
    if nv(x) == 1
        k = Graph(nv(x)+1)
        push!(graphs, k)
    elseif ne(x) == 0
        k = Graph(nv(x))
        for i in vertices(k)
            add_edge!(k, i, i+1)
        end

        l = Graph(nv(x)+1)
        push!(graphs, k, l)
    else
        k = Graph(nv(x)+1)
        for i in vertices(k)
            for j in vertices(k)
                if i != j
                    add_edge!(k, i, j)
                end
            end
        end
        push!(graphs, k)
    end
    return graphs
end

m = Graph(2)
add_edge!(m, 1,2)

g1 = graph_gen(Graph(1))
g2 = graph_gen(Graph(2))
g3 = graph_gen(Graph(3))
g4 = graph_gen(m)

