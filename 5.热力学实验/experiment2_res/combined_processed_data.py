import pandas as pd
import os

# 创建一个空的DataFrame用于存储合并的数据
combined_data = pd.DataFrame()

file_directory = '../experiment2_res/'

# 打印当前工作目录，确保路径正确
print(f"当前工作目录：{os.getcwd()}")

# 使用for循环遍历1到10的文件名
for i in range(1, 11):
    file_path = f'{file_directory}processed_data_group_{i}.csv'
    try:
        # 读取每个CSV文件并追加到combined_data中
        data = pd.read_csv(file_path)
        combined_data = pd.concat([combined_data, data], ignore_index=True)
    except FileNotFoundError:
        print(f"文件 {file_path} 未找到，跳过该文件。")

# 将合并后的数据写入一个新的CSV文件
combined_data.to_csv('combined_processed_data.csv', index=False)
