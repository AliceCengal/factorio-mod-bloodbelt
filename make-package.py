#! /usr/bin/python3

# small helper script for bundling up factorio mods redistributable
# under BSD3 or MIT terms as desired

import json
import subprocess

with open("info.json") as info_file:
    info = json.load(info_file)

with subprocess.Popen(['git', 'describe', '--dirty', '--tags'],
                      universal_newlines=True,
                      stdout=subprocess.PIPE) as git:
    git_version = git.stdout.read().rstrip()

if git_version != info['version']:
    if '-dirty' in git_version:
        print ("git reported version {} suggests "
               "the working tree is dirty; add, commit, tag, and retry?"
               .format(git_version))
    else:
        print ("git reported version {} does not match "
               "info.json version {}, retag?"
               .format(git_version,info['version']))
    exit(1)

name = "{}_{}".format(info['name'], info['version'])
subprocess.run (['git', 'archive',
                 '--prefix', "{}/".format(name),
                 '--output', "{}.zip".format(name),
                 info['version']])
