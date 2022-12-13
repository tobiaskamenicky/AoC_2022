module Day13

function parse_v(v::AbstractString)
    values = []
    depth = 0
    s = 0
    for i in eachindex(v)
        if v[i] == '['
            depth += 1
            depth == 1 && (s = i)
        elseif v[i] == ']'
            depth -= 1
            if depth == 0
                push!(values, parse_v(SubString(v, s + 1, i - 1)))
                s = i + 1
            end
        elseif v[i] == ',' && depth == 0 && s < i
            push!(values, parse(Int, SubString(v, s + 1, i - 1)))
            s = i
        elseif i == lastindex(v) && s < i
            push!(values, parse(Int, SubString(v, s + 1, i)))
        end
    end

    return values
end

function compare_v(a, b)
    aa = a isa Array{<:Any,1}
    ab = b isa Array{<:Any,1}

    !aa && !ab && return a - b
    !aa && ab && return compare_v([a], b)
    aa && !ab && return compare_v(a, [b])

    for i in eachindex(a)
        i > lastindex(b) && return 1

        c = compare_v(a[i], b[i])
        c != 0 && return c
    end

    return length(a) - length(b)
end

function solve()
    L = readlines(raw"day-13/input.txt")

    pI = 1
    part1 = 0
    part2a = 1
    part2b = 2
    aP = [[2]]
    bP = [[6]]
    for g in Iterators.partition(L, 3)
        a = parse_v(g[1][2:end-1])
        b = parse_v(g[2][2:end-1])

        compare_v(a, b) < 0 && (part1 += pI)
        compare_v(a, aP) < 0 && (part2a += 1)
        compare_v(b, aP) < 0 && (part2a += 1)
        compare_v(a, bP) < 0 && (part2b += 1)
        compare_v(b, bP) < 0 && (part2b += 1)

        pI += 1
    end

    part2 = part2a * part2b

    return [part1, part2]
end

result = @time solve()
println(result[1])
println(result[2])

end
