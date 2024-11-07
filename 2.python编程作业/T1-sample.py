#%% 导入必要的库
import math

# 定义常量
R = 8.314  # 气体常数, J/(mol·K)
T = 400.15  # 温度, K
P = 1.5 * 10**6  # 压力, Pa
k12 = 0.15  # 给定的k12值
y_i = 0.5  # 乙烷摩尔分数
y_j = 0.5  # 丙烯摩尔分数

# 乙烷(i)和丙烯(j)的临界参数和偏心因子
Tc_i, Pc_i, Vc_i, Zc_i, omega_i = 305.4, 4.88 * 10**6, 148 * 10**(-6), 0.285, 0.099
Tc_j, Pc_j, Vc_j, Zc_j, omega_j = 365.0, 4.62 * 10**6, 181 * 10**(-6), 0.275, 0.142

# 计算对比温度
Tr_i, Tr_j = T / Tc_i, T / Tc_j

#%%----------------- 维里方程相关 -----------------#%%
# 维里方程相关函数定义
def virial_B0(Tr):
    return 0.083 - (0.422 / Tr**1.6)

def virial_B1(Tr):
    return 0.139 - (0.172 / Tr**4.2)

def virial_B(B0, B1, Tc, Pc, omega):
    return (R * Tc / Pc) * (B0 + omega * B1)

# B_i 和 B_j 计算
B0_i = virial_B0(Tr_i)
B1_i = virial_B1(Tr_i)
B_i = virial_B(B0_i, B1_i, Tc_i, Pc_i, omega_i)

B0_j = virial_B0(Tr_j)
B1_j = virial_B1(Tr_j)
B_j = virial_B(B0_j, B1_j, Tc_j, Pc_j, omega_j)

# 混合规则 (Prausnitz)
Tc_ij = math.sqrt(Tc_i * Tc_j) * (1 - k12)
omega_ij = (omega_i + omega_j) / 2
Zc_ij = (Zc_i + Zc_j) / 2
Vc_ij = ((Vc_i**(1/3) + Vc_j**(1/3)) / 2)**3
Pc_ij = Zc_ij * R * Tc_ij / Vc_ij

# B_ij 计算
Tr_ij = T / Tc_ij
B0_ij = virial_B0(Tr_ij)
B1_ij = virial_B1(Tr_ij)
B_ij = virial_B(B0_ij, B1_ij, Tc_ij, Pc_ij, omega_ij)

# 混合维里系数 Bm
Bm = y_i**2 * B_i + 2 * y_i * y_j * B_ij + y_j**2 * B_j

# 维里方程计算摩尔体积
def virial_equation():
    Zm = 1 + (Bm * P) / (R * T)
    V = Zm * R * T / P
    return V

V_virial = virial_equation()
print(f"使用维里方程计算的摩尔体积: {V_virial:.6f} m³/mol")

#%%----------------- R-K 方程相关 -----------------#%%
# 计算RK方程的a和b参数
def calculate_ab_rk(Tc, Pc):
    a = 0.42748 * R**2 * Tc**2.5 / Pc
    b = 0.08664 * R * Tc / Pc
    return a, b

# 计算RK参数
a_i_rk, b_i_rk = calculate_ab_rk(Tc_i, Pc_i)
a_j_rk, b_j_rk = calculate_ab_rk(Tc_j, Pc_j)

# Prausnitz混合规则
def mix_parameters(y1, y2, a1, a2, b1, b2):
    a12 = math.sqrt(a1 * a2) * (1 - k12)
    a_mix = y1**2 * a1 + 2 * y1 * y2 * a12 + y2**2 * a2
    b_mix = y1 * b1 + y2 * b2
    return a_mix, b_mix

a_mix_rk, b_mix_rk = mix_parameters(y_i, y_j, a_i_rk, a_j_rk, b_i_rk, b_j_rk)

# 牛顿迭代法
def newton_method(f, df, x0, epsilon=1e-6, max_iter=100):
    x = x0
    for _ in range(max_iter):
        fx = f(x)
        if abs(fx) < epsilon:
            return x
        dfx = df(x)
        if dfx == 0:
            return None
        x = x - fx / dfx
    return None

# R-K方程（显压式）
def rk_equation(a, b):
    def f(V):
        return (R * T / (V - b) - a / (T**0.5 * V * (V + b))) - P
    
    def df(V):
        return (-R * T / (V - b)**2 + a * (2*V + b) / (T**0.5 * V**2 * (V + b)**2))
    
    V = newton_method(f, df, R*T/P)
    return V

V_rk = rk_equation(a_mix_rk, b_mix_rk)
if V_rk is not None:
    print(f"使用R-K方程计算的摩尔体积: {V_rk:.6f} m³/mol")
else:
    print("R-K方程求解失败")

#%%----------------- SRK 方程相关 -----------------#%%
# 计算SRK方程的a和b参数
def calculate_ab_srk(Tc, Pc, omega, Tr):
    a0 = 0.42747 * R**2 * Tc**2 / Pc
    m = 0.480 + 1.574 * omega - 0.176 * omega**2
    a = a0 * (1 + m * (1 - math.sqrt(Tr)))**2
    b = 0.08664 * R * Tc / Pc
    return a, b

# 计算SRK参数
a_i_srk, b_i_srk = calculate_ab_srk(Tc_i, Pc_i, omega_i, Tr_i)
a_j_srk, b_j_srk = calculate_ab_srk(Tc_j, Pc_j, omega_j, Tr_j)

a_mix_srk, b_mix_srk = mix_parameters(y_i, y_j, a_i_srk, a_j_srk, b_i_srk, b_j_srk)

# SRK方程（显压式）
def srk_equation(a, b):
    def f(V):
        return (R * T / (V - b) - a / (V * (V + b))) - P
    
    def df(V):
        return (-R * T / (V - b)**2 + a * (2*V + b) / (V**2 * (V + b)**2))
    
    V = newton_method(f, df, R*T/P)
    return V

V_srk = srk_equation(a_mix_srk, b_mix_srk)
if V_srk is not None:
    print(f"使用SRK方程计算的摩尔体积: {V_srk:.6f} m³/mol")
else:
    print("SRK方程求解失败")
