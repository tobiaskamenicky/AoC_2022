module Day02

function day02()
    input = open(f->read(f, String), raw"day-2/input.txt")

    part1 = 0
    part2 = 0

    step = findfirst(r"\R", input)[1]
    for l in 1:step:length(input)
        o = input[l] - '@'
        m = input[l+2] - 'W'

        part1 += 3mod(m - o + 1, 3) + m
        part2 += mod(m + o, 3) + 3m - 2
    end

    return [part1, part2]
end;

result = @time day02()
println(result)

end