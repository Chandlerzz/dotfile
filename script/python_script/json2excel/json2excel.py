import json
import base64
import pandas as pd
htmltyped = {"":"","1":"单行文本框","3":"浏览按钮","5":"选择框"}
fieldtyped = {1:"文本",2:"日期",162:"自定义多选"}
with open("json2excel/source.json") as f:
    result = json.load(f)
    filtered = [[i["id"],i["fieldname"],i["fieldlabelname"],htmltyped[i["htmltype"]],i["fieldtype"]] for i in result]
for i in filtered:
    if i[2].startswith("base64_"):
        tmp = i[2].replace("base64_","")
        tmp = base64.b64decode(tmp)
        tmp = tmp.decode()
        i[2] = tmp
    if type(i[4]) == type(1):
        i[4] = fieldtyped[i[4]]
df = pd.DataFrame(filtered,columns=["字段ID","字段名称","显示名称","UI组件","字段类型"])
df.to_excel("/mnt/c/Users/xuzz/Desktop/output.xlsx")
