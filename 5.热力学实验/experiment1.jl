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
