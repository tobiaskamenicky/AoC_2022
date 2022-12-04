module Day04

function solve()
    input = open(f->read(f, String), raw"day-4/input.txt")

    part1 = 0
    part2 = 0
    for m in eachmatch(r"^(\d+)-(\d+),(\d+)-(\d+)$"m, input)

        x = parse(Int, m[1]):parse(Int, m[2])
        y = parse(Int, m[3]):parse(Int, m[4])

        (x ⊆ y || y ⊆ x) && (part1 += 1)
        !isdisjoint(x, y) && (part2 += 1)
    end

    return [part1, part2]
end

result = @time solve()
println(result)

end