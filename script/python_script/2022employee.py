import pandas as pd
import os
import pymysql
from IPython import embed
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
pf1 = pd.read_excel("/mnt/c/Users/xuzz/Desktop/人事基础资料.xlsx",usecols=['公司全称','一级部门名称','二级部门名称','姓名','工号','手机号码'])
pf1 = pf1.fillna(value="")
dongbaoData = pf1.values.tolist()
# 0 公司名称 1 部门 2工号 3 姓名 4 手机号 
dongbaoData = [ [data[0],data[1]+data[2],data[3],data[4],data[5]] for data in dongbaoData ]
telData = [dongbao[4]for dongbao in dongbaoData]

####################################################################
# test
# companyTableName = "company"
# departmentTableName = "department"
# host = "10.10.9.24"
# port = 13506
# user = "root"
# password ="Risen*1107"
# database = "local_university"

#prod
companyTableName = "company"
departmentTableName = "department"
host = "120.55.53.221"
port = 13506
user = "root"
password ="Risen*1107"
database = "university"

#xuxiyao
# companyTableName = "company"
# departmentTableName = "department"
# host = "xuxiyao.com"
# port = 3306
# user = "root"
# password ="root"
# database = "university"

conn = pymysql.connect(host=host,port=port,user=user,password=password,database=database)
cursor = conn.cursor()


department_sql = """
WITH RECURSIVE department_paths AS
  ( SELECT 
  id,
  name,
  description,
  companyId,
  parentId,
  deletedAt,
  name names,
  1 lvl
   FROM department 
   WHERE parentId = 0 and deletedAt is null
     UNION ALL
     SELECT
      e.id,
      e.name,
      e.description,
      e.companyId,
      e.parentId,
      e.deletedAt,
      ep.name names,
      lvl+1
     FROM department  e 
     INNER JOIN department_paths ep ON ep.id = e.parentId )
SELECT 
  dep.id,
  company.name,
  dep.names,
  dep.name,
  /* description, */
  dep.companyId,
  dep.parentId
 /* dep.lvl, */
FROM department_paths dep
LEFT JOIN company on dep.companyId = company.id
where dep.deletedAt is null 
ORDER BY dep.lvl;
"""
# 0 id 1 公司ID 2 部门ID 3 电话 4 姓名 5工号
employee_sql = """
select 
id,
companyId,
departmentId,
tel,
name,
no
 from employee where deletedAt is null;
"""

cursor.execute(department_sql)
depData = cursor.fetchall()
depData = [list(dep) for dep in depData]
for dep in depData:
    if dep[5] != 0:
        dep[2] = dep[2] + dep[3]
cursor.execute(employee_sql)
empData = cursor.fetchall()
# embed()

count = 0
for employee in empData:
    for index in range(len(telData)):
        dongbaoEmployee = dongbaoData[index]
        company = dongbaoEmployee[0]
        department = dongbaoEmployee[1]
        departmentTumple = [com for com in depData if com[1] == company]
        # if employee[3] not in telData:
        #     name = employee[4]
        #     no = employee[5]
        #     if no is None:
        #         no = "11111111111111111111111111111111111"
        #     nameno = name + no
        #     dongname = dongbaoEmployee[3]
        #     dongbaono = dongbaoEmployee[2]
        #     dongbaono = dongbaono.split("-")
        #     if len(dongbaono) >= 2:
        #         dongbaono = dongbaono[1]
        #     else:
        #         dongbaono = "1111111111111111111111111111111111"
        #     dongnameno = dongname + dongbaono
        #     if nameno == dongnameno:
        #         updateemployee_sql = "update employee set companyId = {0} , departmentId = {1} where id = {2};".format(departmentTumple[0][4],departmentTumple[0][0],employee[0])
        #         print("工号插入 {0}".format(updateemployee_sql))
        #         cursor.execute(updateemployee_sql)
        #         conn.commit()
        # else:
        if employee[3] == telData[index]:
            if len(departmentTumple) == 0:
                break
            departmentTumple = [dep for dep in departmentTumple if dep[2] == department]
            if len(departmentTumple) == 0:
                break
            print(departmentTumple)
            print(employee)
            updateemployee_sql = "update employee set companyId = {0} , departmentId = {1} where id = {2};".format(departmentTumple[0][4],departmentTumple[0][0],employee[0])
            print("手机号插入 {0}".format(updateemployee_sql))
            cursor.execute(updateemployee_sql)
            conn.commit()



