# %% 导入库
import math
from tabulate import tabulate

# %% 常量定义
R = 8.314                        # J/(mol·K)
T = 422                          # K
P = 50 * 1e5                     # Pa
y = [0.5, 0.5]                   # 量纲 1
k_ij = 0                         # 量纲 1
m_mix = 454000                   # g
M = [16.04, 30.07]               # g/mol
Tc = [190.6, 305.4]              # K
Pc = [4.600e6, 4.884e6]          # Pa
Vc = [99e-6, 148e-6]             # m³/mol
Zc = [0.288, 0.285]              # 量纲 1
omega = [0.008, 0.098]           # 量纲 1

# %% Kay规则计算虚拟临界参数
def kay_rule(y, params):
    return sum(y[i] * params[i] for i in range(len(y)))

Tc_mix = kay_rule(y, Tc)
Pc_mix = kay_rule(y, Pc)

# 计算虚拟临界对比参数
Tr_mix = T / Tc_mix
Pr_mix = P / Pc_mix

# 输出虚拟临界参数和虚拟临界对比参数
print("Kay规则计算的虚拟临界参数和虚拟临界对比参数：")
kay_params = [
    ["Tc_mix", Tc_mix, "K"],
    ["Pc_mix", Pc_mix, "Pa"],
    ["Tr_mix", Tr_mix, "量纲 1"],
    ["Pr_mix", Pr_mix, "量纲 1"]
]
print(tabulate(kay_params, headers=["参数", "值", "单位"], tablefmt='grid'))
print()

# %% Prausnitz混合规则计算交叉项
def prausnitz_mixture_params(Tc, Pc, Vc, Zc, omega, k_ij):
    result = []
    for i in range(2):
        for j in range(2):
            Tc_ij = math.sqrt(Tc[i] * Tc[j]) * (1 - k_ij)
            Vc_ij = ((Vc[i]**(1/3) + Vc[j]**(1/3)) / 2)**3
            Zc_ij = (Zc[i] + Zc[j]) / 2
            Pc_ij = Zc_ij * R * Tc_ij / Vc_ij
            omega_ij = (omega[i] + omega[j]) / 2
            result.append([Tc_ij, Pc_ij, Vc_ij, Zc_ij, omega_ij])
    return result

# 计算特征参数表
mixture_params_table = prausnitz_mixture_params(Tc, Pc, Vc, Zc, omega, k_ij)
columns = ["T_c / K", "p_c / Pa", "V_c / (m³/mol)", "Z_c", "omega"]
df_params = [["ii"] + mixture_params_table[0],
             ["ij"] + mixture_params_table[1],
             ["ji"] + mixture_params_table[2],
             ["jj"] + mixture_params_table[3]]

print("混合物特征参数表：")
print(tabulate(df_params, headers=[""] + columns, tablefmt='grid'))

# %% 计算第二维里系数 B（适用于纯物质）
def virial_B0(Tr):
    return 0.083 - (0.422 / Tr**1.6)

def virial_B1(Tr):
    return 0.139 - (0.172 / Tr**4.2)

def virial_B(Tc, Pc, B0, B1, omega):
    return (R * Tc / Pc) * (B0 + omega * B1)

# 计算维里系数矩阵B
B_matrix = []
for i in range(2):
    row = []
    for j in range(2):
        Tr = T / mixture_params_table[i*2+j][0]
        B0 = virial_B0(Tr)
        B1 = virial_B1(Tr)
        B = virial_B(mixture_params_table[i*2+j][0], mixture_params_table[i*2+j][1], B0, B1, mixture_params_table[i*2+j][4])
        row.append([B0, B1, B])
    B_matrix.append(row)

# 表格显示第二维里系数
B_table_data = [
    ["ii"] + B_matrix[0][0],
    ["ij"] + B_matrix[0][1],
    ["ji"] + B_matrix[1][0],
    ["jj"] + B_matrix[1][1]
]

print("\n维里系数表：")
print(tabulate(B_table_data, headers=["i j", "B^{(0)}", "B^{(1)}", "B / (m³/mol)"], tablefmt='grid'))

# %% 混合维里系数 B_m
def mix_virial_B_m(y, B_matrix):
    B_m = 0
    for i in range(2):
        for j in range(2):
            B_m += y[i] * y[j] * B_matrix[i][j][2]
    return B_m

# 计算混合物的 B_m
B_m = mix_virial_B_m(y, B_matrix)
print(f"\n混合物的维里系数 B_m = {B_m:.6f} m³/mol")

# 计算混合压缩因子 Z_m 和体积流量
def calculate_Z(B_m, P, T):
    return 1 + (B_m * P) / (R * T)

def calculate_volume_flow(Z, P, T, m_mix, M, y):
    M_mix = y[0] * M[0] + y[1] * M[1]
    n_total = m_mix / M_mix
    Vm_mix = (R * T) / P * Z
    V_total = Vm_mix * n_total
    volume_flow_mix = V_total * 1e6
    return volume_flow_mix

# %% 计算混合压缩因子 Z_m 和体积流量
Z_m = calculate_Z(B_m, P, T)
print(f"混合压缩因子 Z_m = {Z_m:.6f}")
# 计算体积流量
volume_flow_mix = calculate_volume_flow(Z_m, P, T, m_mix, M, y)

print("离开压缩机的气体体积流率为：{:.6f} cm³/h".format(volume_flow_mix))
print("若换算为立方米每时为：{:.6f} m³/h".format(volume_flow_mix / 1e6))
