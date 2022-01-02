import pandas as pd
import pymysql
def nodewalk(mylist,limit,curr_depth,node):
    if limit == 0:
        return
    if len(mylist) ==0:
        return
    else:
        head, tail = mylist[0], mylist[1:]
        node = comsume(head, curr_depth, node)
        limit = limit - 1
        curr_depth = curr_depth + 1
    return nodewalk(tail,limit,curr_depth,node)

def comsume(element, curr_depth, node):
    accessed_node = node[nodetype[curr_depth]]
    elementNamesWithIndx = [[ accessed_node[indx]['name'], indx ] for indx in range(len(accessed_node)) ]
    elementNames = [node_element['name'] for node_element in accessed_node ]
    if  element in elementNames:
        for elementName in elementNamesWithIndx:
            if (elementName[0] == element):
                return accessed_node[elementName[1]]
            
    else:
        accessed_node.append({'name':element,nodetype[curr_depth+1]:[]})
        nodelen = len(accessed_node)
        return accessed_node[ nodelen - 1 ]
pf1 = pd.read_excel("/mnt/c/Users/xuzz/Desktop/部门明细.xlsx")
list1 = pf1['部门全称'].tolist()
nodetype = ['companies','departments','subdepartments','useless']
tree = {'companies':[]}

for file in list1:
    mylist = file.split("/")
    nodewalk(mylist,3,0,tree)

####################################################################
# test
companyTableName = "company"
departmentTableName = "department"
host = "10.10.9.24"
port = 13506
user = "root"
password ="Risen*1107"
database = "university"

#prod
# companyTableName = "company"
# departmentTableName = "department"
# host = "120.55.53.221"
# port = 13506
# user = "root"
# password ="Risen*1107"
# database = "university"

conn = pymysql.connect(host=host,port=port,user=user,password=password,database=database)
cursor = conn.cursor()

init_sql = """ 
update company set deletedAt = null where id = 1;
update company set deletedAt = null where id = 1;
update  company set abbr= "R-,RL-,RH-,RS-,RC-,RT-,RG-,RD-,RZ-,RN-,RW-,RJ-,RY-" where id = 1;
update department set companyId = 1 where id = 1;
update company set deletedAt = "2022-01-01" where id > 1 and deletedAt is null;
update department set deletedAt = "2022-01-01" where id > 1 and deletedAt is null;
update employee set departmentId = 1;
update employee set companyId = 1;
update department set name = "默认部门" where id = 1;
update department set description = "默认部门" where id = 1;
"""

#insert company
for company in tree['companies']:
    companysql = "insert into "+companyTableName+" (name,status,abbr,companyType) values (\"" + company['name']+"\",1,\"R-,RL-,RH-,RS-,RC-,RT-,RG-,RD-,RZ-,RN-,RW-,RJ-,RY-\",0);"
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
