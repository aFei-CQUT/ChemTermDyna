#import "../lib.typ": *

#let (
  twoside, doc, mainmatter, appendix, preface,
  fonts-display-page, cover, outline-page, 
) = documentclass(
  twoside: false,
  info: (
    title: ("CO2 PVT曲线测定实验报告"),
    author: "非非",
    submit-date: datetime.today(),
    cover-image: "../experiment/images/cover.jpg",
    numbering-style: "maths"
  ),
)

// 文稿设置
#show: doc

// 封面页
#cover()

// 前言部分
#show: preface

// 目录
// #outline-page()

// 正文部分
#show: mainmatter

= 实验目的<no-auto-pagebreak>

1. 绘制CO2的PVT曲线

= 实验原理<no-auto-pagebreak>

== PVT关系

对于理想气体，其状态方程为$P V_m = R T$其中，P为压力，V_m为摩尔体积，R为气体常数，T为温度。

然而，实际气体的行为会偏离理想气体定律，特别是在接近临界点时。考虑气体分子体积和分子间相互作用力的影响，1873年范德华提出了修正方程：

$ (P + a/V^2)(V - b) = R T $

其中，a/V^2 是分子力的修正项，b 是分子体积的修正项。

CO2的PVT关系可以通过实验测定得到。通过保持温度恒定，测量压力和体积之间的关系，可以绘制等温线。

== 临界点<no-auto-pagebreak>

临界点是气液共存曲线的终点，在此点上液相和气相的性质变得相同。临界温度是使气体无法仅通过加压而液化的最高温度。对于CO2，临界压力Pc为7.38 MPa，临界温度Tc为31.1°C。

= 实验数据<no-auto-pagebreak>

原始实验数据如下:

#figure(
  table(
    columns: 3,
    [温度 (°C)], [压力 (MPa)], [高度 (mm)],
    [10], [2.3], [0],
    [10], [2.6], [43],
    [10], [2.9], [81],
    [10], [3.2], [117],
    [10], [3.5], [142],
    [10], [3.8], [167],
    [10], [4.1], [188],
    [10], [4.4], [208],
    [10], [4.55], [227\*],
    [10], [4.58], [232],
    [10], [4.6], [250],
    [10], [4.6], [255],
    [10], [4.62], [260],
    [10], [4.65], [265],
    [10], [4.65], [275],
  ),
  caption: [CO2 PVT实验原始数据(10°C) (1/2)]
) <raw-data-10c-1>

#pagebreak()

#figure(
  table(
    columns: 3,
    [温度 (°C)], [压力 (MPa)], [高度 (mm)],
    [10], [4.65], [270],
    [10], [4.65], [275],
    [10], [4.65], [280],
    [10], [4.65], [285],
    [10], [4.65], [290],
    [10], [4.68], [295],
    [10], [4.7],  [300],
    [10], [4.71], [305],
    [10], [4.85], [316],
    [10], [4.92], [320],
    [10], [5.12], [325],
    [10], [5.45], [330],
    [10], [6.6],  [335],
    [10], [8.0],  [337],
  ),
  caption: [CO2 PVT实验原始数据(10°C) (续)]
) <raw-data-10c-2>


注：带\*的数据点为相变点。

= 数据处理<no-auto-pagebreak>

== 质面比常数K值计算

质面比常数由第25 $°C$下的比容定标计算:

$ k &= (332 ÷ 1000)/0.00124 \ &= 267.741935483871 "kg/m²"$

由此，可以求出任意温度、压力下的二氧化碳比容 V = Δh / k。

== 数据处理示例

以10°C的第一组数据为例:

原始数据: 温度 T = 10°C, 压力 P = 2.3 MPa, 高度 h = 0 mm, 毛细管顶端刻度 h0 = 359 mm

高度差 Δh:
$ Delta h = h_0 - h = 359 "mm" - 0 "mm" = 359 "mm" $

将高度差转换为米:
$ Delta h = 359 "mm" div (1000 "mm/m") = 0.359 "m" $

计算比容 v:
$ v &= Delta h / (k times 1000) \
&= (0.359 "m") / (29.038 "kg/m"^2 times 1000) \
&= 0.359 / 29038 \
&= 0.012363110407052827 "m"^3 "/" "kg" $
四舍五入到小数点后6位:
$ v approx 0.012363 "m"^3 "/" "kg" $

因此,在10°C和2.3 MPa压力下,CO2的比容为0.012363 m³/kg。

== 处理后的数据表格

