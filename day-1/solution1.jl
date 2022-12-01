module Day01

function day01()
    input = open(f->read(f, String), raw"day-1/input.txt")
    
    groups = split.(split(input, "\n\n"; keepempty=false)) .|> x -> parse.(Int, x)
    sums = sort(sum.(groups), rev=true)

    p1 = sums[1]
    p2 = sum(sums[1:3])

    return [p1, p2]
end;

r = @time day01()
println(r)
end
