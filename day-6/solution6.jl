module Day06

function solvep(input::SubString{String}, m::Int)
    return findfirst(i -> allunique(SubString(input, i-m+1, i)), m:length(input)) + m - 1
end

function solve()
    input = open(f -> read(f, String), raw"day-6/input.txt")

    part1 = solvep(SubString(input), 4)
    part2 = solvep(SubString(input), 14)
    
    return [part1, part2]
end

result = @time solve()
println(result)

end