#figure(
  table(
    columns: 5,
    [温度 (°C)], [压力 (MPa)], [高度 (mm)], [比容 (m³/kg)], [备注],
    [10], [8.0], [337], [8.216867469879518e-5], [],
    [10], [6.6], [335], [8.963855421686747e-5], [],
    [10], [5.45], [330], [0.0001083132530120482], [],
    [10], [5.12], [325], [0.0001269879518072289], [],
    [10], [4.92], [320], [0.00014566265060240964], [],
    [10], [4.85], [316], [0.00016060240963855423], [],
    [10], [4.71], [305], [0.0002016867469879518], [],
    [10], [4.7], [300], [0.00022036144578313252], [],
    [10], [4.68], [295], [0.00023903614457831325], [],
    [10], [4.65], [290], [0.00025771084337349395], [],
    [10], [4.65], [285], [0.0002763855421686747], [],
    [10], [4.65], [280], [0.0002950602409638554], [],
    [10], [4.65], [275], [0.00031373493975903613], [],
    [10], [4.65], [275], [0.00031373493975903613], [],
    [10], [4.65], [270], [0.00033240963855421686], [],
    [10], [4.65], [265], [0.0003510843373493976], [],
    [10], [4.62], [260], [0.0003697590361445783], [],
    [10], [4.6], [255], [0.00038843373493975905], [],
    [10], [4.6], [250], [0.0004071084337349398], [],
    [10], [4.58], [232], [0.00047433734939759036], [],
    [10], [4.55], [227], [0.0004930120481927711], [相变点],
    [10], [4.4], [208], [0.0005639759036144579], [],
    [10], [4.1], [188], [0.0006386746987951807], [],
    [10], [3.8], [167], [0.0007171084337349397], [],
    [10], [3.5], [142], [0.0008104819277108434], [],
    [10], [3.2], [117], [0.000903855421686747], [],
    [10], [2.9], [81], [0.0010383132530120483], [],
    [10], [2.6], [43], [0.0011802409638554216], [],
    [10], [2.3], [0], [0.001340843373493976], [],
  ),
  caption: [CO2 PVT实验处理后数据(10°C)]
) <processed-data-10c>

注：比容数据已经四舍五入到小数点后六位。

#pagebreak()

== PV曲线绘制

使用计算得到的比容数据和测量的压力数据绘制PV曲线：

#figure(
  image("../../experiment2_res/P-V.png", width: 100%),
  caption: [CO2的PV曲线]
) <pv-curves>

这个图表展示了在不同温度下CO2的压力-比容关系。从图中可以清楚地看到气液两相区的存在，以及压力随比容变化的趋势。

= 结果讨论<no-auto-pagebreak>

1. PV曲线特征：
- 在10°C和20°C时，PV曲线呈现明显的气液两相区，这与理论预期一致。
- 31.1°C（临界温度）附近的曲线显示了临界点的特征，即气液两相区几乎消失。
- 50°C的曲线表现为典型的超临界流体行为，不存在明显的相变过程。

2. 相变过程：
- 在低温（10°C和20°C）下，观察到明显的等压相变过程，压力在相变过程中保持基本恒定。
- 相变压力随温度升高而增加，这符合相平衡理论。

3. 临界点附近行为：
- 31.1°C的曲线显示了接近临界点时CO2的特殊行为，气液两相区变得不明显。
- 这一观察结果验证了CO2的临界温度确实接近31.1°C。

4. 超临界状态：
- 50°C的曲线展示了CO2在超临界状态下的行为，压力随比容减小而连续增加，没有明显的相变。
- 这一结果对于理解CO2在超临界条件下的应用（如超临界萃取）具有重要意义。

5. 与理想气体的偏差：
- 所有温度下的曲线都显示出与理想气体行为的明显偏差，特别是在高压区域。
- 这种偏差证实了范德华方程对实际气体行为的修正是必要的。

6. 实验精度：
- 曲线的平滑性和连续性表明实验数据的质量较高。
- 然而，在某些区域（特别是相变点附近）可能存在一些测量误差或波动。

7. 应用价值：
- 这些PV曲线为CO2在不同温度和压力下的行为提供了直观的理解。
- 结果对于CO2在工业应用中的使用（如制冷、超临界萃取、增强油气采收等）具有重要的指导意义。

8. 进一步研究方向：
- 建议进行更多温度点的测量，特别是在临界温度附近，以更精确地描述临界行为。
- 可以考虑扩大压力范围，以探索CO2在更极端条件下的行为。

总的来说，本实验成功地展示了CO2在不同温度和压力下的PVT关系，结果与理论预期基本吻合。实验数据为理解CO2的热力学行为提供了宝贵的实验依据，对于相关的理论研究和实际应用都具有重要价值。
= 误差分析<no-auto-pagebreak>

== 可能的误差来源
1. 温度控制和测量误差（±0.1°C）
2. 压力测量误差（±0.01 MPa）
3. 高度（体积）测量误差（±0.5 mm）
4. CO2样品的纯度影响
5. 系统密封性的影响

== 改进建议
1. 使用更精确的温度控制和测量设备
2. 采用高精度压力传感器
3. 改进高度测量方法，如使用更精密的位移传感器
4. 使用更高纯度的CO2样品
5. 定期检查并改进系统密封性
6. 增加更多温度点的测量，特别是接近临界温度的区域

// 附录
#show: appendix

= 附录<no-auto-pagebreak>

````typst
```julia
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
```
````