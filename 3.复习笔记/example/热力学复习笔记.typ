#import "../lib.typ": *

#let (
  // 布局函数
  twoside, doc,  mainmatter,  appendix, preface,
  // 页面函数
  fonts-display-page, cover, outline-page, 
) = documentclass(
  twoside: false,  // 双面模式，会加入空白页，便于打印

  info: (
    title: ("热力学复习笔记"),
    author: "刘抗非",
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
#outline-page()

// 字体显示测试页
// #fonts-display-page()

// 正文部分
#show: mainmatter

// 文稿设置
#show: doc

#cover()// 封面页

// 前言部分
#show: preface

#outline-page()// 目录

// 正文部分
#show: mainmatter

= 绪论

说明，该部分只是引出相关的内容，并不考试，所以该章节略过。

= 流体的PVT关系和状态方程

+ 维利方程

$Z = 1 + (B P)/(R T)$