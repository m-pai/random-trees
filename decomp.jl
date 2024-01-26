include("Decompositions.jl")
using Catlab.CategoricalAlgebra

include("random-trees-new.jl")
include("graph-gen-new.jl")
include("code-for-h-new.jl")

function decompositions(tree_size, bag_size)
  decomp = []

  # generating random tree of size m
  T = rand_tree(tree_size)

  # array of reflexive graphs of size n
  ngs = reflexive_conv(bag_size)


  num_tree_edges_vertices = 2 * tree_size - 1
  graph_assign = rand(ngs, num_tree_edges_vertices)

  el = elements(T)
  ∫el = ∫(el)
  ob_gen_el = ob_generators(∫el)
  hom_gen_el = hom_generators(∫el)

  for gs in Combinatorics.permutations(graph_assign, num_tree_edges_vertices)
  #for gs in [[ngs[1], ngs[1], ngs[1], ngs[1], ngs[1]]]
    ob_dict = Dict(zip(ob_gen_el, gs))
    all_epis = Any[]
    for f in hom_gen_el
      push!(all_epis, filter(t -> is_epic(t), homomorphisms(ob_dict[el[f, :src]], ob_dict[el[f, :tgt]])))
    end
    if !isempty(all_epis)
      lengths = map(length, all_epis)
      for i in h(lengths) 
        chosen_epis = map(l -> l[1][l[2]], zip(all_epis, i))
        mor_dict = Dict(zip(hom_gen_el, chosen_epis))
        F = FinDomFunctor(ob_dict, mor_dict, ∫el) 
        d = StrDecomp(T,F)
        push!(decomp, d)
      end
    end
  end

  return decomp
end