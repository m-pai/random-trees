function decompositions(tree_size, bag_size)
  decomp = []

  # generating random tree of size m
  T = rand_tree(tree_size)

  # array of reflexive graphs of size n
  ngs = reflexive_conv(bag_size)

  for gs in Combinatorics.combinations(ngs, tree_size + tree_size - 1)
    el = elements(T)
    ob_dict = Dict(zip(ob_generators(∫(el)), gs))
    for f in hom_generators(∫(el))
      all_epis = filter(is_epic, list_of_homs(ob_dict[el[f, :src]], ob_dict[el[f, :tgt]]))
      # Doubt 1: I think the is_epic filter is returning an empty all_epis vector which is why it is aborting every time.
      if all_epis == 0 break
      else 
        lengths = map(length, all_epis)
        for i in h(lengths) 
          mor_dict = Dict(zip(morphisms(∫(el)), map((l,i) -> l[i], zip(all_epis, indices)))) #check code here 
          F = FinDomFunctor(ob_dict, mor_dict, el) 
          d = StrDecomp(T,F)
          append(d, decomp)
        end
      end 
    end
  end

  return decomp
end
