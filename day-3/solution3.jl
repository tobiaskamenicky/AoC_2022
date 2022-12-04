module Day03

function solve()
    lines = readlines(raw"day-3/input.txt")

    scores = Dict([x => i for (i, x) in enumerate(vcat('a':'z', 'A':'Z'))])

    part1 = 0
    part2 = 0

    for line in lines
        fst = line[1:end÷2]
        snd = line[end÷2 + 1:end]

        c = fst[findfirst(x -> x ∈ snd, fst)]
        part1 += scores[c]
    end

    for par in Iterators.partition(lines, 3)
        ci = findfirst(x -> x ∈ par[2] && x ∈ par[3], par[1])
        part2 += scores[par[1][ci]]
    end

    return [part1, part2]
end

result = @time solve()
println(result)

end