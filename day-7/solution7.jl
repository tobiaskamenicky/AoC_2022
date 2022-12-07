module Day07

using Match

function solve()
    dirs = [hash("")]
    sizes = UInt32[0]

    current = [1]
    for line in eachline(raw"day-7/input.txt")
        if line[1] == '$'
            @match SubString(line, 3, 4) begin
                "cd" => begin
                    @match SubString(line, 6) begin
                        "/" => begin current = [1] end
                        ".." => pop!(current)
                        _ => begin 
                            for d in Iterators.drop(enumerate(dirs), last(current)) 
                                if d[2] == hash((last(current), SubString(line, 6))) 
                                    push!(current,d[1])
                                    break
                                end
                            end
                        end
                    end
                end
            end
        else
            si = findfirst(' ', line)
            name = SubString(line, si+1)
            @match SubString(line, 1, 3) begin
                "dir" => begin
                    push!(dirs, hash((last(current), name)))
                    push!(sizes, 0)
                end
                _ => begin
                    s = parse(UInt32, SubString(line, 1, si-1)) 
                    for i in current
                        sizes[i] += s
                    end
                end
            end
        end
    end

    part1 = sum(Iterators.filter(<=(100000), sizes))
    
    needed = first(sizes) - 40000000
    part2 = minimum(Iterators.filter(>=(needed), sizes))

    return[part1,part2]
end

result = @time solve()
println(Int.(result))

end