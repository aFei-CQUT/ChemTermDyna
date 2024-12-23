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

#let data = (
  (10.0000, 3.3133, 0.0000, 0.0013, false),
  (10.0000, 3.6132, 43.0000, 0.0012, false),
  (10.0000, 3.9132, 81.0000, 0.0010, false),
  (10.0000, 4.2133, 117.0000, 0.0009, false),
  (10.0000, 4.5133, 142.0000, 0.0008, false),
  (10.0000, 4.8133, 167.0000, 0.0007, false),
  (10.0000, 5.1132, 188.0000, 0.0006, false),
  (10.0000, 5.4133, 208.0000, 0.0006, false),
  (10.0000, 5.5633, 227.0000, 0.0005, true),
  (10.0000, 5.5933, 232.0000, 0.0005, false),
  (10.0000, 5.6132, 250.0000, 0.0004, false),
  (10.0000, 5.6132, 255.0000, 0.0004, false),
  (10.0000, 5.6333, 260.0000, 0.0004, false),
  (10.0000, 5.6633, 265.0000, 0.0004, false),
  (10.0000, 5.6633, 275.0000, 0.0003, false),
  (10.0000, 5.6633, 270.0000, 0.0003, false),
  (10.0000, 5.6633, 275.0000, 0.0003, false),
  (10.0000, 5.6633, 280.0000, 0.0003, false),
  (10.0000, 5.6633, 285.0000, 0.0003, false),
  (10.0000, 5.6633, 290.0000, 0.0003, false),
  (10.0000, 5.6932, 295.0000, 0.0002, false),
  (10.0000, 5.7133, 300.0000, 0.0002, false),
  (10.0000, 5.7233, 305.0000, 0.0002, false),
  (10.0000, 5.8632, 316.0000, 0.0002, false),
  (10.0000, 5.9333, 320.0000, 0.0001, false),
  (10.0000, 6.1333, 325.0000, 0.0001, false),
  (10.0000, 6.4633, 330.0000, 0.0001, false),
  (10.0000, 7.6132, 335.0000, 0.0001, false),
  (10.0000, 9.0132, 337.0000, 0.0001, false),
  (15.0000, 3.4233, 0.0000, 0.0013, false),
  (15.0000, 3.7133, 41.0000, 0.0012, false),
  (15.0000, 4.0133, 79.0000, 0.0010, false),
  (15.0000, 4.3133, 112.0000, 0.0009, false),
  (15.0000, 4.6132, 139.0000, 0.0008, false),
  (15.0000, 4.9132, 163.0000, 0.0007, false),
  (15.0000, 5.2133, 185.0000, 0.0006, false),
  (15.0000, 5.5133, 204.0000, 0.0006, false),
  (15.0000, 5.8133, 222.0000, 0.0005, false),
  (15.0000, 6.1132, 241.0000, 0.0004, false),
  (15.0000, 6.1233, 245.0000, 0.0004, true),
  (15.0000, 6.1333, 250.0000, 0.0004, false),
  (15.0000, 6.1333, 255.0000, 0.0004, false),
  (15.0000, 6.1433, 260.0000, 0.0004, false),
  (15.0000, 6.1532, 265.0000, 0.0004, false),
  (15.0000, 6.1333, 270.0000, 0.0003, false),
  (15.0000, 6.1532, 275.0000, 0.0003, false),
  (15.0000, 6.1932, 280.0000, 0.0003, false),
  (15.0000, 6.2133, 285.0000, 0.0003, false),
  (15.0000, 6.2332, 290.0000, 0.0003, false),
  (15.0000, 6.2633, 295.0000, 0.0002, false),
  (15.0000, 6.3133, 300.0000, 0.0002, false),
  (15.0000, 6.3632, 305.0000, 0.0002, false),
  (15.0000, 6.4133, 310.0000, 0.0002, false),
  (15.0000, 6.4733, 315.0000, 0.0002, false),
  (15.0000, 6.5533, 320.0000, 0.0001, false),
  (15.0000, 6.7133, 325.0000, 0.0001, false),
  (15.0000, 6.9933, 330.0000, 0.0001, false),
  (15.0000, 7.9133, 335.0000, 0.0001, false),
  (15.0000, 9.0132, 336.0000, 0.0001, false),
  (20.0000, 3.4333, 0.0000, 0.0013, false),
  (20.0000, 3.7133, 34.0000, 0.0012, false),
  (20.0000, 4.0133, 74.0000, 0.0011, false),
  (20.0000, 4.3133, 105.0000, 0.0009, false),
  (20.0000, 4.6132, 132.0000, 0.0008, false),
  (20.0000, 4.9132, 156.0000, 0.0008, false),
  (20.0000, 5.2133, 177.0000, 0.0007, false),
  (20.0000, 5.5133, 196.0000, 0.0006, false),
  (20.0000, 5.8133, 213.0000, 0.0005, false),
  (20.0000, 6.1132, 228.0000, 0.0005, false),
  (20.0000, 6.4133, 242.0000, 0.0004, false),
  (20.0000, 6.7133, 261.0000, 0.0004, true),
  (20.0000, 6.7233, 265.0000, 0.0004, false),
  (20.0000, 6.7332, 271.0000, 0.0003, false),
  (20.0000, 6.7433, 275.0000, 0.0003, false),
  (20.0000, 6.7533, 280.0000, 0.0003, false),
  (20.0000, 6.7933, 285.0000, 0.0003, false),
  (20.0000, 6.8033, 290.0000, 0.0003, false),
  (20.0000, 6.8232, 295.0000, 0.0002, false),
  (20.0000, 6.8333, 300.0000, 0.0002, false),
  (20.0000, 6.8933, 305.0000, 0.0002, false),
  (20.0000, 6.9432, 310.0000, 0.0002, false),
  (20.0000, 7.0232, 315.0000, 0.0002, false),
  (20.0000, 7.1233, 320.0000, 0.0001, false),
  (20.0000, 7.2933, 325.0000, 0.0001, false),
  (20.0000, 7.5133, 330.0000, 0.0001, false),
  (20.0000, 9.0132, 335.0000, 0.0001, false),
  (25.0000, 3.5332, 0.0000, 0.0013, false),
  (25.0000, 3.8133, 38.0000, 0.0012, false),
  (25.0000, 4.1132, 74.0000, 0.0011, false),
  (25.0000, 4.4132, 105.0000, 0.0009, false),
  (25.0000, 4.7133, 131.0000, 0.0009, false),
  (25.0000, 5.0133, 153.0000, 0.0008, false),
  (25.0000, 5.3133, 175.0000, 0.0007, false),
  (25.0000, 5.6132, 192.0000, 0.0006, false),
  (25.0000, 5.9133, 207.0000, 0.0006, false),
  (25.0000, 6.2133, 222.0000, 0.0005, false),
  (25.0000, 6.5133, 237.0000, 0.0005, false),
  (25.0000, 6.8133, 249.0000, 0.0004, false),
  (25.0000, 7.1132, 261.0000, 0.0004, false),
  (25.0000, 7.4133, 278.0000, 0.0003, true),
  (25.0000, 7.4333, 285.0000, 0.0003, false),
  (25.0000, 7.4933, 294.0000, 0.0002, false),
  (25.0000, 7.5133, 297.0000, 0.0002, false),
  (25.0000, 7.5433, 304.0000, 0.0002, false),
  (25.0000, 7.6233, 310.0000, 0.0002, false),
  (25.0000, 7.7332, 315.0000, 0.0002, false),
  (25.0000, 7.8632, 320.0000, 0.0001, false),
  (25.0000, 8.0132, 325.0000, 0.0001, false),
  (25.0000, 8.3733, 330.0000, 0.0001, false),
  (25.0000, 8.8133, 332.0000, 0.0001, false),
  (25.0000, 9.0132, 333.0000, 0.0001, false),
  (31.1000, 3.6132, 0.0000, 0.0013, false),
  (31.1000, 3.9132, 40.0000, 0.0012, false),
  (31.1000, 4.2133, 74.0000, 0.0011, false),
  (31.1000, 4.5133, 103.0000, 0.0010, false),
  (31.1000, 4.8133, 127.0000, 0.0009, false),
  (31.1000, 5.1132, 150.0000, 0.0008, false),
  (31.1000, 5.4133, 170.0000, 0.0007, false),
  (31.1000, 5.7133, 187.0000, 0.0006, false),
  (31.1000, 6.0133, 202.0000, 0.0006, false),
  (31.1000, 6.3133, 212.0000, 0.0005, false),
  (31.1000, 6.6132, 229.0000, 0.0005, false),
  (31.1000, 6.9133, 240.0000, 0.0004, false),
  (31.1000, 7.2133, 252.0000, 0.0004, false),
  (31.1000, 7.5133, 263.0000, 0.0004, false),
  (31.1000, 7.8133, 273.0000, 0.0003, false),
  (31.1000, 8.1132, 286.0000, 0.0003, false),
  (31.1000, 8.4132, 302.0000, 0.0002, true),
  (31.1000, 8.4432, 310.0000, 0.0002, false),
  (31.1000, 8.5332, 315.0000, 0.0002, false),
  (31.1000, 8.6632, 320.0000, 0.0001, false),
  (31.1000, 8.8432, 325.0000, 0.0001, false),
  (31.1000, 9.0132, 327.0000, 0.0001, false),
  (35.0000, 3.6932, 0.0000, 0.0013, false),
  (35.0000, 4.0133, 40.0000, 0.0012, false),
  (35.0000, 4.3133, 80.0000, 0.0010, false),
  (35.0000, 4.6132, 108.0000, 0.0009, false),
  (35.0000, 4.9132, 130.0000, 0.0009, false),
  (35.0000, 5.2133, 153.0000, 0.0008, false),
  (35.0000, 5.5133, 172.0000, 0.0007, false),
  (35.0000, 5.8133, 188.0000, 0.0006, false),
  (35.0000, 6.1132, 202.0000, 0.0006, false),
  (35.0000, 6.4133, 215.0000, 0.0005, false),
  (35.0000, 6.7133, 228.0000, 0.0005, false),
  (35.0000, 7.0133, 239.0000, 0.0004, false),
  (35.0000, 7.3133, 249.0000, 0.0004, false),
  (35.0000, 7.6132, 259.0000, 0.0004, false),
  (35.0000, 7.9133, 270.0000, 0.0003, false),
  (35.0000, 8.2133, 279.0000, 0.0003, false),
  (35.0000, 8.5132, 288.0000, 0.0003, false),
  (35.0000, 8.8133, 299.0000, 0.0002, false),
  (35.0000, 9.0132, 307.0000, 0.0002, false),
  (40.0000, 3.7332, 0.0000, 0.0013, false),
  (40.0000, 4.0133, 38.0000, 0.0012, false),
  (40.0000, 4.3133, 72.0000, 0.0011, false),
  (40.0000, 4.6132, 99.0000, 0.0010, false),
  (40.0000, 4.9132, 121.0000, 0.0009, false),
  (40.0000, 5.2133, 144.0000, 0.0008, false),
  (40.0000, 5.5133, 162.0000, 0.0007, false),
  (40.0000, 5.8133, 179.0000, 0.0007, false),
  (40.0000, 6.1132, 194.0000, 0.0006, false),
  (40.0000, 6.4133, 207.0000, 0.0006, false),
  (40.0000, 6.7133, 221.0000, 0.0005, false),
  (40.0000, 7.0133, 231.0000, 0.0005, false),
  (40.0000, 7.3133, 242.0000, 0.0004, false),
  (40.0000, 7.6132, 251.0000, 0.0004, false),
  (40.0000, 7.9133, 260.0000, 0.0004, false),
  (40.0000, 8.2133, 268.0000, 0.0003, false),
  (40.0000, 8.5132, 277.0000, 0.0003, false),
  (40.0000, 8.8133, 284.0000, 0.0003, false),
  (40.0000, 9.0132, 289.0000, 0.0003, false),
  (50.0000, 3.8332, 0.0000, 0.0013, false),
  (50.0000, 4.1132, 33.0000, 0.0012, false),
  (50.0000, 4.4132, 61.0000, 0.0011, false),
  (50.0000, 4.7133, 93.0000, 0.0010, false),
  (50.0000, 5.0133, 116.0000, 0.0009, false),
  (50.0000, 5.3133, 138.0000, 0.0008, false),
  (50.0000, 5.6132, 156.0000, 0.0008, false),
  (50.0000, 5.9133, 173.0000, 0.0007, false),
  (50.0000, 6.2133, 188.0000, 0.0006, false),
  (50.0000, 6.5133, 200.0000, 0.0006, false),
  (50.0000, 6.8133, 213.0000, 0.0005, false),
  (50.0000, 7.1132, 223.0000, 0.0005, false),
  (50.0000, 7.4133, 233.0000, 0.0005, false),
  (50.0000, 7.7133, 241.0000, 0.0004, false),
  (50.0000, 8.0132, 250.0000, 0.0004, false),
  (50.0000, 8.3133, 258.0000, 0.0004, false),
  (50.0000, 8.6132, 264.0000, 0.0004, false),
  (50.0000, 8.9132, 270.0000, 0.0003, false),
  (50.0000, 9.0132, 273.0000, 0.0003, false),
  (60.0000, 4.0133, 0.0000, 0.0013, false),
  (60.0000, 4.3133, 41.0000, 0.0012, false),
  (60.0000, 4.6132, 70.0000, 0.0011, false),
  (60.0000, 4.9132, 92.0000, 0.0010, false),
  (60.0000, 5.2133, 118.0000, 0.0009, false),
  (60.0000, 5.5133, 139.0000, 0.0008, false),
  (60.0000, 5.8133, 149.0000, 0.0008, false),
  (60.0000, 6.1132, 169.0000, 0.0007, false),
  (60.0000, 6.4133, 183.0000, 0.0007, false),
  (60.0000, 6.7133, 191.0000, 0.0006, false),
  (60.0000, 7.0133, 207.0000, 0.0006, false),
  (60.0000, 7.3133, 212.0000, 0.0005, false),
  (60.0000, 7.6132, 221.0000, 0.0005, false),
  (60.0000, 7.9133, 234.0000, 0.0005, false),
  (60.0000, 8.2133, 242.0000, 0.0004, false),
  (60.0000, 8.5132, 249.0000, 0.0004, false),
  (60.0000, 8.8133, 255.0000, 0.0004, false),
  (60.0000, 9.0132, 259.0000, 0.0004, false),
  (70.0000, 4.1132, 0.0000, 0.0013, false),
  (70.0000, 4.4132, 37.0000, 0.0012, false),
  (70.0000, 4.7133, 60.0000, 0.0011, false),
  (70.0000, 5.0133, 91.0000, 0.0010, false),
  (70.0000, 5.3133, 108.0000, 0.0009, false),
  (70.0000, 5.6132, 127.0000, 0.0009, false),
  (70.0000, 5.9133, 148.0000, 0.0008, false),
  (70.0000, 6.2133, 163.0000, 0.0007, false),
  (70.0000, 6.5133, 176.0000, 0.0007, false),
  (70.0000, 6.8133, 188.0000, 0.0006, false),
  (70.0000, 7.1132, 200.0000, 0.0006, false),
  (70.0000, 7.4133, 209.0000, 0.0006, false),
  (70.0000, 7.7133, 218.0000, 0.0005, false),
  (70.0000, 8.0132, 227.0000, 0.0005, false),
  (70.0000, 8.3133, 234.0000, 0.0005, false),
  (70.0000, 8.6132, 241.0000, 0.0004, false),
  (70.0000, 8.9132, 247.0000, 0.0004, false),
  (70.0000, 9.0132, 249.0000, 0.0004, false)
)

