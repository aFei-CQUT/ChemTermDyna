using CSV
using DataFrames
using Logging

# 创建一个空的DataFrame用于存储合并的数据
combined_data = DataFrame()

file_directory = "../experiment2_res/"

# 打印当前工作目录，确保路径正确
println("当前工作目录：$(pwd())")

# 使用for循环遍历1到10的文件名
for i in 1:10
    file_path = joinpath(file_directory, "processed_data_group_$i.csv")
    try
        # 读取每个CSV文件并追加到combined_data中
        data = CSV.read(file_path, DataFrame)
        combined_data = vcat(combined_data, data)
    catch e
        if isa(e, SystemError)
            @warn "文件 $file_path 未找到，跳过该文件。"
        else
            rethrow(e)
        end
    end
end

# 将合并后的数据写入一个新的CSV文件
CSV.write("combined_processed_data.csv", combined_data)
