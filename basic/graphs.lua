local function name2node(graph, name)
    local node = graph[name]
    if not node then
        node = {name = name, adj = {}}
        graph[name] = node
    end
    return node
end

local function readgraph()
    local graph = {}
    for line in io.lines() do
        local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
        local from = name2node(graph, namefrom)
        local to = name2node(graph, nameto)

        from.adj[to] = true
    end
    return graph
end

local function findpath(curr, to, path, visited)
    local path = path or {}
    local visited = visited or {}
    if visited[curr] then
        return nil
    end

    visited[curr] = true

    path[#path+1] = curr

    if curr == to then
        return path
    end

    for node in pairs(curr.adj) do
        local p = findpath(node, to, path, visited)
        if p then
            return p
        end
    end
    table.remove(path)
end

local function printpath(path)
    for i = 1, #path do
        print(path[i].name)
    end
end

local g = readgraph()
local a = name2node(g, "a")
local b = name2node(g, "b")
local p = findpath(a, b)
if p then
    printpath(p)
else
    print("path not found")
end