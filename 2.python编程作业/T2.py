# %% 导入库
import numpy as np
import pandas as pd
from tabulate import tabulate

# %% 常量定义
R = 8.314                        # J/(mol·K)
T = 422                          # K
P = 50 * 1e5                     # Pa
y = np.array([0.5, 0.5])         # 量纲 1
k_ij = 0                         # 量纲 1
m_mix = 454000                   # g
M = np.array([16.04, 30.07])     # g/mol
Tc = np.array([190.6, 305.4])    # K
Pc = np.array([4.600e6, 4.884e6])# Pa
Vc = np.array([99, 148]) * 1e-6  # m³/mol
Zc = np.array([0.288, 0.285])    # 量纲 1
omega = np.array([0.008, 0.098]) # 量纲 1

# %% Kay规则计算虚拟临界参数
def kay_rule(y, params):
    return np.sum(y * params)

Tc_mix = kay_rule(y, Tc)
Pc_mix = kay_rule(y, Pc)

# 计算虚拟临界对比参数
Tr_mix = T / Tc_mix
Pr_mix = P / Pc_mix

# 输出虚拟临界参数和虚拟临界对比参数
print("Kay规则计算的虚拟临界参数和虚拟临界对比参数：")
kay_params = {
    "参数": ["Tc_mix", "Pc_mix", "Tr_mix", "Pr_mix"],
    "值": [Tc_mix, Pc_mix, Tr_mix, Pr_mix],
    "单位": ["K", "Pa", "量纲 1", "量纲 1"]
}
print(tabulate(pd.DataFrame(kay_params), headers='keys', tablefmt='grid', showindex=False))
print()

# %% Prausnitz混合规则计算交叉项
def prausnitz_mixture_params(Tc, Pc, Vc, Zc, omega, k_ij):
    Tc_ij = np.sqrt(np.outer(Tc, Tc)) * (1 - k_ij)
    Vc_ij = ((np.cbrt(Vc[:, None]) + np.cbrt(Vc)) / 2)**3
    Zc_ij = (Zc[:, None] + Zc) / 2
    Pc_ij = Zc_ij * R * Tc_ij / Vc_ij
    omega_ij = (omega[:, None] + omega) / 2
    return np.stack([Tc_ij, Pc_ij, Vc_ij, Zc_ij, omega_ij], axis=-1)

# 计算混合参数（交叉项）
mixture_params_table = prausnitz_mixture_params(Tc, Pc, Vc, Zc, omega, k_ij)
columns = ["T_c / K", "p_c / Pa", "V_c / (m³/mol)", "Z_c", "omega"]
df_params = pd.DataFrame(mixture_params_table.reshape(-1, 5),
                         index=["ii", "ij", "ji", "jj"], columns=columns)

# 使用 tabulate 输出混合参数（交叉项）
print("混合参数（交叉项）：")
print(tabulate(df_params, headers='keys', tablefmt='grid', showindex=True))

# %% 计算第二维里系数 B（适用于纯物质）
def virial_B0(Tr):
    return 0.083 - (0.422 / Tr**1.6)

def virial_B1(Tr):
    return 0.139 - (0.172 / Tr**4.2)

def virial_B(Tc, Pc, B0, B1, omega):
    return (R * Tc / Pc) * (B0 + omega * B1)

# 对比温度矩阵
Tr_matrix = T / mixture_params_table[..., 0]

# 计算B0和B1矩阵
B0_matrix = virial_B0(Tr_matrix)
B1_matrix = virial_B1(Tr_matrix)

# 计算维里系数矩阵B
B_matrix = virial_B(mixture_params_table[..., 0], mixture_params_table[..., 1],
                    B0_matrix, B1_matrix, mixture_params_table[..., 4])

# 表格显示第二维里系数
B_table_data = {
    "i j": ["ii", "ij", "ji", "jj"],
    "B^{(0)}": B0_matrix.flatten(),
    "B^{(1)}": B1_matrix.flatten(),
    "B / (m³/mol)": B_matrix.flatten()
}
df_B = pd.DataFrame(B_table_data)

# 使用 tabulate 输出维里系数表
print("\n维里系数表：")
print(tabulate(df_B, headers='keys', tablefmt='grid', showindex=False))

# %% 混合维里系数 B_m
def mix_virial_B_m(y, B_matrix):
    return np.dot(y, np.dot(B_matrix, y))

# 计算混合物的 B_m
B_m = mix_virial_B_m(y, B_matrix)
print(f"\n混合物的维里系数 B_m = {B_m:.6f} m³/mol")

# %% 计算混合压缩因子 Z_m 和体积流量
def calculate_Z(B_m, P, T):
    return 1 + (B_m * P) / (R * T)

def calculate_volume_flow(Z, P, T, m_mix, M, y):
    M_mix = np.dot(y, M)
    n_total = m_mix / M_mix
    Vm_mix = (R * T) / P * Z
    V_total = Vm_mix * n_total
    volume_flow_mix = V_total * 1e6
    return volume_flow_mix

# 计算压缩因子 Z
Z_m = calculate_Z(B_m, P, T)
print(f"混合压缩因子 Z_m = {Z_m:.6f}")
# 计算体积流量
volume_flow_mix = calculate_volume_flow(Z_m, P, T, m_mix, M, y)

print("离开压缩机的气体体积流率为：{:.6f} cm³/h".format(volume_flow_mix))
print("若换算为立方米每时为：{:.6f} m³/h".format(volume_flow_mix / 1e6))
