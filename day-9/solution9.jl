module Day09

using Match

function solve()
    r = [[0, 0] for _ ∈ 1:10]
    visited1 = Set{UInt}()
    visited2 = Set{UInt}()
    for l ∈ eachline(raw"day-9/input.txt")
        d = l[1]
        sf = parse(UInt8, SubString(l, 3))

        for _ in 1:sf
            @match d begin
                'R' => (r[1][1] += 1)
                'L' => (r[1][1] -= 1)
                'D' => (r[1][2] += 1)
                'U' => (r[1][2] -= 1)
            end

            for ir ∈ 2:10
                x = r[ir-1][1] - r[ir][1]
                y = r[ir-1][2] - r[ir][2]

                if x < -1 || 1 < x || y < -1 || 1 < y
                    x != 0 && (r[ir][1] += x ÷ x * sign(x))
                    y != 0 && (r[ir][2] += y ÷ y * sign(y))

                    ir == 2 && push!(visited1, hash(r[ir]))
                    ir == lastindex(r) && push!(visited2, hash(r[ir]))
                end
            end

        end
    end
    part1 = length(visited1) + 1
    part2 = length(visited2) + 1

    return [part1, part2]
end

result = @time solve()
println(Int.(result))

end
