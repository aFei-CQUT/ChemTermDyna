using CSV
using DataFrames
using Logging

# 创建一个空的DataFrame用于存储合并的数据
combined_data = DataFrame()

file_directory = "../co2的pvt测定结果"

# 打印当前工作目录，确保路径正确
println("当前工作目录：$(pwd())")

# 使用for循环遍历1到7的文件名
for i in 1:7
    file_path = joinpath(file_directory, "第($i)组数据结果.csv")
    try
        # 读取每个CSV文件并追加到combined_data中
        data = CSV.read(file_path, DataFrame)
        combined_data = vcat(combined_data, data)
    catch e
        if isa(e, SystemError)
            @warn "文件 $file_path 未找到，跳过该文件。"
        else
            rethrow(e)
        end
    end
end

# 将合并后的数据写入一个新的CSV文件
CSV.write("汇总结果.csv", combined_data)


using Printf
using CSV
using DataFrames

function process_data(file_path)
    df = CSV.read(file_path, DataFrame)
    temperatures = sort(unique(df.T))
    groups = Dict{Float64,Vector{Vector{Any}}}()

    for T in temperatures
        group_data = filter(row -> row.T == T, df)
        groups[T] = [[row.P, row.h, row.V, convert(Bool, row.is_starred)] for row in eachrow(group_data)]
    end

    return temperatures, groups
end

function format_table(temperatures, groups, start_idx, end_idx)
    result = "| 序号 | T | P | h | V | * | | 序号 | T | P | h | V | * | | 序号 | T | P | h | V | * |\n"
    result *= "|------|---|---|---|---|---|---|------|---|---|---|---|---|---|------|---|---|---|---|---|\n"
    result *= "|     | °C | MPa | mm | m³/kg |   | |      | °C | MPa | mm | m³/kg |   | |      | °C | MPa | mm | m³/kg |   |\n"

    max_rows = maximum(length(groups[T]) for T in temperatures[start_idx:end_idx])

    for row in 1:max_rows
        for col in 1:3
            T_idx = start_idx + col - 1
            if T_idx <= end_idx
                T = temperatures[T_idx]
                data = groups[T]
                if row <= length(data)
                    P, h, V, is_starred = data[row]
                    star_mark = if isa(is_starred, Bool)
                        is_starred ? "*" : ""
                    elseif isa(is_starred, Number)
                        is_starred != 0 ? "*" : ""
                    else
                        ""
                    end
                    result *= @sprintf("|**%d**| %.1f | %.2f | %d | %.2e | %s |", row, T, P, round(Int, h), V, star_mark)
                else
                    result *= "|      |     |     |   |       |   |"
                end
            else
                result *= "|      |     |     |   |       |   |"
            end
        end
        result *= "\n"
    end

    return result
end

# Main execution
file_path = "汇总结果.csv"
temperatures, groups = process_data(file_path)

open("汇总结果.md", "w") do io
    println(io, "# CO₂ PVT 数据处理汇总\n")

    group_number = 1
    for i in 1:3:length(temperatures)
        start_idx = i
        end_idx = min(i + 2, length(temperatures))
        println(io, "## 第$(start_idx) - 第$(end_idx)组数据\n")
        println(io, "注：* 指是否有气液相转变\n")
        print(io, format_table(temperatures, groups, start_idx, end_idx))
        println(io)
        group_number += 1
    end
end

println("处理完成，结果已写入 汇总结果.md 文件。")
