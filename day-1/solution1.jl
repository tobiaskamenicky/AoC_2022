module Day01

function day01()
    values = Int[]
    group = 0
    for l in eachline(raw"day-1/input.txt")
        if !isempty(l) 
            group += parse(Int,l)
            continue
        end
        push!(values, group)
        group = 0
    end

    sorted = partialsort!(values, 1:3, rev=true)
    
    p1 = sorted[1]
    p2 = sum(sorted)

    return [p1, p2]
end;

r = @time day01()
println(r)
end
