require("utils")

graph = {}
graph[1] = {[1] = 0, [2] = 5, [5] = 6, [6] = 3, [7] = 4 }
graph[2] = {[2] = 0, [3] = 9, [1] = 5, [10] = 7 }
graph[3] = {[3] = 0, [2] = 9, [4] = 8, [8] = 9 }
graph[4] = {[4] = 0, [3] = 8, [5] = 2, [9] = 5 }
graph[5] = {[5] = 0, [1] = 6, [4] = 2}
graph[6] = {[6] = 0, [1] = 3}
graph[7] = {[7] = 0, [1] = 4}
graph[8] = {[8] = 0, [3] = 9, [11] = 3}
graph[9] = {[9] = 0, [4] = 5}
graph[10] = {[10] = 0, [2] = 7, [11] = 4}
graph[11] = {[11] = 0, [8] = 3,[10] = 4}



function shortest_path(a,b,vis) --bfs
  local path = {}
  --print("chamada",a,b,table.concat(vis,","))
  if graph[a][b] == nil then  
    for k,v in pairs(graph[a]) do
      --print(a.." to "..b.." = "..a.." to "..k.." + "..k.." to "..b)
      if(not contains(vis, k)) then 
        vis[#vis+1] = k
        tam1 = shortest_path(a,k,vis)
        tam2 = shortest_path(k,b,vis)
        table.insert(path, tam1 + tam2)
        --print("path size "..#path)
      else
        --print(k.." is known")
      end
    end
    if #path == 0 then 
      return 1000 --inf
    end
    table.sort(path)
  --print(table.concat(path))
   graph[a][b] = path[1]
  --print("quality "..graph[a][b])
	--print("path "..a.." to "..b.." "..graph[a][b])--.." "..table.concat(path,";"))
  end
    --print("ret",graph[a][b])
  return graph[a][b]
end
