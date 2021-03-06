#!/usr/bin/python
import json
import os
import subprocess

def link(linker,linkee):

    command =  \
           "[[ -L {linker} ]] && (rm {linker} && ln -s {linkee} {linker}) \
           || ln -s {linkee} {linker}  \
           "\
           .format(linker = linker,linkee = linkee)
    subprocess.Popen(command, shell=True, executable = "bash")

configFile = os.environ['HOME']+"/dotfile/install/install.json"
with open(configFile) as f:
    result = json.load(f)
    linkfiles = result['linkfiles']
    for linkfile in linkfiles:
        linker = linkfile['linker']
        linkee = linkfile['linkee']
        link(linker,linkee)



