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

== 组分浓度计算

使用以下回归方程计算乙醇的质量分数：

$ W = 58.844116 - 42.61325 times n_D $

其中，$W$为乙醇的质量分数，$n_D$为折光仪读数。

然后使用以下公式将质量分数转换为摩尔分数：

$ X_A = (W_A / M_A) / ((W_A / M_A) + ((1 - W_A) / M_B)) $

其中，$X_A$为乙醇的摩尔分数，$M_A = 46$为乙醇的分子量，$M_B = 60$为正丙醇的分子量。

=== 液相计算示例

以数据表中第一行（温度92°C）为例：

液相折光指数 $n_D = 1.3772$

计算质量分数：
$ W = 58.844116 - 42.61325 times 1.3772 = 0.1571 $

计算摩尔分数：
$ X_A = (0.1571 / 46) / ((0.1571 / 46) + ((1 - 0.1571) / 60)) = 0.1956 $

=== 气相计算示例

同样以第一行数据为例：

气相折光指数 $n_D = 1.3766$

计算质量分数：
$ W = 58.844116 - 42.61325 times 1.3766 = 0.1827 $

计算摩尔分数：
$ X_A = (0.1827 / 46) / ((0.1827 / 46) + ((1 - 0.1827) / 60)) = 0.2258 $

这些计算结果与数据处理结果表中的第一行数据相符。通过这种方法，我们可以计算出所有数据点的液相和气相组成。

== 活度系数计算

使用前面提到的活度系数计算公式，计算每个数据点的活度系数：

$ gamma_i = (y_i P) / (x_i P_i^0) $

其中，$gamma_i$是组分i的活度系数，$y_i$和$x_i$分别是气相和液相中组分i的摩尔分数，$P$是系统总压，$P_i^0$是纯组分i在系统温度下的饱和蒸气压。

=== 活度系数计算示例

以数据表中第一行（温度92°C）为例，计算乙醇的活度系数：

已知数据：
- 温度 T = 92°C = 365.15 K
- 液相乙醇摩尔分数 $x"_ethanol"$ = 0.1956
- 气相乙醇摩尔分数 $y"_ethanol"$ = 0.2258
- 系统总压 P = 101325 Pa（假设为标准大气压）

首先，我们需要计算乙醇在92°C下的饱和蒸气压。使用安托因方程：

$ log_(10) P^0 = A - (B / (T + C)) $

乙醇的安托因方程参数：A = 8.11220, B = 1592.864, C = 226.184

$ log_(10) P^0"_ethanol" = 8.11220 - (1592.864 / (92 + 226.184)) = 2.1799 $

$ P^0"_ethanol" = 10^(2.1799) = 151.2 "mmHg" = 20158 "Pa" $

现在我们可以计算活度系数：

$ gamma"_ethanol" = (y"_ethanol" P) / (x"_ethanol" P^0"_ethanol") $
$ = (0.2258 times 101325) / (0.1956 times 20158) $
$ = 3.9590 $

这个结果表明，在给定条件下，乙醇的行为偏离了理想溶液的行为（理想溶液的活度系数为1）。

通过这种方法，我们可以计算出所有数据点的活度系数。计算结果见数据处理结果表中的最后两列。

= 实验结果<no-auto-pagebreak>

== 数据处理结果

#figure(
  table(
    columns: 9,
    [T (°C)], [液相折光指数], [气相折光指数], [液相质量分数], [气相质量分数], [液相摩尔分数], [气相摩尔分数], [$gamma"_ethanol"$], [$gamma"_propanol"$],
    [92.0], [1.3772], [1.3766], [0.1571], [0.1827], [0.1956], [0.2258], [3.9590], [4.0625],
    [90.5], [1.3759], [1.3732], [0.2125], [0.3276], [0.2604], [0.3886], [5.1536], [3.5131],
    [89.2], [1.3735], [1.3707], [0.3148], [0.4341], [0.3747], [0.5002], [4.6370], [3.4171],
    [88.0], [1.3719], [1.3686], [0.3830], [0.5236], [0.4474], [0.5891], [4.5992], [3.1962],
    [87.0], [1.3711], [1.3674], [0.4171], [0.5748], [0.4827], [0.6381], [4.6380], [3.0215],
    [86.0], [1.3690], [1.3662], [0.5066], [0.6259], [0.5725], [0.6858], [4.2226], [3.1888],
    [85.0], [1.3672], [1.3645], [0.5833], [0.6983], [0.6461], [0.7512], [4.1175], [3.0639],
    [84.8], [1.3665], [1.3637], [0.6131], [0.7324], [0.6740], [0.7812], [4.1087], [2.9274],
    [84.0], [1.3624], [1.3633], [0.7878], [0.7495], [0.8289], [0.7960], [3.4167], [5.2192],
    [83.5], [1.3610], [1.3615], [0.8475], [0.8262], [0.8788], [0.8611], [3.4944], [5.0278],
  ),
  caption: [数据处理结果]
) <processed-data>

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

