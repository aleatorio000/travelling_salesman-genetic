require("gene") -- population declared here
require("utils")

graph_size = 11
pop_size = 4
elite = 2
generations = 1000
chance = 5 --in percent
math.randomseed(os.time())


--[[
history = 1
-- pre-selection for a better initial population
-- average is not a good method, since the worst will not survive, maybe seeing who has the best best.
world = {}
local b_pop -- best population

for j=1,history do 
  local q_avg = 0 -- quality average
  local b_q_avg = 0 -- best of quality averages
  
  local pop = {}
  for i=1,pop_size do
    
    pop[i] = {}
    pop[i].gene = create_gene(graph_size)
    pop[i].quality = get_quality(pop[i])

  
    q_avg = q_avg + pop[i].quality
  end
  q_avg = q_avg/pop_size
  if q_avg < b_q_avg or b_q_avg == 0 then
    b_q_avg = q_avg
    b_pop = j
  end
  table.insert(world,pop)
end

for k=1,pop_size do
  table.insert(population,world[b_pop][k])
end
--]]

for i=1,pop_size do
    population[i] = {}
    population[i].gene = create_gene(graph_size)
    population[i].quality = get_quality(population[i])
end



for i=1,generations do
  table.sort(population, function(a,b) return a.quality < b.quality end) --the best comes first
  
  --print("generation "..i.." :")
  --print_population(population)  
  
  best = population:get_best(elite) --elite survives
  --print("best "..i.." :")
  --print_population(best)

  for j=1, (pop_size - elite) do 
    population[#population] = nil --who didn't survive was forgotten
  end

  children = make_children(best, pop_size-elite) --population size did not alter
  --all children came from the best pair, the correct should be a combination of elite

  --print("children "..i.." :")
  --print_population(children)

  mutate(children,chance)
  
  --print("mutated "..i.." :")
  --print_population(children)
  
  for j=1,#children do
    table.insert(population,children[j])
  end
  --print("population "..i.." :")
  --print_population(population)

end

table.sort(population, function(a,b) return a.quality < b.quality end)--just for a more pleasant view
print("final generation :\n")
print("size of the population "..pop_size)
print("elite "..elite)
print("generations "..generations)
print("chance of mutation "..chance)
print("\nincrease generations and population size for better results \nand chance of mutation to run away from local critic points\n")
print_population(population)

