using CSV
using DataFrames
using TyPlot
using Printf

# 读取数据，跳过第一行（列名）
data = CSV.read("co2的pvt测定.csv", DataFrame, header=["T", "P", "h"], skipto=2)

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

# 常量
k = (332 / 1000) / 0.00124 # 质面比常数 (单位: kg/m²)
h0 = 359                   # 毛细管顶端刻度 (单位: mm)

# 处理数据的函数
function process_data(group)
    df = DataFrame(
        T=Float64[],
        P=Float64[],
        h=Float64[],
        V=Float64[],
        is_starred=Bool[]
    )

    for row in eachrow(group)
        T = row.T
        P = row.P + 1.01325  # 将压力转换为绝对压力 (MPa)
        h = row.h
        V = (h0 - h) / (k * 1000)  # 计算比容 (m³/kg)
        is_starred = row.is_starred
        push!(df, (T, P, h, V, is_starred))
    end

    return df
end

# 分组处理数据
groups = groupby(data, :T)
processed_data = [process_data(group) for group in groups]

# 绘制 P-V 图
figure(figsize=(10, 7))
hold("on")

for df in processed_data
    plot(df.V, df.P, "-o", label=raw"$T = $" * "$(df.T[1])" * raw"$ ^\circ\mathrm{C} $", markersize=2, linewidth=1.5)
    # 用不同的标记显示带星号的点
    starred_points = df[df.is_starred, :]
    scatter(starred_points.V, starred_points.P, marker="*", s=100)
end

xlabel(raw"$\mathrm{Specific\ Volume\ (m^3/kg)}$")
ylabel(raw"$\mathrm{Pressure\ (MPa)}$")
title(raw"$P-V\ \mathrm{Diagram\ for}\ CO_2$")

# 调整 x 轴
xlim(0, 0.0015)
x_ticks = 0:0.0001:0.0015
x_labels = [@sprintf("%.4f", x) for x in x_ticks]
xticks(x_ticks)
xticklabels(x_labels, rotation=45)

# 调整 y 轴
ylim(0, 10)
yticks(0:1:10)

grid(true, linestyle="--", alpha=0.5)
legend(loc="best")

# 保存图像
savefig("./co2的pvt测定结果/P-V.syslabfig")

# 输出处理后的数据
for (i, df) in enumerate(processed_data)
    result_data = DataFrame(
        T=[@sprintf("%.1f", x) for x in df.T],
        P=[@sprintf("%.4f", x) for x in df.P],
        h=[@sprintf("%.1f", x) for x in df.h],
        V=[@sprintf("%.7f", x) for x in df.V],
        is_starred=df.is_starred
    )
    CSV.write("./co2的pvt测定结果/第($i)组数据结果.csv", result_data)
end

# 打印结果
println("结果:")
for (i, df) in enumerate(processed_data)
    println("Group $i:")
    println(DataFrame(
        T=[@sprintf("%.1f", x) for x in df.T],
        P=[@sprintf("%.4f", x) for x in df.P],
        h=[@sprintf("%.1f", x) for x in df.h],
        V=[@sprintf("%.7f", x) for x in df.V],
        is_starred=df.is_starred
    ))
    println()
end
