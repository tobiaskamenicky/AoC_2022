module Day08

function solve()
    L = readlines(raw"day-8/input.txt")
    h::UInt8 = length(L)
    w::UInt8 = length(L[1])
    T = UInt8[L[y][x] - '0' for y ∈ 1:h, x ∈ 1:w]

    found = Set{Tuple{UInt16, UInt16}}()
    mY = T[:,1]
    for x ∈ 2:w-1
        mx = T[1, x]
        for y∈2:h-1
            v = T[y, x]
            if v > mY[y] || v > mx
                push!(found, (y, x))
            end

            mY[y] = max(v, mY[y])
            mx = max(v, mx)
        end
    end

    mY = T[:,h]
    for x ∈ w-1:-1:2
        mx = T[h, x]
        for y∈h-1:-1:2
            v = T[y, x]
            if v > mY[y] || v > mx
                push!(found, (y, x))
            end

            mY[y] = max(v, mY[y])
            mx = max(v, mx)
        end
    end

    part1 = length(found) + 2w + 2h - 4

    part2 = 0
    for x = 2:w-1
        for y = 2:h-1
            v = T[y, x]
            cl, ct, cr, cb = x-1, y-1, w-x, h-y
            for l in x-1:-1:1 T[y, l] >= v && (cl=x-l) | break end
            for t in y-1:-1:1 T[t, x] >= v && (ct=y-t) | break end
            for r in x+1:w T[y, r] >= v && (cr=r-x) | break end
            for b in y+1:h T[b, x] >= v && (cb=b-y) | break end

            score = cl * ct * cr * cb
            score > part2 && (part2 = score)
        end
    end

    return [part1, part2]
end

result = @time solve()
println(Int.(result))

end