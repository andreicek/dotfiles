#!/usr/bin/env python

from sys import argv
from github import Github
from prompt_toolkit.shortcuts import checkboxlist_dialog

g = Github(argv[1])
user = g.get_user("andreicek")

all_repos = []
for repo in user.get_repos():
    all_repos.append((repo.name, repo.name))

results_array = checkboxlist_dialog(
    title="Clean up your GitHub repos",
    text="What repos would you like to delete",
    values=all_repos
).run()

if results_array != None:
  for repo in results_array:
    repo = user.get_repo(repo)
    repo.delete()

