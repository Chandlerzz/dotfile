import json
import pandas as pd
import re
from IPython import embed
chinese_word = re.compile(u'[\u4e00-\u9fa5]+')
fieldtyped = {1:"文本",2:"日期",3:"浏览按钮",6:"附件上传",5:"选择框-下拉框",162:"自定义多选","1":"文本","2":"日期","3":"浏览按钮","6":"附件上传","5":"选择框-下拉框","162":"自定义多选"}
with open("source2.json") as f:
    result = json.load(f)
    filtered = [[i["fieldName"],i["fieldlabelspan"],fieldtyped[i["fieldhtmltype"]],i["typespan"]] for i in result]
for i in filtered:
    i[1] = chinese_word.findall(i[1])[0]
df = pd.DataFrame(filtered,columns=["字段名称","显示名称","UI组件","字段类型"])
df.to_excel("/mnt/c/Users/xuzz/Desktop/output2.xlsx")
