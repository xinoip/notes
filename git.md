# Git

## Commit Conventions

I keep the prefix 3 characters long and simple to read:

```txt
new: Add feature.
fix: Fix bug.
ref: Refactor code.
doc: Update documentation.
ops: Configure CI/CD.
```

## Project Local Ignore List

If you want to ignore some files in Git project but don't want to commit ignore list, utilize `.git/info/exclude`
file. It's just like `.gitignore` file but just for local user.

## Editing Multiple Commits with Interactive Rebase

```sh
# Start interactive rebase from 1 commit after this commit.
git rebase -i <commit_hash>

# Editor will open up. Change `pick` to `edit` for commits you want to edit.

# Do something with commit or git state in general.
git commit --amend --no-gpg-sign --no-edit

# Continue to next one. If it's the last one, rebase completes.
git rebase --continue
```

## Amend Commit

Amending a commit overwrites and changes the commit information in history.

```sh
# Remove signature.
git commit --amend --no-gpg-sign --no-edit

# Change author.
git commit --amend --author="author_name <email>" --no-edit
```
