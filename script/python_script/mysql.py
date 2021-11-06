import pymysql
import json
import os
import re

class mysql:
    def __init__(self):
        self.conn = ""
        self.cursor=""
        self.tableNames=""
        self.completion={}

    def connect(self,nickName,dbName):
        configFile = os.environ['HOME']+"/dotfile/mysql_config.json"
        with open(configFile) as f:
            result = json.load(f)
            accounts = result["accounts"]
        nickName = [ account for account in accounts if account["nickName"] == nickName ][0]
        host = nickName ['host']
        user = nickName ['name']
        password = nickName ['passWord']
        database = nickName ['database'][dbName]
        port = int(nickName ['port'])
        conn = pymysql.Connect(
                host=host, 
                user=user, 
                password = password,
                port = port,
                database=database, 
                charset="utf8")
        self.conn = conn

    def getcursor(self,nickName,dbName):
        self.connect(nickName,dbName)
        self.cursor = self.conn.cursor()
        self.gettable()
        self.getTableScheme()

    def gettable(self):
        self.cursor.execute("show tables;")
        self.tableNames=self.cursor.fetchall()
        tableNames = str(self.tableNames)
        tableNames = re.findall("[A-Za-z_]+",str(tableNames))
        self.tableNames = tableNames

    def getTableScheme(self):
        tableNames = self.tableNames
        for tableName in tableNames:
            self.cursor.execute("show create table "+ tableName)
            one=self.cursor.fetchone()
            exec("self."+tableName+" =" + "one[1]")
            tableScheme=eval("self."+tableName)
            tableSchemePartition = tableScheme.partition("\n")
            partition = tableSchemePartition[2]
            # search fields
            self.completion[tableName]=list(set(re.findall("(?<=`)[^ `]*(?=`)",partition)))





