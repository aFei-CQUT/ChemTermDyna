# 化工热力学作业

姓名：邓正果
班级：122150103
学号：12215990214
课程：化工热力学

---

## `第一题`

### python代码

```python
# 定义常量
T = 400.15  # 温度, 单位: K
P = 1.5 * 10**6  # 压力, 单位：Pa
R = 8.314  # 气体常数, J/(mol·K)
k12 = 0.15  # 给定的k12值
y1 = 0.5
y2 = 0.5

# 查表的信息
# 乙烷
Tc1, Pc1, Vc1, Zc1, w1 = 305.4, 4.884 * 10**6, 148, 0.285, 0.098
# 丙烯
Tc2, Pc2, Vc2, Zc2, w2 = 365.0, 4.620 * 10**6, 181, 0.275, 0.148

# 维里方程的计算
def virial_B0ii(Tr):
    return 0.083 - (0.422 / Tr**1.6)

def virial_B1ii(Tr):
    return 0.139 - (0.172 / Tr**4.2)

def virial_coefficient(Tc, Pc, B0, B1, w):
    return (R * Tc / Pc) * (B0 + w * B1)

# 计算B11和B22
Tr1 = T / Tc1
B011 = virial_B0ii(Tr1)
B111 = virial_B1ii(Tr1)
B11 = virial_coefficient(Tc1, Pc1, B011, B111, w1)

Tr2 = T / Tc2
B022 = virial_B0ii(Tr2)
B122 = virial_B1ii(Tr2)
B22 = virial_coefficient(Tc2, Pc2, B022, B122, w2)

# Prausnitz混合规则
Tc12 = (Tc1 * Tc2)**0.5 * (1 - k12)
w12 = (w1 + w2) / 2
Zc12 = (Zc1 + Zc2) / 2
Vc12 = ((Vc1**(1/3) + Vc2**(1/3)) / 2)**3
Pc12 = Zc12 * R * Tc12 / (Vc12 * 10**(-6))

# 计算B12
Tr12 = T / Tc12
B012 = virial_B0ii(Tr12)
B112 = virial_B1ii(Tr12)
B12 = virial_coefficient(Tc12, Pc12, B012, B112, w12)

# 混合气体的维里系数
Bm = y1**2 * B11 + 2 * y1 * y2 * B12 + y2**2 * B22
Zm = 1 + (Bm * P) / (R * T)
V = Zm * R * T / P
print(f"使用维里方程计算的摩尔体积: {V:.6f} m³/mol")

# R-K方程的计算
Tcm = 0.5 * Tc1 + 0.5 * Tc2
Pcm = 0.5 * Pc1 + 0.5 * Pc2

def rk_ab(Tc, Pc):
    a = 0.42748 * R**2 * Tc**2.5 / Pc
    b = 0.08664 * R * Tc / Pc
    return a, b

def rk_v(V0, a, b, P, T):
    return R * T / P + b - (a * (V0 - b)) / (P * T**(1/2) * V0 * (V0 + b))

a, b = rk_ab(Tcm, Pcm)
V0 = R * T / P
V1 = rk_v(V0, a, b, P, T)
n = 1
while abs(V1 - V0) > 10**(-6):
    V0 = V1
    V1 = rk_v(V0, a, b, P, T)
    n += 1

print(f"使用R-K方程计算的摩尔体积: {V1:.6f} m³/mol")
print("使用R-K方程计算的次数:", n)
```

### 输出结果

输出结果如下：

使用维里方程计算的摩尔体积: 0.002105 m³/mol
使用R-K方程计算的摩尔体积: 0.002073 m³/mol
使用R-K方程计算的次数: 3

## `第二题`

### python代码

