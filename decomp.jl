function decompositions(tree_size, bag_size)
  decomp = []

  # generating random tree of size m
  T = rand_tree(tree_size)

  # array of reflexive graphs of size n
  ngs = reflexive_conv(bag_size)

  for gs in Combinatorics.combinations(ngs, tree_size)
    el = elements(T)
    ob_dict = Dict(zip(ob_generators(∫(el)), gs))
    for f in hom_generators(∫(el))
      all_epis = filter(is_epic, homomorphisms(ob_dict[el[f, :src]], ob_dict[el[f, :tgt]]))
    end
  end

  
end

