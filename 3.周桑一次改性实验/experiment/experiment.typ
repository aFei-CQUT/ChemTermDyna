#import "../lib.typ": *

#let (
  // 布局函数
  twoside, doc,  mainmatter,  appendix, preface,
  // 页面函数
  fonts-display-page, cover, outline-page, 
) = documentclass(
  twoside: false,  // 双面模式,会加入空白页,便于打印

  info: (
    title: ("一次改性实验计算"),
    author: "非非",
    submit-date: datetime.today(),
    cover-image: "../example/images/cover.jpg", // 封面图片路径,注意是相对于pages/elgeant-cover.typ的路径
    numbering-style:"maths" // "maths":数学或论文风格的标题编号 | "literature":文学风格的标题编号
  ),
)

// 文稿设置
#show: doc

// 引用样式
#show cite: custom-cite

// 封面页
#cover()

// 前言部分
#show: preface

// 目录
#outline-page()

// 字体显示测试页
// #fonts-display-page()

// 正文部分
#show: mainmatter



// -------------------------------------------------------



= 配置500mL质量分数为16%的乙酸溶液

== 已知条件

- 目标溶液体积: $V_t = 500 m l$
- 目标溶液质量分数: $omega = 16% = 0.16$
- 冰醋酸(无水乙酸)密度: $rho_(#ca("CH3COOH")) = 1.049 g "/" m l$
- 水的密度: $rho_(#ca("H2O")) = 1 g "/" m l$

== 基本方程

$ V_t = V_(#ca("H2O")) + V_(#ca("CH3COOH")) $ <eq1>

$ rho_t V_t = rho_(#ca("H2O")) V_(#ca("H2O")) + rho_(#ca("CH3COOH")) V_(#ca("CH3COOH")) $ <eq2>

$ 0.16 = (rho_(#ca("CH3COOH")) V_(#ca("CH3COOH"))) / (rho_(#ca("H2O")) V_(#ca("H2O")) + rho_(#ca("CH3COOH")) V_(#ca("CH3COOH"))) $ <eq3>

== 求解过程

从方程@eqt:eq3 开始推导 $V_(#ca("H2O"))$ 的表达式:

$ 0.16 = (rho_(#ca("CH3COOH")) V_(#ca("CH3COOH"))) / (rho_(#ca("H2O")) V_(#ca("H2O")) + rho_(#ca("CH3COOH")) V_(#ca("CH3COOH"))) $

$ 0.16 (rho_(#ca("H2O")) V_(#ca("H2O")) + rho_(#ca("CH3COOH")) V_(#ca("CH3COOH"))) = rho_(#ca("CH3COOH")) V_(#ca("CH3COOH")) $

$ 0.16 rho_(#ca("H2O")) V_(#ca("H2O")) = rho_(#ca("CH3COOH")) V_(#ca("CH3COOH")) - 0.16 rho_(#ca("CH3COOH")) V_(#ca("CH3COOH")) $

$ 0.16 rho_(#ca("H2O")) V_(#ca("H2O")) = 0.84 rho_(#ca("CH3COOH")) V_(#ca("CH3COOH")) $


$ V_(#ca("H2O")) = (0.84 rho_(#ca("CH3COOH"))) / (0.16 rho_(#ca("H2O"))) times V_(#ca("CH3COOH")) $ <eq4>

将已知的密度值代入@eqt:eq4:

$ V_(#ca("H2O")) = (0.84 times 1.049) / (0.16 times 1) times V_(#ca("CH3COOH")) $

$ V_(#ca("H2O")) = 5.50725 V_(#ca("CH3COOH")) $ <eq5>

将@eqt:eq5 代入@eqt:eq1:

$ 500 = 5.50725 V_(#ca("CH3COOH")) + V_(#ca("CH3COOH")) $
$ 500 = 6.50725 V_(#ca("CH3COOH")) $
$ V_(#ca("CH3COOH")) = 500 / 6.50725 = 76.83737 m l $ <eq6>

由@eqt:eq1 求得 $V_(#ca("H2O"))$:

$ V_(#ca("H2O")) = 500 - 76.83737 = 423.16262 m l $ <eq7>

== 求解结果
+ 无水乙酸(冰醋酸)体积: $V_(#ca("CH3COOH")) = 76.83737 m l$ 
+ 水的体积: $V_(#ca("H2O")) = 423.16262 m l$

== 配置步骤
+ 量取水的体积$V_(#ca("H2O")) = 400 m l$
+ 小心量取无水乙酸(冰醋酸)体积$V_(#ca("CH3COOH")) = 76.83737 m l$
+ 将步骤2中量取的酸缓慢加入步骤1中量取的水中边加边搅拌,转移至容量瓶中定容。

== 注意事项

实际操作时,应先加入约400 ml水,再缓慢加入76.83737 ml无水乙酸,最后用水稀释至500ml刻度,以确保安全和准确。



// -------------------------------------------------------



= 配置500mL pH为5.6的醋酸缓冲溶液

为获得最高最优的缓冲容量,我们选择一个较高的总浓度。考虑到实际应用和溶解度限制,这里选总浓度为0.5 mol / L。使用三水合醋酸钠结晶体(醋酸钠三水合物)和无水乙酸,配置500 mL pH=5.6的醋酸缓冲溶液。

== 已知条件

- 缓冲体系:乙酸(#ca("CH3COOH"))和醋酸根离子(#ca("CH3COO^-"))
- 乙酸电离常数 $p K_a approx 4.76$
- 目标 $p H = 5.6$
- 选择总浓度 $c_t = 0.5 "mol·L"^(-1)$

== 亨德森-哈塞尔巴尔赫方程
Henderson-Hasselbalch equation形式如下(或查阅分析化学书籍 @wu2016)

$ p H = p K_a + log(([#ca("CH3COO^-")])/([#ca("CH3COOH")])) $ <henderson-hasselbalch>

代入已知值得,
$ 5.6 = 4.76 + log(([#ca("CH3COO^-")])/([#ca("CH3COOH")])) $

求得,

$ ([#ca("CH3COO^-")])/([#ca("CH3COOH")]) = 10^(0.84) approx 6.918 $

== 求解过程

缓冲溶液中乙酸(#ca("CH3COOH"))和醋酸根离子(#ca("CH3COO^-"))的总浓度。具体来说,总浓度 ($c_t$) 是指这两种物质在溶液中浓度的总和。

最优缓冲能力的总浓度通常取决于所选的缓冲体系和目标pH值,一般来说,当缓冲溶液的浓度较高时,缓冲能力也会更强。然而,最优缓冲容量并没有固定的数值,而是与实际应用相关。通常情况下,我们会选择一个既能保证较高缓冲容量,又不至于因为溶解度限制或其他因素造成溶液不稳定的浓度。

这里我们取总浓度为0.5 mol / L 作为缓冲溶液的浓度,这个浓度值已经较为理想。对于许多缓冲溶液系统来说,浓度范围一般是 0.1 mol/L 到 1 mol/L,在这个范围内,缓冲容量比较高且相对稳定。

$ c_t  = [#ca("CH3COO^-")] + [#ca("CH3COOH")] = 0.5 "mol·L"^(-1) $

$ [#ca("CH3COO^-")] = 6.918 times [#ca("CH3COOH")] $

$ 6.918 times [#ca("CH3COOH")] + [#ca("CH3COOH")] = 0.5 "mol·L"^(-1) $

$ 7.918 times [#ca("CH3COOH")] = 0.5 "mol·L"^(-1) $

$ [#ca("CH3COOH")] = 0.5 / 7.918 approx 0.0631 "mol·L"^(-1) $

$ [#ca("CH3COO^-")] = 0.5 - 0.0631 = 0.4369 "mol·L"^(-1) $

总体积为500 mL:

$ n_(#ca("CH3COOH")) = 0.0631 "mol·L"^(-1) times 0.5 "L" = 0.03155 "mol" $

$ n_(#ca("CH3COO^-")) = 0.4369 "mol·L"^(-1) times 0.5 "L" = 0.21845 "mol" $

醋酸钠三水合物(#ca("CH3COONa·3H2O"))的摩尔质量:
$ M = 136.09 "g·mol"^(-1) $

则醋酸钠三水合物的质量计算如下,

$ m_(#ca("CH3COONa·3H2O")) = 0.21845 "mol" times 136.09 "g·mol"^(-1) approx 29.73 ± 0.01 "g" $

无水乙酸密度约为1.049 g·cm⁻³,摩尔质量为60.05 g·mol⁻¹,则无水冰醋酸的体积计算如下,

$ n_(#ca("CH3COOH")) = 0.03155 "mol" $

$ m_(#ca("CH3COOH")) = 0.03155 "mol" times 60.05 "g·mol"^(-1) approx 1.895 "g" $

$ V_(#ca("CH3COOH")) = (1.895 "g")/(1.049 "g·cm"^(-3)) approx 1.81 "cm"^3 approx 1.81 ± 0.01 "mL" $

== 求解结果
+ 29.73 g醋酸钠三水合物
+ 1.81 mL无水冰醋酸

== 配置步骤
+ 称取29.73 g醋酸钠三水合物,溶于约400 mL蒸馏水中。
+ 小心量取1.81 mL无水冰醋酸,缓慢加入上述溶液中,搅拌均匀。
+ 用蒸馏水定容至500 mL。
+ 用校准过的pH计测量溶液pH值,如需要可微调pH至5.6。

== 注意事项

+ 此配方提供了较高的缓冲容量,适用于需要强缓冲能力的实验。
+ 确保所有组分完全溶解。
+ 配制过程中应在通风橱中进行,避免吸入过多醋酸蒸气。
+ 储存时注意密封,避免吸收空气中的#ca("CO2")影响pH值。



// -------------------------------------------------------



#bibliography(
  "./references.bib",
  title: "文献引用",
  style: "ieee"
)



// -------------------------------------------------------



// 附录
// #show: appendix

// = 附录

// == 子标题

// 附录内容