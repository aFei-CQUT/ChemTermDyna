using CSV
using DataFrames

# 读取CSV文件
df = CSV.read("result.csv", DataFrame)

# 打开一个新的Markdown文件用于写入
open("result.md", "w") do io
    # 生成Markdown表格
    println(io, "# 二元平衡实验数据处理结果汇总\n")
    println(io, "| 序号 | T/℃ | 液相折光系数 | 气相折光系数 | 液相质量分数 | 气相质量分数 | 液相摩尔分数 | 气相摩尔分数 | γ1 | γ2 |")
    println(io, "|-----|-----|------------|------------|------------|------------|------------|------------|-----|-----|")
    println(io, "| -   | ℃   | 1          | 1          | 1          | 1          | 1          | 1          | 1   | 1   |")

    for (i, row) in enumerate(eachrow(df))
        println(io, "| $i   | $(round(row.t, digits=1))| $(round(row.w₁_L, digits=4))     | $(round(row.w₁_V, digits=4))     | $(round(row.w₁_L, digits=4))     | $(round(row.w₁_V, digits=4))     | $(round(row.x₁, digits=4))     | $(round(row.y₁, digits=4))     | $(round(row.γ₁, digits=4)) | $(round(row.γ₂, digits=4)) |")
    end
end

println("Markdown文件已生成：result.md")
