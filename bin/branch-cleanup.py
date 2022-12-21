#!/usr/bin/env python

import subprocess
from prompt_toolkit.shortcuts import checkboxlist_dialog

cmd = 'git for-each-ref refs/heads --format="%(refname)"'
status, output = subprocess.getstatusoutput(cmd)

branches = []
if status == 0:
  for branch in output.split('\n'):
    branch = branch.replace("refs/heads/", "")
    branches.append((branch, branch))

results_array = checkboxlist_dialog(
  title="Branch cleanup",
  text="What would you like to remove?",
  values=branches
).run()

if results_array != None:
  for branch in results_array:
    cmd = f"git branch -D {branch}"
    subprocess.getstatusoutput(cmd)
