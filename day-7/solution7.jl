module Day07

using Match

function setsizes(current, edges, sizes)
    haskey(sizes, current) && return sizes[current]
    sizes[current] = 0
    for n in get(edges, current, [])
        sizes[current] += setsizes(n, edges, sizes)
    end
    return sizes[current]
end

function solve()
    dirs = [""]
    edges = Dict{String,Vector{String}}()
    sizes = Dict{String,UInt32}()

    current = dirs[1]
    for line in eachline(raw"day-7/input.txt")
        if line[1] == '$'
            @match SubString(line, 3, 4) begin
                "cd" => begin
                    current = @match SubString(line, 6) begin
                        "/" => ""
                        ".." => current[1:findlast('/', current)[1]-1]
                        _ => current * "/" * SubString(line, 6)
                    end
                end
                "ls" => begin
                    edges[current] = String[]
                end
            end
        else
            si = findfirst(' ', line)
            name = SubString(line, si+1)
            @match SubString(line, 1, 3) begin
                "dir" => begin
                    path = current * "/" * name
                    push!(dirs, path)
                    push!(edges[current], path)
                end
                _ => begin 
                    path = current * "/" * name
                    push!(edges[current], path)
                    sizes[path] = parse(UInt32, SubString(line, 1, si-1)) 
                end
            end
        end
    end

    setsizes("", edges, sizes)
    
    part1 = 0
    for dir in dirs
        s = sizes[dir]
        s <= 100000 && (part1 += s)
    end

    needed = sizes[""] - 40000000
    part2 = sizes[partialsort((filter(x -> sizes[x] >= needed, dirs)), 1, by= x -> sizes[x])]

    return [Int(part1), Int(part2)]
end

result = @time solve()
println(result)

end