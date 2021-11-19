#!/usr/bin/python
import json
import os

def link(linker,linkee):
    command =  \
           " [[ -L {linker} ]] && (rm {linker} && ln -s {linkee} {linker}) \
           || ln -s {linkee} {linker} " \
           .format(linker = linker,linkee = linkee)
    os.system(command)

configFile = os.environ['HOME']+"/dotfile/install.json"
with open(configFile) as f:
    result = json.load(f)
    linkfiles = result['linkfiles']
    for linkfile in linkfiles:
        linker = linkfile['linker']
        linkee = linkfile['linkee']
        link(linker,linkee)



