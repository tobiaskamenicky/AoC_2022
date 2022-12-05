module Day05

function solvepart1(items::Vector{Vector{Char}}, cmds::Vector{Vector{Int}})
    for values in cmds
        for _ in 1:values[1]
            push!(items[values[3]], pop!(items[values[2]]))
        end
    end
    return [items[i][end] for i = 1:9]
end

function solvepart2(items::Vector{Vector{Char}}, cmds::Vector{Vector{Int}})
    for values in cmds
        append!(items[values[3]], items[values[2]][end-values[1]+1:end])
        deleteat!(items[values[2]], length(items[values[2]]) .+ (-values[1]+1:0))
    end
    return [items[i][end] for i = 1:9]
end

function solve()
    input = open(f -> read(f, String), raw"day-5/input.txt")
    parts = split(input, r"\R\R")

    initials = split(parts[1], r"\R")

    items = [Char[] for _ in 1:9]
    for l in initials[end-1:-1:1]
        for (i, c) in enumerate(l[2:4:end])
            isletter(c) && (push!(items[i], c))
        end
    end

    cmds = eachmatch(r"(*ANYCRLF)^move (\d+) from (\d+) to (\d+)$"m, parts[2]) .|> x -> parse.(Int, x)
    part1 = String(solvepart1(deepcopy(items), cmds))
    part2 = String(solvepart2(items, cmds))

    return [part1, part2]
end

result = @time solve()
println(result)

end