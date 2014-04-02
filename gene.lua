require ("graph")
require ("utils")

population = {}

function create_gene(n)
  return shuffled_unique_list(1,n,n)
end

function get_quality(individual)
  local gene = individual.gene
  local q = 0
  for i=2,#gene do
    local vis ={}
    q = q + shortest_path(gene[i-1],gene[i],vis)
  end  
  return q
end

function population:get_best(n)
  local ret = {} 
  for i=1,n do
    table.insert(ret,self[i])
  end
  return ret
end

function population:remove_worst(n)
  local ret = {}
  for i=#self,1,-1 do
     table.insert(ret,self[i])
  end
  return ret
end

function make_children(pop,n)
  local child = {}
  local not_copied = {}
  for i=1,n do --create n children
    child[i] = {}
    child[i].gene = {}
    bitmask = shuffled_list(0,1,graph_size)
    --print(unpack(bitmask))

    for j=1,graph_size do
      if bitmask[j] == 1 then
        child[i].gene[j] = pop[1].gene[j]
      else
        table.insert(not_copied, pop[1].gene[j]) 
      end
    end
    --print(unpack(child[i].gene))

	  not_copied = sortby(not_copied,pop[2].gene)

    for j=1,graph_size do
      if child[i].gene[j] == nil then 
        child[i].gene[j] = not_copied[1]
        table.remove(not_copied,1)
      end
    end
    --print(unpack(child[i].gene))

    child[i].quality = get_quality(child[i])
    --print_population(child)

  end
  --print_population(child)
  return child
end 
function mutate(pop,chance)
  if math.random(1,100) < chance then
    for i=1, #pop do
      k = math.random(1,#pop[i].gene)
      l = math.random(1,#pop[i].gene)
      local a = pop[i].gene[k]
      pop[i].gene[k] = pop[i].gene[l]
      pop[i].gene[l] = a
    end
  end
end
