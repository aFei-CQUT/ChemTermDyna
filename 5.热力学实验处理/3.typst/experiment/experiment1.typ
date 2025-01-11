#import "../lib.typ": *

#let (
  twoside, doc, mainmatter, appendix, preface,
  fonts-display-page, cover, outline-page, 
) = documentclass(
  twoside: false,
  info: (
    title: ("二元汽液平衡数据测定实验报告"),
    author: "非非",
    submit-date: datetime.today(),
    cover-image: "../experiment/images/cover.jpg", // 如果有封面图片，请在这里添加路径
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

1. 从实验测得的T–P–X–Y数据计算各组分的活度系数
2. 学会二元汽液平衡相图的绘制
3. 绘制t—x—y曲线图和x—y曲线图

= 实验原理<no-auto-pagebreak>

== 活度系数计算

活度系数的计算公式如下：

$ gamma_i = (y_i P) / (x_i P_i^0) $

其中，$gamma_i$是组分i的活度系数，$y_i$和$x_i$分别是气相和液相中组分i的摩尔分数，$P$是系统总压，$P_i^0$是纯组分i在系统温度下的饱和蒸气压。

== 相图绘制

t—x—y曲线图反映了系统温度与液相和气相组成的关系，x—y曲线图反映了液相和气相组成的关系。这两种图都是描述二元系统气液平衡性质的重要工具。

= 实验数据<no-auto-pagebreak>

原始实验数据如下：

#figure(
  table(
    columns: 3,
    [温度 (°C)], [液相折光指数], [气相折光指数],
    [92], [1.3772], [1.3766],
    [90.5], [1.3759], [1.3732],
    [89.2], [1.3735], [1.3707],
    [88], [1.3719], [1.3686],
    [87], [1.3711], [1.3674],
    [86], [1.3690], [1.3662],
    [85], [1.3672], [1.3645],
    [84.8], [1.3665], [1.3637],
    [84], [1.3624], [1.3633],
    [83.5], [1.3610], [1.3615],
  ),
  caption: [原始实验数据]
) <raw-data>

= 数据处理<no-auto-pagebreak>

== 计算公式

=== 质量分数计算

使用以下回归方程计算乙醇的质量分数：

$ w_1 = 58.844116 - 42.61325 n_D $

其中，$w_1$为乙醇的质量分数，$n_D$为折光仪读数。

=== 摩尔分数计算

使用以下公式将质量分数转换为摩尔分数：

$ x_1 = (w_1 / M_1) / ((w_1 / M_1) + (w_2 / M_2)) $

其中，$x_1$为乙醇的摩尔分数，$M_1 = 46 "g/mol"$为乙醇的摩尔质量，$M_2 = 60 "g/mol"$为正丙醇的摩尔质量。

=== 饱和蒸气压计算

使用安托因方程计算饱和蒸气压：

$ log_(10) p^0 = A - (B / (T + C)) $

其中，$p^0$的单位为mmHg，$T$的单位为°C。

乙醇的安托因方程参数：A = 8.04494, B = 1554.3, C = 222.65
正丙醇的安托因方程参数：A = 7.99733, B = 1569.7, C = 209.5

=== 活度系数计算

使用以下公式计算活度系数：

$ gamma_i = (y_i P) / (x_i p_i^0) $

其中，$gamma_i$是组分i的活度系数，$y_i$和$x_i$分别是气相和液相中组分i的摩尔分数，$P$是系统总压（101325 Pa），$p_i^0$是纯组分i在系统温度下的饱和蒸气压（单位：mmHg）。

== 计算示例

以数据表中第一行（温度92°C）为例：

=== 液相组成计算

液相折光指数 $n_D = 1.3772$

计算质量分数：
$ w_1 = 58.844116 - 42.61325 times 1.3772 = 0.1571 $

计算摩尔分数：
$ x_1 = (0.1571 / 46) / ((0.1571 / 46) + ((1 - 0.1571) / 60)) = 0.1956 $

=== 气相组成计算

气相折光指数 $n_D = 1.3766$

计算质量分数：
$ w_1 = 58.844116 - 42.61325 times 1.3766 = 0.1827 $

计算摩尔分数：
$ y_1 = (0.1827 / 46) / ((0.1827 / 46) + ((1 - 0.1827) / 60)) = 0.2258 $

=== 饱和蒸气压计算

对于乙醇（T = 92°C）：
$ log_(10) p^0_1 = 8.04494 - (1554.3 / (92 + 222.65)) = 2.1052 $
$ p^0_1 = 10^(2.1052) = 1273.9889 "mmHg" $

对于正丙醇（T = 92°C）：
$ log_(10) p^0_2 = 7.99733 - (1569.7 / (92 + 209.5)) = 1.7911 $
$ p^0_2 = 10^(1.7911) = 618.0565 "mmHg" $

=== 活度系数计算

乙醇的活度系数：
$ gamma_1 = (0.2258 times 101325) / (0.1956 times 1273.9889 times 133.322) = 0.6890 $

正丙醇的活度系数：
$ gamma_2 = ((1 - 0.2258) times 101325) / ((1 - 0.1956) times 618.0565 times 133.322) = 1.1845 $

= 实验结果<no-auto-pagebreak>

== 数据处理结果

#figure(
  table(
    columns: 7,
    [T (°C)], [液相质量分数], [气相质量分数], [液相摩尔分数], [气相摩尔分数], [γ₁], [γ₂],
    [92.0000], [0.1571], [0.1827], [0.1956], [0.2258], [0.6890], [1.1845],
    [90.5000], [0.2125], [0.3276], [0.2604], [0.3886], [0.9408], [1.0802],
    [89.2000], [0.3148], [0.4341], [0.3747], [0.5002], [0.8826], [1.1007],
    [88.0000], [0.3830], [0.5236], [0.4474], [0.5891], [0.9101], [1.0751],
    [87.0000], [0.4171], [0.5748], [0.4827], [0.6381], [0.9482], [1.0540],
    [86.0000], [0.5066], [0.6259], [0.5725], [0.6858], [0.8921], [1.1539],
    [85.0000], [0.5833], [0.6983], [0.6461], [0.7512], [0.8992], [1.1503],
    [84.8000], [0.6131], [0.7324], [0.6740], [0.7812], [0.9032], [1.1073],
    [84.0000], [0.7878], [0.7495], [0.8289], [0.7960], [0.7714], [2.0337],
    [83.5000], [0.8475], [0.8262], [0.8788], [0.8611], [0.8023], [1.9961],
  ),
  caption: [更新后的数据处理结果]
) <updated-processed-data>

