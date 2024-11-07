// 文稿设置，可以进行一些像页面边距这类的全局设置
#import "@preview/cuti:0.2.1": show-cn-fakebold


#let doc(
  // documentclass 传入参数
  info: (:),
  // 其他参数
  fallback: false,  // 字体缺失时使用 fallback，不显示豆腐块
  lang: "zh",
  margin: ((x:40pt,y:40pt)),
  it,
) = {
  // 1.  默认参数
  info = (
    title: "基于Typst的笔记模版",
    author: "张三",
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }
  // 3.  PDF 元信息
  set document(
    title: (("",)+ info.title).sum(),
    author: info.author,
  )
  // 4.  基本的样式设置
  show: show-cn-fakebold // 伪加粗

  set page(margin: margin)
  set text(fallback: fallback, lang: lang)

  it
}