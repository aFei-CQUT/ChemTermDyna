using DataFrames
using CSV
using TyPlot
using Printf

# 读取数据
data = CSV.read("酒精浓度实验.csv", DataFrame)

# 定义计算质量分数的函数
function calculate_mass_fractions(n_D)
    w₁ = 58.844116 - 42.61325 * n_D  # 乙醇质量分数
    w₂ = 1 - w₁  # 正丙醇质量分数
    return w₁, w₂
end

# 定义计算摩尔分数的函数
function calculate_mole_fraction(w₁, w₂)
    M₁ = 46  # 乙醇分子量
    M₂ = 60  # 正丙醇分子量
    n₁ = w₁ / M₁
    n₂ = w₂ / M₂
    return n₁ / (n₁ + n₂)
end

# 计算质量分数和摩尔分数
data.w₁_L = zeros(nrow(data))  # 液相乙醇质量分数
data.w₂_L = zeros(nrow(data))  # 液相正丙醇质量分数
data.w₁_V = zeros(nrow(data))  # 气相乙醇质量分数
data.w₂_V = zeros(nrow(data))  # 气相正丙醇质量分数
data.x₁ = zeros(nrow(data))    # 液相乙醇摩尔分数
data.y₁ = zeros(nrow(data))    # 气相乙醇摩尔分数
data.x₂ = zeros(nrow(data))    # 液相正丙醇摩尔分数
data.y₂ = zeros(nrow(data))    # 气相正丙醇摩尔分数

for i in 1:nrow(data)
    data.w₁_L[i], data.w₂_L[i] = calculate_mass_fractions(data.L[i])
    data.w₁_V[i], data.w₂_V[i] = calculate_mass_fractions(data.V[i])
    data.x₁[i] = calculate_mole_fraction(data.w₁_L[i], data.w₂_L[i])
    data.y₁[i] = calculate_mole_fraction(data.w₁_V[i], data.w₂_V[i])
    data.x₂ = 1 .- data.x₁
    data.y₂ = 1 .- data.y₁
end


# 绘制 T-x-y 曲线图
figure(figsize=(10, 7))
hold("on")

plot(data.x₁, data.t, "-o", label="Liquid phase", markersize=6)
plot(data.y₁, data.t, "-s", label="Vapor phase", markersize=6)
xlabel(raw"$x_1, y_1$")
ylabel(raw"$t\ (^\circ\mathrm{C})$")
title("T-x-y Phase Diagram of Ethanol-n-Propanol System")
legend(loc="best")
grid(true, linestyle="--", alpha=0.5)
savefig("酒精浓度实验结果/t-x-y_plot.syslabfig")

# 绘制 x-y 曲线图
figure(figsize=(10, 7))
hold("on")

plot(data.x₁, data.y₁, "-o", label="Experimental data", markersize=6)
plot([0, 1], [0, 1], "--", label="Diagonal")
xlabel(raw"$x_1$")
ylabel(raw"$y_1$")
title("x-y Phase Diagram of Ethanol-n-Propanol System")
legend(loc="best")
grid(true, linestyle="--", alpha=0.5)
savefig("酒精浓度实验结果/x-y_plot.syslabfig")

# 计算 lg(p⁰) 的函数
function calculate_lg_p⁰(A, B, C, t)
    return A - B / (t + C)
end

# 计算 p⁰ 的函数 (单位：mmHg)
function calculate_p⁰(lg_p⁰)
    return 10^(lg_p⁰)
end

# 计算活度系数的函数
function calculate_activity_coefficient(x₁, y₁, p₁⁰, p₂⁰)
    P = 101325 / 133.22     # (单位：mmHg)
    γ₁ = y₁ * P / (x₁ * p₁⁰)
    γ₂ = (1 - y₁) * P / ((1 - x₁) * p₂⁰)
    return γ₁, γ₂
end

# 安托因方程参数
A₁ = 8.04494
B₁ = 1554.3
C₁ = 222.65

A₂ = 7.99733
B₂ = 1569.7
C₂ = 209.5

# 计算每个数据点的活度系数
data.p₁⁰ = zeros(nrow(data))
data.p₂⁰ = zeros(nrow(data))
data.γ₁ = zeros(nrow(data))
data.γ₂ = zeros(nrow(data))

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
end

# 定义一个函数来格式化数字为四位小数的字符串
function four_decimals(x)
    return @sprintf("%.4f", x)
end

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
)

# 打印结果
println("结果:")
println(result_data)

# 将结果保存到CSV文件
CSV.write("酒精浓度实验结果/结果.csv", result_data)