== t—x—y曲线图

#figure(
  image("../../experiment1_res/t-x-y_plot.png", width: 50%),
  caption: [t—x—y曲线图]
) <txy-curve>

#pagebreak()

== x—y曲线图

#figure(
  image("../../experiment1_res/x-y_plot.png", width: 50%),
  caption: [x—y曲线图]
) <xy-curve>


= 结果讨论<no-auto-pagebreak>

1. 从t—x—y曲线图可以看出，随着乙醇浓度的增加，系统的沸点逐渐降低。这是因为乙醇的沸点比正丙醇低。

2. x—y曲线图显示，在整个浓度范围内，气相中乙醇的浓度都高于液相，这表明乙醇比正丙醇更容易挥发。

3. 活度系数的计算结果显示，两种组分的活度系数都大于1，说明该系统存在正偏差，表现出非理想性。这可能是由于乙醇和正丙醇分子间的相互作用力与纯组分中分子间的相互作用力不同造成的。

4. 在接近共沸点时（约84°C附近），活度系数出现了较大的波动。这可能是由于实验误差或者系统在接近共沸点时的特殊行为造成的。

5. 总体来说，实验数据反映了乙醇-正丙醇体系的基本热力学特性，但在某些温度点（特别是接近共沸点时）可能存在一些异常值，需要进一步验证和分析。

= 误差分析<no-auto-pagebreak>

== 实验过程中可能存在的误差来源：
- 温度测量误差
- 折光指数测量误差
- 平衡状态判断误差
- 样品采集和处理过程中的误差
- 环境因素（如大气压变化）的影响

== 减少误差的方法：
- 使用更精确的温度计和折光仪
- 多次测量取平均值
- 仔细观察平衡状态，确保系统达到真正的平衡
- 改进样品采集和处理方法，减少污染和蒸发
- 保持实验环境稳定，记录大气压等环境参数
- 严格控制实验条件，包括加热和冷却速率
- 重复实验，增加数据的可靠性
- 与理论值和文献数据对比，验证实验结果的合理性
- 使用统计方法分析数据，识别和处理异常值

// 附录
#show: appendix

= 附录<no-auto-pagebreak>

