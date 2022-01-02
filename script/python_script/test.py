import pandas as pd
import pymysql
from IPython import embed
pf1 = pd.read_excel("/mnt/c/Users/xuzz/Desktop/部门明细.xlsx")
list1 = pf1['部门全称'].tolist()
set1 = set(list1)
list1 = list(set1)
tree = {'companies':[]}
# 第一层
for li in list1:
    el = li.split("/")
    companies = tree['companies']
    item ={}
    for company in companies:
        if company['name'] == el[0]:
            item=company
    if item == {}:
        item['name'] = el[0]
        item['departments'] = []
        tree['companies'].append(item)

# 第二层
for li in list1:
    el = li.split("/")
    companies = tree['companies']
    ellen = len(el)
    for company in companies:
        if company['name'] == el[0]:
            departments = company['departments']
            department = {}
            if ellen >= 2:
                for d in departments:
                    if d['name'] == el[1]:
                        department = d
                if department == {}:
                    department['name'] = el[1]
                    department['subdepartments'] = []
                    company['departments'].append(department)

        
# 第三层
for li in list1:
    el = li.split("/")
    companies = tree['companies']
    ellen = len(el) 
    for company in companies:
        if company['name'] == el[0]:
            departments = company['departments']
            if ellen >= 3:
                for department in departments:
                    subdepartments = department['subdepartments']
                    if department['name'] == el[1]:
                        if company['name'] == el[0]:
                            if el not in subdepartments:
                                print(el[2])
                                department['subdepartments'].append({'name':el[2]})
print(tree)
#companytable name
companyTableName = "company"
departmentTableName = "department"

conn = pymysql.connect(host="10.10.9.24",port=13506,user="root",password="Risen*1107",database="university")
cursor = conn.cursor()
#insert company
for company in tree['companies']:
    companysql = "insert into "+companyTableName+" (name,status,abbr) values (\"" + company['name']+"\",1,\"R-,RL-,RH-,RS-,RC-,RT-,RG-,RD-,RZ-,RN-,RW-,RJ-,RY-\");"
    cursor.execute(companysql)
conn.commit()
#insert department
companysql = "select * from "+ companyTableName +" where deletedAt is null;"
cursor.execute(companysql)
data = cursor.fetchall()
data = list(data)
data = [[i[0],i[1]]for i in data]
for company in tree['companies']:
    departments = company['departments']
    companyName = company['name']
    companyData = [item[0] for item in data if item[1]==companyName]
    companyId = str(companyData[0])
    for department in departments:
        departmentsql = "insert into "+departmentTableName+" (name,companyId,parentId) values (\"" + department['name']+"\","+companyId+",0);"
        cursor.execute(departmentsql)
conn.commit()

#insert subdepartment
for company in tree['companies']:
    departments = company['departments']
    companyName = company['name']
    companyData = [item[0] for item in data if item[1]==companyName]
    companyId = str(companyData[0])
    for department in departments:
        subdepartments = department['subdepartments']
        departmentName = department['name']
        departmentquerysql = "select * from "+departmentTableName+" where companyId="+companyId+" and deletedAt is null;"
        cursor.execute(departmentquerysql)
        departmentData = cursor.fetchall()
        departmentData = list(departmentData)
        departmentData = [[i[0],i[1]]for i in departmentData]
        departmentData = [item[0] for item in departmentData if item[1]==departmentName]
        departmentId = str(departmentData[0])
        for subdepartment in subdepartments:
            subdepartmentsql = "insert into "+departmentTableName+" (name,companyId,parentId) values (\"" + subdepartment['name']+"\","+companyId+","+departmentId+");"
            cursor.execute(subdepartmentsql)
conn.commit()