```python
# 定义常量
R = 8.314 # 气体常数, J/(mol·K)
T = 422 # 温度, K
P = 50 * 10**5 # 压力, Pa
y1 = 0.5
y2 = 0.5
k12 = 0 # 近似为0

# 查表甲烷和乙烷的临界温度、压力和偏心因子
Tc1, Pc1, Vc1, Zc1, w1 = 190.6, 4.60 * 10**6, 99 * 10**-6, 0.288, 0.008 # 甲烷，Vc1单位转换为m³/mol
Tc2, Pc2, Vc2, Zc2, w2 = 305.4, 4.88 * 10**6, 148 * 10**-6, 0.285, 0.098 # 乙烷，Vc2单位转换为m³/mol

# 使用 Kay 规则计算虚拟临界温度和压力
Tc_mix = y1 * Tc1 + y2 * Tc2
Pc_mix = y1 * Pc1 + y2 * Pc2

Tprm = T / Tc_mix
Pprm = P / Pc_mix

print(f"Kay 规则下计算的虚拟临界温度 Tc: {Tc_mix:.2f} K")
print(f"Kay 规则下计算的虚拟临界压力 Pc: {Pc_mix:.2f} Pa")
print(f"虚拟对比参数 Tprm: {Tprm:.2f}")
print(f"虚拟对比参数 Pprm: {Pprm:.2f}")

# 甲烷virial系数的计算
def virial_B0ii(Tr):
    return 0.083 - (0.422 / Tr**1.6)

def virial_B1ii(Tr):
    return 0.139 - (0.172 / Tr**4.2)

def virial_Bii(Tc, Pc, B0, B1, w):
    return (R * Tc / Pc) * (B0 + w * B1)

# B11的计算
Tr1 = T / Tc1
B011 = virial_B0ii(Tr1)
B111 = virial_B1ii(Tr1)
B11 = virial_Bii(Tc1, Pc1, B011, B111, w1)

# 乙烷的第二virial系数
Tr2 = T / Tc2
B022 = virial_B0ii(Tr2)
B122 = virial_B1ii(Tr2)
B22 = virial_Bii(Tc2, Pc2, B022, B122, w2)

# Prausnitz提出的混合规则
Tc12 = (Tc1 * Tc2)**0.5 * (1 - k12)
w12 = (w1 + w2) / 2
Zc12 = (Zc1 + Zc2) / 2
Vc12 = ((Vc1**(1/3) + Vc2**(1/3)) / 2)**3
Pc12 = Zc12 * R * Tc12 / Vc12

# B12的计算
Tr12 = T / Tc12
B012 = virial_B0ii(Tr12)
B112 = virial_B1ii(Tr12)
B12 = virial_Bii(Tc12, Pc12, B012, B112, w12)

# 计算混合维里系数 Bm
Bm = y1**2 * B11 + 2 * y1 * y2 * B12 + y2**2 * B22

# 计算压缩因子 Zm 和摩尔体积 V
Zm = 1 + (Bm * P) / (R * T)
V_m3_per_mol = Zm * R * T / P
V_cm3_per_mol = V_m3_per_mol * 1e6  # 转换为 cm³/mol
print(f"使用维里方程计算的摩尔体积: {V_cm3_per_mol:.6f} cm³/mol")

# 摩尔质量和摩尔流量
M_CH4 = 16.04 # 甲烷摩尔质量, g/mol
M_C2H6 = 30.07 # 乙烷摩尔质量, g/mol
total_mass = 454 * 10**3 # kg 转换为 g
M = y1 * M_CH4 + y2 * M_C2H6  # 计算混合物的平均摩尔质量
n = total_mass / M  # 计算总摩尔数
V_liu_cm3 = n * V_cm3_per_mol  # 计算体积流量，并转换为 cm³/h
print(f"使用维里方程计算的体积流量: {V_liu_cm3 * 10**(-6):.6f} m³/h")
```

### 输出结果

输出结果如下：

Kay 规则下计算的虚拟临界温度 Tc: 248.00 K
Kay 规则下计算的虚拟临界压力 Pc: 4740000.00 Pa
虚拟对比参数 Tprm: 1.70
虚拟对比参数 Pprm: 1.05
使用维里方程计算的摩尔体积: 660.383489 cm³/mol
使用维里方程计算的体积流量: 13.004299 m³/h