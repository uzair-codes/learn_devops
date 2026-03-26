# Git & GitHub Documentation

## 1. Overview

### Version Control Systems (VCS)

Version Control Systems (VCS) manage changes to source code over time. They allow multiple developers to collaborate on a project without conflicts.

* **Centralized VCS**: A single central server stores all files and version history.
  Examples: SVN, CVS
* **Distributed VCS**: Every developer has a full copy of the repository, including history.
  Example: Git

### Git Hosting Platforms

* **GitHub**: Web platform for hosting Git repositories. Supports collaboration and versioning.
* **GitLab**: Similar to GitHub, with additional features like CI/CD pipelines, issue tracking, and project management tools.

---

## 2. Git File Lifecycle

Git tracks files through different states:

| State                  | Description                             | Example                             |
| ---------------------- | --------------------------------------- | ----------------------------------- |
| **Untracked**          | Newly added files not tracked by Git    | `app.js`                            |
| **Tracked (Modified)** | Files already tracked but changed       | `app.js` updated                    |
| **Staged**             | Files ready to be committed             | `git add app.js`                    |
| **Committed**          | Changes saved in the repository history | `git commit -m "Add login feature"` |

---

## 3. Git Workflow (Stages)

| Stage             | Git Command           | Description                     |
| ----------------- | --------------------- | ------------------------------- |
| Working Directory | `git init`            | Initialize a new Git repository |
| Staging Area      | `git add <file>`      | Add changes to staging area     |
| Local Repository  | `git commit -m "msg"` | Commit changes locally          |
| Remote Repository | `git push`            | Push changes to remote repo     |

---

## 4. Pull Requests (PR)

A Pull Request is a request to merge changes from one branch to another (usually from a feature branch to main or develop).

**Why use PRs:**

* Review code before merging
* Collaborate and discuss changes

**Example Workflow:**

1. Developer pushes code to `feature/login`.
2. Open a PR to merge into `develop`.
3. Teammates review and approve.
4. Code is merged after passing tests.

---

## 5. Issues

GitHub Issues track bugs, tasks, or feature requests.

**Example Workflow:**

1. Create an issue: `Add Login Authentication`
2. Assign it to a developer
3. Developer creates branch `feature/login-auth`
4. Complete work and reference the issue in a PR
5. Once merged, the issue closes automatically

---

## 6. Webhooks

Webhooks allow GitHub to send real-time data to another system when an event occurs.

**Example:**

* When a developer pushes code, the webhook triggers Jenkins to start a CI/CD pipeline.

---

## 7. Cloning & Forking

* **Clone:** Download a repository locally.
  `git clone <repo_url>`
* **Fork:** Create an independent copy of a repository on GitHub.

---

## 8. Common Git Commands

### Configuration

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --list       # List all configuration settings
```

### Basic Workflow

```bash
git init
git add <file>
git commit -m "Message"
git status
git log <branch_name>
git log --oneline <branch_name>
git diff
git push -u origin main
git pull origin main      # Download and merge
git fetch                    # Download but don't merge
```

### Cloning

```bash
# HTTPS (requires username & GitHub PAT for every push/pull)
git clone https_url

# SSH (one-time setup)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
eval "$(ssh-agent -s)"  # Start SSH agent
ssh-add path/to/id_rsa  # Add Private Key to it
# Add public key to GitHub (Settings → SSH and GPG Keys)
ssh -T git@github.com
git clone ssh_url
```

### Remote Repositories

```bash
git remote add origin <url>
git remote -v
```

### Undo Changes

```bash
git reset --soft HEAD~1   # Undo last commit, keep changes staged
git reset --hard HEAD~1   # Undo last commit, discard changes
git reset --hard <commit_id> # Go back to a specific commit
git rebase -i HEAD~n      # Combine multiple commits
```

### Tags

```bash
git tag v1.0
```

### Recovering Mistakes

#### Accidentally commit changes to Wrong branch

```bash
git stash           # Save changes
git checkout correct-branch
git stash pop       # Apply saved work
```

#### Accidentally deleted branch

```bash
git reflog          # Find commit hash
git checkout -b <branch_name> <commit_hash>
```

#### Accidentally deleted a folder

##### Find Folder Name (if unsure)

Run:

```bash
git ls-tree -r <commit_id> --name-only
```

This shows all files in that commit so you can confirm the exact folder name.

##### Method 1 (Best & Simple): Restore Folder from Specific Commit

✔ What this does:

* Brings back the folder from that commit
* Adds it to your current working directory
* Does NOT change your current branch or commits

```bash
git checkout <commit_id> -- <folder-name> 
```

##### Method 2: Restore Everything from That Commit

```bash
git checkout <commit_id> -- .
```

##### Method 3: If you just deleted it (before commit)

If you haven’t committed the deletion yet:

```bash
git restore <folder-name>
```

---

### Stop Tracking (without deleting it locally)

```bash
git rm -r --cached <file or folder name>
```

✔ What this does:

* Removes `<file or folder>` from Git tracking
* Keeps the folder on your local system ✅

---

## 9. Git Branches

A **branch** is an independent line of development.

### Branching Strategies

* **Git Flow:** Structured model with `main`, `develop`, `feature`, `release`, `hotfix` branches
* **Trunk-Based Development:** Developers work on a single main branch (trunk)

### Branch Commands

```bash
git branch                    # List all branches
git branch <branch_name>      # Create a branch
git checkout -b <branch_name> # Create and switch
git checkout <branch_name>    # Switch branch
git branch --show-current     # Show current branch
git branch -m <old> <new>     # Rename branch
git branch -d <branch_name>   # Delete local branch safely
git branch -D <branch_name>   # Force delete local branch
git push origin --delete <branch_name> # Delete remote branch
```

### Merging

```bash
git cherry-pick <commit_id>   # Apply specific commit from any branch
git merge <branch_name>       # Merge another branch, keep history
git rebase <target_branch>    # Reapply commits on top of target branch (linear history)
```
