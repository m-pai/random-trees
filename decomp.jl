
function decompositions(tree_size, bag_size)
  decomp = []

  # generating random tree of size m
  T = rand_tree(tree_size)

  # array of reflexive graphs of size n
  ngs = reflexive_conv(bag_size)

  push!(ngs, ngs[1])
  push!(ngs, ngs[2])

  # Error: size of ngs smaller than size of v+e and so not entering for loop
  for gs in Combinatorics.combinations(ngs, tree_size + tree_size - 1)
    el = elements(T)
    ob_dict = Dict(zip(ob_generators(∫(el)), gs))
    for f in hom_generators(∫(el))
      all_epis = filter(t -> is_epic(t), homomorphisms(ob_dict[el[f, :src]], ob_dict[el[f, :tgt]]))
      print(all_epis)
      if all_epis == 0 break
      else 
        lengths = map(length, all_epis)
        for i in h(lengths) 
          mor_dict = Dict(zip(hom(el), map((l,i) -> l[i], zip(all_epis, i)))) #check code here 
          F = FinDomFunctor(ob_dict, mor_dict, el) 
          d = StrDecomp(T,F)
          append(d, decomp)
        end
      end 
    end
  end

  return decomp
end
