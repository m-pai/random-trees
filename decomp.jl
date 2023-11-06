function decompositions(tree_size, bag_size)
  decomp = []

  # generating random tree of size m
  T = rand_tree(tree_size)

  # array of reflexive graphs of size n
  ngs = reflexive_conv(bag_size)

  for gs in Combinatorics.combinations(ngs, tree_size)
    τ = Catlab.CategoricalAlgebra.FinCats.graph(∫(T))
    ob_dict = Dict(zip(ob_generators(∫(T)), gs))
    for f in hom_generators(elements(T))
      all_epis = filter(is_epic, homomorphisms(ob_dict[dom(f)], ob_dict[codom(f)]))
    end
  end

  
end