````typst
```julia
using DataFrames
using CSV
using Plots
using LaTeXStrings
using Printf

# 设置中文字体
default(fontfamily="SimHei");

# 读取数据
data = CSV.read("experiment1_data.csv", DataFrame);

# 定义计算质量分数的函数
function calculate_mass_fractions(n_D)
    w₁ = 58.844116 - 42.61325 * n_D  # 乙醇质量分数
    w₂ = 1 - w₁  # 正丙醇质量分数
    return w₁, w₂
end;

# 定义计算摩尔分数的函数
function calculate_mole_fraction(w₁, w₂)
    M₁ = 46  # 乙醇分子量
    M₂ = 60  # 正丙醇分子量
    n₁ = w₁ / M₁
    n₂ = w₂ / M₂
    return n₁ / (n₁ + n₂)
end;

# 计算质量分数和摩尔分数
data.w₁_L = zeros(nrow(data));  # 液相乙醇质量分数
data.w₂_L = zeros(nrow(data));  # 液相正丙醇质量分数
data.w₁_V = zeros(nrow(data));  # 气相乙醇质量分数
data.w₂_V = zeros(nrow(data));  # 气相正丙醇质量分数
data.x₁ = zeros(nrow(data));    # 液相乙醇摩尔分数
data.y₁ = zeros(nrow(data));    # 气相乙醇摩尔分数
data.x₂ = zeros(nrow(data));    # 液相正丙醇摩尔分数
data.y₂ = zeros(nrow(data));    # 气相正丙醇摩尔分数

for i in 1:nrow(data)
    data.w₁_L[i], data.w₂_L[i] = calculate_mass_fractions(data.L[i])
    data.w₁_V[i], data.w₂_V[i] = calculate_mass_fractions(data.V[i])
    data.x₁[i] = calculate_mole_fraction(data.w₁_L[i], data.w₂_L[i])
    data.y₁[i] = calculate_mole_fraction(data.w₁_V[i], data.w₂_V[i])
    data.x₂ = 1 .- data.x₁
    data.y₂ = 1 .- data.y₁
end;

# 绘制 T-x-y 曲线图
p1 = plot(data.x₁, data.t, label="液相", marker=:circle);
plot!(p1, data.y₁, data.t, label="气相", marker=:square);
xlabel!(p1, L"x_1, y_1");
ylabel!(p1, "t (°C)");
title!(p1, "乙醇-正丙醇体系的 t-x-y 相图")
savefig(p1, "experiment1_res/t-x-y_plot.png")

# 绘制 x-y 曲线图
p2 = plot(data.x₁, data.y₁, label="实验数据", marker=:circle);
plot!(p2, [0, 1], [0, 1], label="对角线", linestyle=:dash);
xlabel!(p2, L"x_1");
ylabel!(p2, L"y_1");
title!(p2, "乙醇-正丙醇体系的 x-y 相图")
savefig(p2, "experiment1_res/x-y_plot.png")

# 计算 lg(p⁰) 的函数
function calculate_lg_p⁰(A, B, C, t)
    return A - B / (t + C)
end;

# 计算 p⁰ 的函数 (单位：# mmHg)
function calculate_p⁰(lg_p⁰)
    return 10^(lg_p⁰)
end;

# 计算活度系数的函数
function calculate_activity_coefficient(x₁, y₁, p₁⁰, p₂⁰)
    P = 101325 / 133.22     # (单位：# mmHg)
    γ₁ = y₁ * P / (x₁ * p₁⁰)
    γ₂ = (1 - y₁) * P / ((1 - x₁) * p₂⁰)
    return γ₁, γ₂
end;

# 安托因方程参数
A₁ = 8.04494;
B₁ = 1554.3;
C₁ = 222.65;

A₂ = 7.99733;
B₂ = 1569.7;
C₂ = 209.5;

# 计算每个数据点的活度系数
data.p₁⁰ = zeros(nrow(data));
data.p₂⁰ = zeros(nrow(data));
data.γ₁ = zeros(nrow(data));
data.γ₂ = zeros(nrow(data));

for i in 1:nrow(data)
    t = data.t[i]

    lg_p₁⁰ = calculate_lg_p⁰(A₁, B₁, C₁, t)
    lg_p₂⁰ = calculate_lg_p⁰(A₂, B₂, C₂, t)

    p₁⁰ = calculate_p⁰(lg_p₁⁰)
    p₂⁰ = calculate_p⁰(lg_p₂⁰)

    data.p₁⁰[i] = p₁⁰
    data.p₂⁰[i] = p₂⁰

    data.γ₁[i], data.γ₂[i] = calculate_activity_coefficient(
        data.x₁[i],
        data.y₁[i],
        p₁⁰,
        p₂⁰
    )
end;

# 定义一个函数来格式化数字为四位小数的字符串
function four_decimals(x)
    return @sprintf("%.4f", x)
end;

# 创建一个新的 DataFrame，按照所需的顺序排列列并保存为四位小数的字符串
result_data = DataFrame(
    t   = four_decimals.(data.t),
    w₁_L= four_decimals.(data.w₁_L),
    w₂_L= four_decimals.(data.w₂_L),
    w₁_V= four_decimals.(data.w₁_V),
    w₂_V= four_decimals.(data.w₂_V),
    x₁  = four_decimals.(data.x₁),
    y₁  = four_decimals.(data.y₁),
    x₂  = four_decimals.(data.x₂),
    y₂  = four_decimals.(data.y₂),
    p₁⁰ = four_decimals.(data.p₁⁰),
    p₂⁰ = four_decimals.(data.p₂⁰),
    γ₁  = four_decimals.(data.γ₁),
    γ₂  = four_decimals.(data.γ₂)
);

# 打印结果
println("结果:")
println(result_data)

# 将结果保存到CSV文件
CSV.write("experiment1_res/result.csv", result_data)
```
````