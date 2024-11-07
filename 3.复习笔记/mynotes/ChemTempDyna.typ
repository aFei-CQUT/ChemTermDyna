#import "../lib.typ": *

#let (
  // 布局函数
  twoside, doc,  mainmatter,  appendix, preface,
  // 页面函数
  fonts-display-page, cover, outline-page, 
) = documentclass(
  twoside: false,  // 双面模式，会加入空白页，便于打印

  info: (
    title: ("化工热力学笔记"),
    author: "aFEI@CQUT",
    submit-date: datetime.today(),
    cover-image: "../example/images/cover.jpg", // 封面图片路径，注意是相对于pages/elgeant-cover.typ的路径
    numbering-style:"maths" // "maths"：数学或论文风格的标题编号 | "literature"：文学风格的标题编号
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

// 字体显示测试页
// #fonts-display-page()

// 正文部分
#show: mainmatter

= 绪论

= 流体的P-V-T关系

== 表达式、微分
$ V = V(P, T) $ 

$ arrow.b $ <->   

$ dif V = ((partial V)/(partial T))_p dif T + ((partial V)/(partial P))_T dif P $

$ beta = 1/V ((partial V)/(partial T))_p , kappa = - 1/V ((partial V)/(partial P))_T $

$ arrow.b $ <-> 

$ (dif V)/V = beta dif T - kappa dif P $

上面$dif T -> 0$ 或者$ dif P -> 0$时可积可简

== 研究对象

$1 m o l$ 物质有 $f(P,V,T) = 0$

$n m o l$ 物质有 $f(P,V,T,n) = 0$

理想气体:
+ $F_#text[i,j] -> 0$
+ $V_i -> 0$
+ $D(i , j) -> infinity$

== 维里方程

$ P V = a + b P + c P^3 + ... = a (1 + B'P + C' P^2 + ...) $

$P -> 0$时，上式 $P V = a$ 又因 $P V = R T$ 则有 $ a = R T$则有，

$ P V =  R T (1 + B'P + C' P^2 + ...) $

$ Z = (P V)/(R T) = 1 + B'P + C' P^2 + ... $

$ Z = (P V)/(R T) = 1 + B/V + C/P^2 + ... $



一定量的理想气体与真实气体由n个分子间作用力形成的偏差。

== 两项截断式
1mol研究对象

$ Z = (P V)/(R T) = 1 + B'P $
或者
$ Z = (P V)/(R T) = 1 + B/V $
又有 $P V = R T$，变形为$V = P/R T$，带入上式有

$ Z = (B P)/(R T) $