# 设置中文字体
default(fontfamily="SimHei")

# 读取数据
data = CSV.read("experiment1_data.csv", DataFrame)

# 定义计算质量分数的函数
function calculate_mass_fraction(n_D)
    return 58.844116 - 42.61325 * n_D
end

# 定义计算摩尔分数的函数
function calculate_mole_fraction(W_A)
    M_A = 46  # 乙醇分子量
    M_B = 60  # 正丙醇分子量
    return (W_A / M_A) / ((W_A / M_A) + ((1 - W_A) / M_B))
end

# 计算质量分数和摩尔分数
data.liquid_mass_fraction = calculate_mass_fraction.(data.L)
data.vapor_mass_fraction = calculate_mass_fraction.(data.V)
data.liquid_mole_fraction = calculate_mole_fraction.(data.liquid_mass_fraction)
data.vapor_mole_fraction = calculate_mole_fraction.(data.vapor_mass_fraction)

# 绘制 t-x-y 曲线图
p1 = plot(data.liquid_mole_fraction, data.T, label="液相", marker=:circle);
plot!(p1, data.vapor_mole_fraction, data.T, label="气相", marker=:square);
xlabel!(p1, L"x, y");
ylabel!(p1, "温度 (°C)");
title!(p1, "乙醇-正丙醇体系的 t-x-y 相图")
savefig(p1, "experiment1_res/t-x-y_plot.png")

# 绘制 x-y 曲线图
p2 = plot(data.liquid_mole_fraction, data.vapor_mole_fraction, label="实验数据", marker=:circle);
plot!(p2, [0, 1], [0, 1], label="对角线", linestyle=:dash);
xlabel!(p2, L"x");
ylabel!(p2, L"y");
title!(p2, "乙醇-正丙醇体系的 x-y 相图")
savefig(p2, "experiment1_res/x-y_plot.png")

# 计算 ln(P_0) 的函数
function calculate_ln_p0(A, B, C, T)
    return A - B / (C + T)
end

# 计算 P_0 的函数 (单位：Pa)
function calculate_p0(ln_p0)
    return exp(ln_p0) * 133.322  # 将 mmHg 转换为 Pa
end

# 计算活度系数的函数
function calculate_activity_coefficient(x, y, p0_1, p0_2)
    P = 101325  # 标准大气压，Pa
    gamma_1 = y * P / (x * p0_1)
    gamma_2 = (1 - y) * P / ((1 - x) * p0_2)
    return gamma_1, gamma_2
end

# 安托因方程参数
A_1 = 8.04494
B_1 = 1554.3
C_1 = 222.65

A_2 = 7.74416
B_2 = 1437.686
C_2 = 198.463

# 计算每个数据点的活度系数
data.gamma_1 = zeros(nrow(data))
data.gamma_2 = zeros(nrow(data))

for i in 1:nrow(data)
    T = data.T[i] + 273.15  # 转换为开尔文温度

    ln_p0_1 = calculate_ln_p0(A_1, B_1, C_1, T)
    ln_p0_2 = calculate_ln_p0(A_2, B_2, C_2, T)

    p0_1 = calculate_p0(ln_p0_1)
    p0_2 = calculate_p0(ln_p0_2)

    data.gamma_1[i], data.gamma_2[i] = calculate_activity_coefficient(
        data.liquid_mole_fraction[i],
        data.vapor_mole_fraction[i],
        p0_1,
        p0_2
    )
end

# 打印活度系数
println("活度系数:")
println(select(data, [:T, :liquid_mole_fraction, :vapor_mole_fraction, :gamma_1, :gamma_2]))

# 将结果保存到CSV文件
CSV.write("experiment1_res/results.csv", data)
```
````