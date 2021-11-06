# import vim
import json
import os
from IPython import embed
import re

class jsonwalk:
    def __init__(self,path):
        self.path=path
        self.baseType = {\
            "NoneType":self.basedo,\
            "int":self.basedo,\
            "dict":self.walkdo,\
            "str":self.basedo,\
            "list":self.walkdo,\
            "emptyDict":self.basedo,\
            "emptyList":self.basedo,\
            "float":self.basedo,\
            "bool":self.basedo\
            }
        self.lists=[]
        self.result={}
    def open (self):
        with open(self.path) as f:
            self.result = json.load(f)
     
    def whichType(self,item):     #{{{1
        typestr=str(type(item))
        pattern=re.compile("(bool|NoneType|int|str|dict|list|function|float)")
        wtype=re.search(pattern,typestr).group()
        if wtype == "list":
            if len(item)==0:
                return "emptyDict"
        if wtype == "dict":
            if len(item.keys())==0:
                return "emptyList"
        return wtype        #1}}}

    def cat(self,origin,key):        #{{{1
        return origin+"['"+key+"']"

    def catList(self,origin,index):
        return  origin+"["+index+"]"

    def python2javascript(self,path):
        pattern=re.compile("\['")
        pattern1=re.compile("'\]")
        path=re.sub(pattern,".",path)
        path=re.sub(pattern1,"",path)
        return path             #1}}}

    def walk(self,path):
        result = self.result
        result = eval(path)
        wtype = self.whichType(result)
        func=self.baseType[wtype]
        if func == self.basedo:
            self.lists.append(func(path))
        else:
            self.lists.append(func(path,wtype))
        return self.lists


    def basedo(self,path):
        return path

    def walkdo(self,path,wtype):
        result = self.result
        result = eval(path)
        if wtype == "list":
            for index in range(len(result)):
                self.walk(self.catList(path,str(index)))
        else:
            keys=result.keys()
            for key in keys:
                self.walk(self.cat(path,key))
        return path

