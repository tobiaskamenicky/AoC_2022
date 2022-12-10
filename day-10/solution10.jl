module Day10

function get_output(cycle, x)
    c = (x-1 <= rem(cycle-1, 40) <= x+1) ? '#' : '.'
    return rem(cycle, 40) == 0 ? c*"\n" : c
end

function solve()
    x = 1
    cycle = 0
    part1 = 0
    part2 = ""
    for l ∈ eachline(raw"day-10/input.txt")        
        cs = SubString(l, 1, 4) == "addx" ? 2 : 1
        for _ ∈ 1:cs
            cycle += 1
            part2 *= get_output(cycle, x)
            (rem(cycle, 40) == 20) && (part1 += x*cycle)
        end
        cs == 2 && (x += parse(Int, SubString(l, 5)))
    end

    return [part1, part2]
end

result = @time solve()
println(result[1])
println(result[2])

end
