
function decompositions(tree_size, bag_size)
  decomp = []

  # generating random tree of size m
  T = rand_tree(tree_size)

  # array of reflexive graphs of size n
  ngs = reflexive_conv(bag_size)

  ngsn = hcat(ngs, ngs)

  all_epis = Any[]

  # Error: size of ngs smaller than size of v+e and so not entering for loop
  for gs in Combinatorics.combinations(ngsn, tree_size + tree_size - 1)
    el = elements(T)
    ob_dict = Dict(zip(ob_generators(∫(el)), gs))
    for f in hom_generators(∫(el))
      push!(all_epis, filter(t -> is_epic(t), homomorphisms(ob_dict[el[f, :src]], ob_dict[el[f, :tgt]])))
    end
    if all_epis != Any[] 
      lengths = map(length, all_epis)
      print(lengths)
      for i in h(lengths) 
        mor_dict = Dict(zip(hom_generators(∫(T)), map((l,i) -> l[i], zip(all_epis, i))))
        F = FinDomFunctor(ob_dict, mor_dict, ∫(T)) 
        d = StrDecomp(T,F)
        append(d, decomp)
      end
    end
  end

  return decomp
end