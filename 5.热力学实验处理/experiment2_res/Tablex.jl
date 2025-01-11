using CSV
using DataFrames
using Printf

function generate_typst_code(csv_file::String, rows_per_chunk::Int, headers::Vector{String})
  # 读取 CSV 文件
  df = CSV.read(csv_file, DataFrame, missingstring=["", "NA", "null"])

  # 格式化数据
  function format_data(df)
    formatted = "(\n"
    for row in eachrow(df)
      formatted *= "  (" * join([
                       if ismissing(val)
                         "none"
                       elseif typeof(val) <: AbstractFloat
                         @sprintf("%.4f", val)
                       elseif typeof(val) <: Bool
                         string(val)
                       else
                         string(val)
                       end
                       for val in row
                     ], ", ") * "),\n"
    end
    return rstrip(formatted, [',', ' ', '\n']) * "\n)"
  end

  # 生成 Typst 代码
  typst_code = """
  #let data = $(format_data(df))

  #let table-headers = (
    $(join(["[" * h * "]" for h in headers], ", "))
  )

  #let table-part(part-data, is-last, is-first) = {
    table(
      columns: $(length(headers)),
      inset: 5pt,
      align: center + horizon,
      stroke: none,
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
        table.cell(colspan: $(length(headers)), align: center)[续下页]
      }
    )
  }

  #let chunks = data.chunks($(rows_per_chunk))
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
  """

  return typst_code
end

# 使用示例
csv_file = "combined_result.csv"  # 替换为您的 CSV 文件路径
rows_per_chunk = 35  # 每个表格的行数
headers = ["温度 (°C)", "绝对压力 (MPa)", "高度 (mm)", "比容 (m³/kg)", "标记"]  # 表头

typst_code = generate_typst_code(csv_file, rows_per_chunk, headers)

# 将输出保存到文件中
open("Tablex.typ", "w") do file
  write(file, typst_code)
end

println("Typst 代码已生成并保存到 Tablex.typ 文件中。")