#let table-headers = (
  [温度 (°C)], [绝对压力 (MPa)], [高度 (mm)], [比容 (m³/kg)], [标记]
)

#let table-part(part-data, is-last, is-first) = {
  table(
    columns: 5,
    inset: 5pt,
    align: center + horizon,
    stroke: none,
    table.hline(),
    table.header(
      ..table-headers
    ),
    table.hline(),
    ..part-data.map(row => {
      (..row.map(cell => {
        if cell == none { [-] } else { [#cell] }
      }))
    }).flatten(),
    table.hline(),
    if not is-last and not is-first {
      table.cell(colspan: 5, align: center)[续下页]
    }
  )
}

#let chunks = data.chunks(35)
#for (index, chunk) in chunks.enumerate() {
  figure(
    caption: [CO2 PVT实验处理后数据 (第 #(index + 1) 部分)],
    supplement: "表",
    table-part(chunk, index == chunks.len() - 1, index == 0)
  )
  if index == 0 {
    pagebreak(weak: true)
  } else {
    pagebreak()
  }
}


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
using LaTeXStrings
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
h0 = 359                   # 毛细管顶端刻度 (单位: mm)

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

    return df
end

# 分组处理数据
groups = groupby(data, :T)
processed_data = [process_data(group) for group in groups]

# 绘制 P-V 图
plot(size=(1000, 700), legend=:topright, grid=true, gridstyle=:dash, gridalpha=0.5,
    bottom_margin=10mm, left_margin=10mm);
for df in processed_data
    plot!(df.V, df.P, label=L"T = %$(df.T[1])^\circ\mathrm{C}", marker=:circle, markersize=4, linewidth=2)
    # 用不同的标记显示带星号的点
    starred_points = df[df.is_starred, :]
    scatter!(starred_points.V, starred_points.P, label="", marker=:star, markersize=6)
end
xlabel!(L"Specific Volume (m^3/kg)");
ylabel!(L"Pressure (MPa)");
title!(L"P-V Diagram for CO_2");

# 调整 x 轴
xlims!(0, 0.0015);
x_ticks = 0:0.0001:0.0015
x_labels = [L"%$(round(x, digits=4))" for x in x_ticks]
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
```
````