module Day11

using Match

mutable struct Monkey
    items::Vector{Int}
    operation::Function
    test::Int
    yes::Int
    no::Int
    count::Int
end

function solve_part1(monkeys::Vector{Monkey})
    for _ ∈ 1:20
        for im in eachindex(monkeys)
            m = monkeys[im]
            while length(m.items) > 0
                m.count += 1
                x = popfirst!(m.items)
                x = m.operation(x)

                x = x ÷ 3
                in = rem(x, m.test) == 0 ? m.yes : m.no
                push!(monkeys[in].items, x)
            end
        end
    end

    partialsort!(monkeys, 1:2, rev=true, by = x -> x.count)
    return monkeys[1].count * monkeys[2].count
end

function solve_part2(monkeys::Vector{Monkey})
    lm = lcm(map(x -> x.test, monkeys))
    for _ ∈ 1:10000
        for im in eachindex(monkeys)
            m = monkeys[im]
            while length(m.items) > 0
                m.count += 1
                x = popfirst!(m.items)
                x = m.operation(x)

                x = rem(x,lm)
                in = rem(x, m.test) == 0 ? m.yes : m.no
                push!(monkeys[in].items, x)
            end
        end
    end

    partialsort!(monkeys, 1:2, rev=true, by = x -> x.count)
    return monkeys[1].count * monkeys[2].count
end

function solve()
    part1=0
    part2=0

    monkeys::Vector{Monkey} = []

    open(raw"day-11/input.txt") do f
        while !eof(f)
            readline(f)
            items = parse.(Int,split(SubString(readline(f),19), ", "))

            m = SubString(readline(f), 24)
            op = @match m[1] begin
                '+' => +
                '*' => *
            end
            fun = @match m[3] begin
                'o' => x->op(x,x)
                _ => x->op(x, parse(Int, SubString(m, 3)))
            end
       
            t = parse(Int, SubString(readline(f), 22))
            y = parse(Int, SubString(readline(f), 30)) + 1
            n = parse(Int, SubString(readline(f), 31)) + 1
            push!(monkeys, Monkey(items, fun, t, y, n,0))
            readline(f)
        end
    end

    part1 = solve_part1(deepcopy(monkeys))
    part2 = solve_part2(monkeys)
    
    return [part1, part2]
end

result = @time solve()
println(result[1])
println(result[2])

end
