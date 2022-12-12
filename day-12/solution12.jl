module Day12

using DataStructures

function solve()
    part1=0
    part2=typemax(Int)

    L = readlines(raw"day-12/input.txt")
    h::UInt8 = length(L)
    w::UInt8 = length(L[1])
    T = Int8[L[y][x] - 'a' for y ∈ 1:h, x ∈ 1:w]

    iF = findfirst(x -> x == -28, T)
    T[iF] = 'z'-'a'
    iS = findfirst(x -> x == -14, T)
    T[iS] = 0

    N = [CartesianIndex(-1,0), CartesianIndex(0,-1), CartesianIndex(1,0), CartesianIndex(0,1)]

    D = fill(typemax(Int), h, w)
    D[iF] = 0
    Q =  PriorityQueue(iF => 0)

    while length(Q) > 0
        iU = dequeue!(Q)

        for n in N
            iN = iU + n
            if checkbounds(Bool, D, iN) && D[iN] == typemax(Int) && (T[iN] >= T[iU] - 1)
                D[iN] = D[iU] + 1
                enqueue!(Q, iN => D[iN])
            end
        end
    end

    part1 = D[iS]
    part2 = minimum(D[findall(x -> x == 0, T)])

    return [part1, part2]
end

result = @time solve()
println(result[1])
println(result[2])

end
