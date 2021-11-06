import json
import base64
import pandas as pd
with open("json2excel/source1.json") as f:
    result = json.load(f)
    filtered = [[i["label"],i["widget"]['widgetName'],i["widget"]['type'],i["widget"]] for i in result]
    print(filtered) 
    for i in filtered:
        if "alias" in i[3].keys():
            i[3] = i[3]['alias']
        else:
            i[3] = ""
df = pd.DataFrame(filtered,columns=["字段名称","字段ID","字段类型","字段别名"])
df.to_excel("/mnt/c/Users/xuzz/Desktop/output1.xlsx")
