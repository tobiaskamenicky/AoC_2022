module Day03

function day03()
    lines = readlines(raw"day-3/input.txt")

    scores = Dict([x => i for (i, x) in enumerate(vcat('a':'z', 'A':'Z'))])

    part1 = 0
    part2 = 0

    for line in lines
        first = line[1:Int(end / 2)]
        second = line[Int(end / 2 + 1):end]

        for c in first
            if c ∈ second
                part1 += scores[c]
                break
            end
        end
    end

    for i in 1:3:length(lines)-2
        for c in lines[i]
            if (c ∈ lines[i+1] && c ∈ lines[i+2])
                part2 += scores[c]
                break
            end
        end
    end

    return [part1, part2]
end

result = @time day03()
println(result)

end