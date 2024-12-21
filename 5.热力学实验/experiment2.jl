using CSV
using DataFrames
using Plots
using Statistics
using Measures

# 读取数据，跳过第一行（列名）
data = CSV.read("experiment2_data.csv", DataFrame, header=["T", "P", "h"], skipto=2)

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
h0 = 359               # 毛细管顶端刻度 (单位: mm)

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
        P = row.P
        h = row.h
        V = (h0 - h) / (k * 1000)  # 计算比容 (m³/kg)
        is_starred = row.is_starred

        push!(df, (T, P, h, V, is_starred))
    end

    sort!(df, :V)  # 按比容排序
    return df
end

# 分组处理数据
groups = groupby(data, :T)
processed_data = [process_data(group) for group in groups]

# 绘制 P-V 图
plot(size=(1000, 700), legend=:topright, grid=true, gridstyle=:dash, gridalpha=0.5,
    bottom_margin=10mm, left_margin=10mm);
for df in processed_data
    plot!(df.V, df.P, label="T = $(df.T[1])°C", marker=:circle, markersize=4, linewidth=2)
    # 用不同的标记显示带星号的点
    starred_points = df[df.is_starred, :]
    scatter!(starred_points.V, starred_points.P, label="", marker=:star, markersize=6)
end
xlabel!("Specific Volume (m³/kg)");
ylabel!("Pressure (MPa)");
title!("P-V Diagram for CO₂");

# 调整 x 轴
xlims!(0, 0.0015);
x_ticks = 0:0.0001:0.0015
x_labels = ["$(round(x, digits=4))" for x in x_ticks]
xticks!(x_ticks, x_labels, rotation=45, tickfont=font(8));

# 调整 y 轴
ylims!(0, 10);
yticks!(0:1:10)

# 保存图像
savefig("./experiment2_res/P-V.png")

# 输出处理后的数据
for (i, df) in enumerate(processed_data)
    CSV.write("./experiment2_res/processed_data_group_$i.csv", df)
end

# 计算临界点 (近似值)
critical_group = processed_data[5]  # 31.1°C 的数据
critical_P = critical_group.P[argmax(diff(critical_group.V))]
critical_V = critical_group.V[argmax(diff(critical_group.V))]
println("Approximate critical point: P = $critical_P MPa, V = $critical_V m³/kg")

# 分析误差
for df in processed_data
    println("Temperature: $(df.T[1])°C")
    println("Mean pressure: $(mean(df.P)) MPa")
    println("Standard deviation of pressure: $(std(df.P)) MPa")
    println("Mean specific volume: $(mean(df.V)) m³/kg")
    println("Standard deviation of specific volume: $(std(df.V)) m³/kg")
    println()
end
