
function contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function shuffled_unique_list(min,max,size)
local list = {}
local i
  while #list ~= size do
    i = math.random(min,max)
    if(not contains(list,i)) then list[#list+1] = i end
  end
  return list
end

function shuffled_list(min,max,size)
local list = {}
local i
  while #list ~= size do
    i = math.random(min,max)
    list[#list+1] = i 
  end
  return list
end

function print_population(population) 
  for _,n in ipairs(population) do print(table.concat(n.gene,"."),n.quality) end
end

function sortby(t1,t2) -- t2 contains t1 
  local t = {}
  for i=1,#t2 do 
      if contains(t1,t2[i]) then  
        table.insert(t,t2[i]) 
      end
  end
  return t
end
