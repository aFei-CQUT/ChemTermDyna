using CSV
using DataFrames
using Printf

# 读取数据，跳过第一行（表头）
data = CSV.read("原始数据.csv", DataFrame, header=["T", "P", "h"], skipto=2)

# 删除空行和非数值行
data = data[completecases(data), :]
data = data[.!occursin.("组数据", data.T), :]

# 将列转换为适当的数据类型
data.T = parse.(Float64, data.T)
data.P_str = string.(data.P)  # 保留原始的字符串格式数据，用于标记星号
data.h_str = string.(data.h)  # 保留原始的字符串格式数据，用于标记星号

# 添加新列来标记带星号的数据点
data.is_starred = occursin.("*", data.P_str) .| occursin.("*", data.h_str)

# 移除星号后的数字数据
data.P = parse.(Float64, replace.(data.P_str, "*" => ""))
data.h = parse.(Float64, replace.(data.h_str, "*" => ""))

# 创建一个函数来格式化每个组的数据
function format_group(group)
    rows = []
    for row in eachrow(group)
        star = row.is_starred ? "*" : ""
        push!(rows, @sprintf("| %.1f | %.2f | %d | %s |", row.T, row.P, round(Int, row.h), star))
    end
    return rows
end

# 生成表格的函数
function format_table(groups, start_idx, end_idx)
    table = "| T/°C | P/MPa | h/mm | * | | T/°C | P/MPa | h/mm | * | | T/°C | P/MPa | h/mm | * |\n"
    table *= "|-------|--------|-------|---|-|-------|--------|-------|---|-|-------|--------|-------|---|\n"

    group_data = [format_group(g) for g in groups[start_idx:end_idx]]
    max_rows = maximum(length(g) for g in group_data)

    for j in 1:max_rows
        row = ""
        for k in 1:3
            if k <= length(group_data) && j <= length(group_data[k])
                row *= group_data[k][j] * " "
            else
                row *= "|       |        |       |   | "
            end
        end
        table *= strip(row) * "\n"
    end
    return table
end

# 获取所有唯一的温度值
temperatures = sort(unique(data.T))

# 按温度分组
groups = groupby(data, :T)

# 将表格写入文件
open("原始数据.md", "w") do io
    println(io, "# CO₂ PVT 数据处理汇总\n")

    group_number = 1
    for i in 1:3:length(temperatures)
        start_idx = i
        end_idx = min(i + 2, length(temperatures))
        println(io, "## 第$(start_idx) - $(end_idx)组数据\n")
        println(io, "注：* 指是否有气液相转变\n")
        print(io, format_table(groups, start_idx, end_idx))
        println(io)
        group_number += 1
    end
end

println("数据处理完成，结果已写入 原始数据.md 文件。")
