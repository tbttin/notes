# Getting Started

## About Version Control

### Local Version Control Systems

[RCS](https://www.gnu.org/software/rcs/) works by keeping patch sets
(that is, the differences between files) in a special format on disk; it
can then re-create what any file looked like at any point in time by
adding up all the patches.

### Centralized Version Control Systems

### Distributed Version Control Systems

## A Short History of Git

## What is Git?

### Snapshots, Not Differences

- These other systems think of the information they store as a set of
  files and the changes made to each file over time (this is commonly
  described as *delta-based* version control).

- Instead, Git thinks of its data more like a series of snapshots of a
  miniature filesystem.

### Nearly Every Operation Is Local

### Git Has Integrity

- Everything in Git is checksummed before it is stored and is then
  referred to by that checksum.

  The mechanism that Git uses for this checksumming is called a SHA-1
  hash.

- This is a 40-character string composed of hexadecimal characters (0--9
  and a--f) and calculated based on the contents of a file or directory
  structure in Git.

### Git Generally Only Adds Data

### The Three States

- Git has three main states that your files can reside in: *modified*,
  *staged*, and *committed*:

  + Modified (tracked) means that you have changed the file but have not
    committed it to your database yet.

  + Staged means that you have marked a new or newly modified file in
    its current version to go into your next commit snapshot.

  + Committed means that the data is safely stored in your local
    database.

  This leads us to the three main sections of a Git project: the
  *working tree*, the *staging area* (its technical name in Git parlance
  is the "index", but the phrase "staging area" works just as well),
  and the *Git directory*.

## The Command Line

- See also `gitcli(7)`

## Installing Git

### Installing on Linux

### Installing on macOS

### Installing on Windows

### Installing from Source

## First-Time Git Setup

You can view all of your settings and where they are coming from using:

```bash
$ git config --list --show-origin
```

### Your Editor

### Your default branch name

### Checking Your Settings

You can also check what Git thinks a specific key's value is by typing
`git config <key>`:

```bash
$ git config user.name
$ git config --show-origin rerere.autoUpdate
```

## Getting Help

If you ever need help while using Git, there are three equivalent ways
to get the comprehensive manual page (manpage) help for any of the Git
commands:

```bash
$ git help <verb>
$ git <verb> --help
$ man git-<verb>
```

## Summary

# Git Basics

## Getting a Git Repository

### Initializing a Repository in an Existing Directory

- `git init`

- `git-init(1)`

  + Templates (default `/usr/share/git-core/templates`).

  + Hooks.

- `gitrepository-layout(5)`

### Cloning an Existing Repository

- `git clone <url>`

- What are these protocols?

  + `https://`

  + `git://`

  + `user@server:path/to/repo.git` (the SSH transfer protocol)

## Recording Changes to the Repository

### Checking the Status of Your Files

- `git status`

### Tracking New Files

- `git add`

### Staging Modified Files

- `git add` is a *multipurpose* command --- you use it to begin tracking
  new files, to stage files, and to do other things like *marking*
  merge-conflicted files as resolved.

### Short Status

```bash
$ git status -s
 M README
MM Rakefile
A  lib/git.rb
M  lib/simplegit.rb
?? LICENSE.txt
```

New files that aren't tracked have a `??` next to them, *new* files that
have been added to the staging area have an `A`, modified files have an
`M` and so on.

There are two columns to the output --- the left-hand column indicates
the status of the staging area and the right-hand column indicates the
status of the working tree.

So for example in that output, the `README` file is modified in the
working directory but not yet staged, while the `lib/simplegit.rb` file
is modified and staged.

The `Rakefile` was modified, staged and then modified again, so there
are changes to it that are both staged and unstaged.

### Ignoring Files

- `gitignore(5)`

### Viewing Your Staged and Unstaged Changes

- `git diff`

1. To see what you've changed but *not* yet staged, type `git diff` with
   no other arguments.

   That command compares what is in your working directory with what is
   in your *staging area*.

   That's why if you've staged all of your changes, `git diff` will give
   you no output.

2. If you want to see what you've staged that will go into your *next
   commit*, you can use `git diff --staged`.

   This command compares your staged changes to your *last commit*.

3. See all the changes since the last commit, whether or not they have
   been staged for commit or not?

Summary:

```
             HEAD ______git diff______ Working
                  \       HEAD       /  tree
                   \                /
                    \              /
                     \            /
                  git diff    git diff
                  --staged   (haven't yet staged)
                        \      /
                         \    /
                          \  /
                           \/
                         Staging
                          area
```

### Committing Your Changes

- `git commit`

### Skipping the Staging Area

- `git commit --all` command makes Git automatically stage every file
  that is already tracked before doing the commit, letting you skip the
  `git add` part.

### Removing Files

- `git rm`

- Another useful thing you may want to do is to keep the file in your
  working tree but remove it from your staging area.

  ```bash
  $ git rm --cached README
  ```

- You can pass files, directories, and file-glob patterns to the `git
  rm` command:

  ```bash
  $ git rm log/\*.log
  ```

### Moving Files

- `git mv`

## Viewing the Commit History

- `git log`

Wanna know how to write a good commit? Read `log` manpage.

- `git log --patch -2`

- `git log --stat`

- `git log --pretty=oneline|format:`

  + The *author* is the person who originally wrote the work.

  + The *committer* is the person who last applied the work.

- `git log --graph`

### Limiting Log Output

- `git log --since --until`

- `git log --grep` # grep commit message

- `git log -S function_name`

## Undoing Things

### Unstaging a Staged File

- Use `git reset HEAD <file>...` to unstage.

### Unmodifying a Modified File

- `git checkout`

### Undoing things with git restore

#### Unstaging a Staged File with git restore

- `git restore --cached`

#### Unmodifying a Modified File with git restore

- `git restore`

## Working with Remotes

- `git remote`

### Showing Your Remotes

### Adding Remote Repositories

### Fetching and Pulling from Your Remotes

- `git fetch`

- `git pull`

- It's important to note that the `git fetch` command only downloads the
  data (new work) to your local repository --- it doesn't automatically
  merge it with any of your work or modify what you're currently working
  on.

### Pushing to Your Remotes

- `git push`

### Inspecting a Remote

- `git remote show [remote]`

### Renaming and Removing Remotes

- `git remote rename`

- `git remote remove` or `git remove rm`

## Tagging

### Listing Your Tags

- `git tag`

- `git tag --list 'v1.8.5*'`

### Creating Tags

- Git supports two types of tags: *lightweight* and *annotated*.

  + A lightweight tag is very much like a branch that doesn't change ---
    it's just a pointer to a specific commit?

  + Annotated tags, however, are stored as full objects in the Git
    database. They're checksummed; contain the tagger name, email, and
    date; have a tagging message; and can be signed and verified with
    GNU Privacy Guard (GPG).

- Determine if a tag is annotated: `git cat-file -t <tag>`

  + `commit` for lightweight, since there is no tag object, it points
    directly to the commit.

  + `tag` for annotated, since there is a tag object in that case.

### Annotated Tags

- `git tag -a <tag>`

- `git tag -m 'message' <tag>` # -a is implied

- `git show <tag>`

### Lightweight Tags

- `git tag <tag>`

- This is basically the commit checksum stored in a file --- no other
  information is kept.

- List all lightweight tags: `git show-ref --tags`

### Tagging Later

- `git tag -a <tag> <checksum>`

### Sharing Tags

- `git push <remote> <tag>`

  This process is just like sharing remote branches.

- `git push <remote> --tags` will push both lightweight and annotated
  tags.

- To push only annotated tags: `git push <remote> --follow-tags`

  There is currently no option to push only lightweight tags.

### Deleting Tags

- Local: `git tag -d <tag>`

- Remote: two common variations:

  + `git push <remote> :refs/tags/<tag>`

    The way to interpret the above is to read it as the null value
    before the colon is being pushed to the remote tag name, effectively
    deleting it.

  + `git push origin --delete <tag>`

### Checking out Tags

- `git checkout <tag>` # detached HEAD

  In "detached HEAD" your new commit won't belong to any branch and will
  be *unreachable*, except by the exact commit hash.

- `git checkout -b <branch> <tag>`

## Git Aliases

- `git config --global alias.unstage 'reset HEAD --'`

## Summary

# Git Branching

- In many VCS tools, this (create/delete a branch) is a somewhat
  expensive process, often requiring you to create a new copy of your
  source code directory, which can take a long time for large projects.

## Branches in a Nutshell

- Staging the files computes a checksum for each one, stores *that
  version* of the file in the Git repository (Git refers to them as
  *blobs*), and adds that checksum to the staging area.

- When you make a commit, Git stores a commit object that contains a
  *pointer* to the snapshot (root tree's hash) of the content you
  staged.

  Git checksums each subdirectory and stores them as a tree object in
  the Git repository. Git then creates a commit object that has the
  metadata and a pointer to the root project tree so it can re-create
  that snapshot when needed.

  This object also contains the author's name and email address, the
  message that you typed, and *pointers* to the commit or commits that
  directly came before this commit (its parent or parents): zero parents
  for the initial commit, one parent for a normal commit, and multiple
  parents for a commit that results from a merge of two or more
  branches.

  A commit and its tree:

  ```
                    /--> tree --> glob
                   /          \
                  /            \--> glob
  commit --> tree --> glob
                  \
                   \--> glob
  ```

- A branch in Git is simply a lightweight movable pointer to one of
  these commits.

### Creating a New Branch

- `git brach <newbranch>`

- `git log --oneline --decorate`

- What happens when you create a new branch? Well, doing so creates a
  new pointer for you to move around.

- How does Git know what branch you're currently on? It keeps a special
  pointer called `HEAD`.

  ```
                       HEAD
                        |
                        v
                      master
                        |
                        v
  98ca8 --> 87ac9 --> f30bc
                        ^
                        |
                      testing
  ```

### Switching Branches

- `git checkout <branch>`

  `git checkout master`

  That command did two things. It *moved* the HEAD pointer back to point
  to the `master` branch, and it *reverted* the files in your working
  directory back to the snapshot that `master` points to.

- `git log <branch>`

- `git log --all`

- `git log --oneline --decorate --graph --all`

- Because a branch in Git is actually a simple file that contains the 40
  character SHA-1 checksum of the commit it points to, branches are
  cheap to create and destroy.

  Creating a new branch is as quick and simple as writing 41 bytes to a
  file (40 characters and a newline).

- `git switch <branch>` # git version >2.23

  `git switch -` return to previous checked out branch.

- Creating a new branch and switching to it at the same time:

  + `git checkout -b <branch>`

  + `git switch -c <branch>`

## Basic Branching and Merging

### Basic Branching

- `git checkout <tobranch>`

  `git merge <thisbranch> <thatbranch>` merge `<thisbranch>` and
  `<thatbranch>` into the current branch.

   + `--autostash` be careful with non-trivial conflicts.

   + `--rerere-autoupdate`

  `git branch -d <branch>`

- Fast-forward example:

  ```
                master   hotfix
                  |        |
                  v        v
  C0 <--- C1 <--- C2 <--- C4
  ```

  ```bash
  git checkout master
  git merge hotfix
  ```

  To phrase that another way, when you try to merge one commit with a
  commit that can be reached by following the first commit's history,
  Git simplifies things by moving the pointer forward because there is
  no divergent work to merge together --- this is called a
  *fast-forward*.

### Basic Merging

- Diverged branches:

  ```
                         master
                           |
                           v
  C0 <--- C1 <--- C2 <--- C4
                  ^
                  |
                  `--- C3 <--- C5
                                ^
                                |
                              iss53
  ```

- In this case, Git does a simple *three-way merge*, using the two
  snapshots pointed to by the branch tips and the common ancestor of the
  two.

- Git creates a new snapshot that results from this three-way merge and
  automatically creates a new commit that points to it.

  This is referred to as a merge commit, and is special in that it has
  more than one parent.

### Basic Merge Conflicts

- `git-merge(1)`

  + How to resolve conflicts:

    `git merge --abort`

    `git log --merge --patch <path>`

    `git show :1:filename` show the common ancestor.

    `git show :2:filename` show the *HEAD*.

    `git show :3:filename` show the *MERGE_HEAD*.

  + Merge strategies?

  + Configurations:

   * `'merge.conflictstyle' = merge|diff3|zdiff3`

- After you've resolved each of these sections in each conflicted file
  (deleted conflict markers), run `git add` on each file to mark it as
  resolved.

  Staging the file marks it as resolved in Git.

- `git commit`

  `git merge --continue`

## Branch Management

- `git brach -v` to see last commit on each branch.

- `git brach --merged`

   Branches on this list without the `*` in front of them are generally
   fine to delete with `git branch -d`; you've already incorporated
   their work into another branch, so you're not going to lose anything.

- `git brach --no-merged`

  `git branch --no-merged <branch>`

- `git branch -D <branch>`

### Changing a branch name

#### Changing the master branch name

- Warning:

  Changing the name of a branch like master/main/mainline/default will
  break the integrations, services, helper utilities and build/release
  scripts that your repository uses. Before you do this, make sure you
  consult with your collaborators. Also, make sure you do a thorough
  search through your repo and update any references to the old branch
  name in your code and scripts.

- `git branch --move master main`

- `git push --set-upstream origin main`

  `git branch --all`

- Now you have a few more tasks in front of you to complete the
  transition:

  + Any projects that depend on this one will need to update their code
    and/or configuration.

  + Update any test-runner configuration files.

  + Adjust build and release scripts.

  + Redirect settings on your repo host for things like the repo's
    default branch, merge rules, and other things that match branch
    names.

  + Update references to the old branch in documentation.

  + Close or merge any pull requests that target the old branch.

- `git push origin --delete master`

## Branching Workflows

### Long-Running Branches

- The idea is that your branches are at various levels of stability;
  when they reach a more stable level, they're merged into the branch
  above them.

  + `master` stable, has been or will be released.

  + `develop` or `next` to work or test stability.

  + `proposed` or `pu` (proposed updates) more levels of stability.

- Again, having multiple long-running branches isn't necessary, but it's
  often helpful, especially when you're dealing with very large or
  complex projects.

### Topic Branches

- Topic branches (`hotfix`, `iss53`), however, are useful in projects of
  any size. A topic branch is a short-lived branch that you create and
  use for a single particular feature or related work.

## Remote Branches

- `origin/master`: remote's master branch

  `master`: local branch

  `master` vs. `origin/master` vs. `v2.3.7`?

    + `v2.3.7` do not move automatically

- `git remote`

- Remote references are references (pointers) in your remote
  repositories, including branches, tags, and so on.

  You can get a full list of remote references explicitly with `git
  ls-remote <remote>`, or `git remote show <remote>` for remote branches
  as well as more information.

- Remote-tracking branches are references to the state of remote
  branches. They're local references that you can't move; Git moves them
  for you whenever you do any network communication, to make sure they
  accurately represent the state of the remote repository.

  Think of them as bookmarks, to remind you where the branches in your
  remote repositories were the last time you connected to them.

### Pushing

- `git push <remote> <branch>`

  `git push origin serverfix` this is a bit of a shortcut.

  Git automatically expands the `serverfix` branchname out to
  `refs/heads/serverfix:refs/heads/serverfix`, which means, "Take my
  `serverfix` local branch and push it to update the remote's
  `serverfix` branch."

- `git push <remote> <localbranch>:<remotebranch>`

  `git push origin serverfix:serverfix` does the same thing --- it says,
  "Take my serverfix and make it the remote's serverfix."

- `git fetch orgin` to fetch new branches.

  It's *important* to note that when you do a fetch that brings down new
  remote-tracking branches, you don't automatically have local, editable
  copies of them.

  In other words, in this case, you don't have a new `serverfix` branch
  --- you have only an `origin/serverfix` pointer that you can't modify.

  To merge this work into your current working branch, you can run `git
  merge origin/serverfix`.

  If you want your own `serverfix` branch that you can work on, you can
  base it off your remote-tracking branch with `git checkout -b
  serverfix origin/serverfix`

  See also [Tracking Branches].

#### Don't type your password every time

- If you don't want to type it every single time you push, you can set
  up a "credential cache". The simplest is just to keep it in memory for
  *a few minutes*, which you can easily set up by running `git config
  --global credential.helper cache`.

### Tracking Branches

- `git checkout -b <branch> <remote>/<branch>`

  Shortcut: `git checkout --track <remote>/<branch>`

  Shortcut of shortcut: `git checkout <branch>` if the branch name
  you're trying to checkout (a) doesn't exist and (b) exactly matches a
  name on only one remote, Git will create a tracking branch for you.

- Checking out a local branch from a remote-tracking branch
  automatically creates what is called a "tracking branch" (and the
  branch it tracks is called an "upstream branch").

- If you already have a local branch and want to set it to a remote
  branch you just pulled down, or want to change the upstream branch
  you're tracking, you can use the `-u` or `--set-upstream-to` option to
  `git branch` to explicitly set it at any time.

  ```bash
  $ git branch -u origin/serverfix
  ```

- `git fetch --all; git branch -vv`

#### Upstream shorthand

When you have a tracking branch set up, you can reference its upstream
branch with the `@{upstream}` or `@{u}` shorthand. So if you're on the
`master` branch and it's tracking `origin/master`, you can say something
like `git merge @{u}` instead of `git merge origin/master` if you wish.

### Pulling

- `git fetch`

- `git pull`

### Deleting Remote Branches

- `git push origin --delete <branch>`

  Basically all this does is remove the pointer from the server. The Git
  server will generally keep the data there for a while until a garbage
  collection runs, so if it was accidentally deleted, it's often easy to
  recover.

  See also [Changing a branch name].

## Rebasing

### The Basic Rebase

- `git checkout experiment`

  `git rebase master`

  Rebase `experiment` branch onto the `master` branch.

  This operation works by going to the common ancestor of the two
  branches (the one you're on and the one you're rebasing onto), getting
  the *diff* introduced by each commit of the branch you're on, saving
  those diffs to temporary files, resetting the current branch to the
  same commit as the branch you are rebasing onto, and finally applying
  each change in turn.

- With the `rebase` command, you can take all the changes that were
  committed on one branch and replay them on a different branch.

- `git checkout master`

  `git merge experiment` fast-foward `master` branch.

### More Interesting Rebases

- You can take the changes on `client` that aren't on `server` (`C8` and
  `C9`) and replay them on your `master` branch by using the `--onto`
  option of `git rebase`:

  ```
                        master
                          |
                          v
  C1 <--- C2 <--- C5 <--- C6
          ^
          |
          `--- C3 <--- C4 <--- C10
               ^                ^
               |                |
               |              server
               |
               `--- C8 <--- C9
                            ^
                            |
                          client
  ```

- `git rebast --onto master server client`

  This basically says, "Take the `client` branch, figure out the
  patches since it diverged from the `server` branch, and replay
  these patches in the `client` branch as if it was based
  directly off the `master` branch instead."

  `git checkout master; git merge experiment`


- `git rebase master server` rebase the `server` branch onto the
  `master` branch without having to check it out.

### The Perils of Rebasing

Do not rebase commits that exist outside your repository and that people
may have based work on.

### Rebase When You Rebase

### Rebase vs. Merge

## Summary

# Git on the Server

## The Protocols

### Local Protocol

#### The Pros

#### The Cons

### The HTTP Protocols

#### Smart HTTP

#### Dumb HTTP

#### The Pros

#### The Cons

### The SSH Protocol

#### The Pros

#### The Cons

### The Git Protocol

#### The Pros

#### The Cons

## Getting Git on a Server

### Putting the Bare Repository on a Server

### Small Setups

#### SSH Access

## Generating Your SSH Public Key

## Setting Up the Server

## Git Daemon

## Smart HTTP

## GitWeb

## GitLab

### Installation

### Administration

#### Users

#### Groups

#### Projects

#### Hooks

### Basic Usage

### Working Together

## Third Party Hosted Options

## Summary

# Distributed Git

## Distributed Workflows

- `gitworkflows(7)`

### Centralized Workflow

### Integration-Manager Workflow

### Dictator and Lieutenants Workflow

### Patterns for Managing Source Code Branches

### Workflows Summary

## Contributing to a Project

### Commit Guidelines

### Private Small Team

### Private Managed Team

### Forked Public Project

### Public Project over Email

### Summary

## Maintaining a Project

### Working in Topic Branches

### Applying Patches from Email

#### Applying a Patch with apply

#### Applying a Patch with `am`

### Checking Out Remote Branches

### Determining What Is Introduced

### Integrating Contributed Work

#### Merging Workflows

#### Large-Merging Workflows

#### Rebasing and Cherry-Picking Workflows

#### Rerere

### Tagging Your Releases

### Generating a Build Number

### Preparing a Release

### The Shortlog

## Summary

# GitHub

## Account Setup and Configuration

### SSH Access

### Your Avatar

### Your Email Addresses

### Two Factor Authentication

## Contributing to a Project

### Forking Projects

### The GitHub Flow

#### Creating a Pull Request

#### Iterating on a Pull Request

## Not Only Forks

### Advanced Pull Requests

#### Pull Requests as Patches

#### Keeping up with Upstream

#### References

### GitHub Flavored Markdown

#### Task Lists

#### Code Snippets

#### Quoting

#### Emoji

#### Images

### Keep your GitHub public repository up-to-date

## Maintaining a Project

### Creating a New Repository

### Adding Collaborators

### Managing Pull Requests

#### Email Notifications

#### Collaborating on the Pull Request

#### Pull Request Refs

#### Pull Requests on Pull Requests

### Mentions and Notifications

#### The Notifications Page

##### Web Notifications

##### Email Notifications

### Special Files

### README

### CONTRIBUTING

### Project Administration

#### Changing the Default Branch

#### Transferring a Project

## Managing an organization

### Organization Basics

### Teams

### Audit Log

## Scripting GitHub

### Services and Hooks

#### Services

#### Hooks

### The GitHub API

### Basic Usage

### Commenting on an Issue

### Changing the Status of a Pull Request

### Octokit

## Summary

# Git Tools

## Revision Selection

### Single Revisions

### Short SHA-1

### Branch References

### RefLog Shortnames

### Ancestry References

### Commit Ranges

#### Double Dot

#### Multiple Points

#### Triple Dot

## Interactive Staging

### Staging and Unstaging Files

### Staging Patches

## Stashing and Cleaning

### Stashing Your Work

### Creative Stashing

### Creating a Branch from a Stash

### Cleaning your Working Directory

## Signing Your Work

### GPG Introduction

### Signing Tags

### Verifying Tags

### Signing Commits

### Everyone Must Sign

## Searching

### Git Grep

### Git Log Searching

#### Line Log Search

## Rewriting History

### Changing the Last Commit

### Changing Multiple Commit Messages

### Reordering Commits

### Squashing Commits

### Splitting a Commit

### Deleting a commit

### The Nuclear Option: filter-branch

#### Removing a File from Every Commit

#### Making a Subdirectory the New Root

#### Changing Email Addresses Globally

## Reset Demystified

### The Three Trees

#### The HEAD

#### The Index

#### The Working Directory

### The Workflow

### The Role of Reset

#### Step 1: Move HEAD

#### Step 2: Updating the Index (\--mixed)

#### Step 3: Updating the Working Directory (\--hard)

#### Recap

### Reset With a Path

### Squashing

### Check It Out

#### Without Paths

#### With Paths

### Summary

## Advanced Merging

### Merge Conflicts

#### Aborting a Merge

#### Ignoring Whitespace

#### Manual File Re-merging

#### Checking Out Conflicts

#### Merge Log

#### Combined Diff Format

### Undoing Merges

#### Fix the references

#### Reverse the commit

### Other Types of Merges

#### Our or Theirs Preference

#### Subtree Merging

## Rerere

## Debugging with Git

### File Annotation

### Binary Search

## Submodules

### Starting with Submodules

### Cloning a Project with Submodules

### Working on a Project with Submodules

#### Pulling in Upstream Changes from the Submodule Remote

#### Pulling Upstream Changes from the Project Remote

#### Working on a Submodule

#### Publishing Submodule Changes

#### Merging Submodule Changes

### Submodule Tips

#### Submodule Foreach

#### Useful Aliases

### Issues with Submodules

#### Switching branches

#### Switching from subdirectories to submodules

## Bundling

## Replace

## Credential Storage

### Under the Hood

### A Custom Credential Cache

## Summary

# Customizing Git

## Git Configuration

### Basic Client Configuration

### Colors in Git

#### `color.ui`

#### `color.*`

### External Merge and Diff Tools

### Formatting and Whitespace

#### `core.autocrlf`

#### `core.whitespace`

### Server Configuration

#### `receive.fsckObjects`

#### `receive.denyNonFastForwards`

#### `receive.denyDeletes`

## Git Attributes

### Binary Files

#### Identifying Binary Files

#### Diffing Binary Files

### Keyword Expansion

### Exporting Your Repository

#### `export-ignore`

#### `export-subst`

### Merge Strategies

## Git Hooks

### Installing a Hook

### Client-Side Hooks

#### Committing-Workflow Hooks

#### Email Workflow Hooks

#### Other Client Hooks

### Server-Side Hooks

#### `pre-receive`

#### `update`

#### `post-receive`

## An Example Git-Enforced Policy

### Server-Side Hook

#### Enforcing a Specific Commit-Message Format

#### Enforcing a User-Based ACL System

#### Testing It Out

### Client-Side Hooks

## Summary

# Git and Other Systems

## Git as a Client

### Git and Subversion

#### `git svn`

#### Setting Up

#### Getting Started

#### Committing Back to Subversion

#### Pulling in New Changes

#### Git Branching Issues

#### Subversion Branching

#### Creating a New SVN Branch

#### Switching Active Branches

#### Subversion Commands

##### SVN Style History

##### SVN Annotation

##### SVN Server Information

##### Ignoring What Subversion Ignores

#### Git-Svn Summary

### Git and Mercurial

#### git-remote-hg

#### Getting Started

#### Workflow

#### Branches and Bookmarks

#### Mercurial Summary

### Git and Bazaar

#### Create a Git repository from a Bazaar repository

#### Bazaar branches

#### Ignore what is ignored with .bzrignore

#### Fetch the changes of the remote repository

#### Push your work on the remote repository

#### Caveats

#### Summary

### Git and Perforce

#### Git Fusion

##### Setting Up

##### Fusion Configuration

##### Workflow

##### Git-Fusion Summary

#### Git-p4

##### Setting Up

##### Getting Started

##### Workflow

##### Branching

#### Git and Perforce Summary

## Migrating to Git

### Subversion

### Mercurial

### Bazaar

#### Getting the bzr-fastimport plugin

#### Project with a single branch

#### Case of a project with a main branch and a working branch

#### Synchronizing the staging area

#### Ignoring the files that were ignored with .bzrignore

#### Sending your repository to the server

### Perforce

#### Perforce Git Fusion

#### Git-p4

### A Custom Importer

## Summary

# Git Internals

## Plumbing and Porcelain

## Git Objects

### Tree Objects

### Commit Objects

### Object Storage

## Git References

### The HEAD

### Tags

### Remotes

## Packfiles

## The Refspec

### Pushing Refspecs

### Deleting References

## Transfer Protocols

### The Dumb Protocol

### The Smart Protocol

#### Uploading Data

##### SSH

##### HTTP(S)

#### Downloading Data

##### SSH

##### HTTP(S)

### Protocols Summary

## Maintenance and Data Recovery

### Maintenance

### Data Recovery

### Removing Objects

## Environment Variables

### Global Behavior

### Repository Locations

### Pathspecs

### Committing

### Networking

### Diffing and Merging

### Debugging

### Miscellaneous

## Summary

# Appendix A: Git in Other Environments

## Graphical Interfaces

### `gitk`

### GitHub for macOS and Windows

#### Installation

#### Recommended Workflow

#### Summary

### Other GUIs

## Git in Visual Studio

## Git in Visual Studio Code

## Git in IntelliJ / PyCharm / WebStorm / PhpStorm / RubyMine

## Git in Sublime Text

## Git in Bash

## Git in Zsh

## Git in PowerShell

### Installation

#### Prerequisites (Windows only)

#### PowerShell Gallery

#### Update PowerShell Prompt

#### From Source

## Summary

# Appendix B: Embedding Git in your Applications

## Command-line Git

## Libgit2

### Advanced Functionality

### Other Bindings

#### LibGit2Sharp

#### objective-git

#### pygit2

### Further Reading

## JGit

### Getting Set Up

### Plumbing

### Porcelain

### Further Reading

## go-git

### Advanced Functionality

### Further Reading

## Dulwich

### Further Reading

# Appendix C: Git Commands

## Setup and Config

### git config

### git config core.editor commands

### git help

## Getting and Creating Projects

### git init

### git clone

## Basic Snapshotting

### git add

### git status

### git diff

### git difftool

### git commit

### git reset

### git rm

### git mv

### git clean

## Branching and Merging

### git branch

### git checkout

### git merge

### git mergetool

### git log

### git stash

### git tag

## Sharing and Updating Projects

### git fetch

### git pull

### git push

### git remote

### git archive

### git submodule

## Inspection and Comparison

### git show

### git shortlog

### git describe

## Debugging

### git bisect

### git blame

### git grep

## Patching

### git cherry-pick

### git rebase

### git revert

## Email

### git apply

### git am

### git format-patch

### git imap-send

### git send-email

### git request-pull

## External Systems

### git svn

### git fast-import

## Administration

### git gc

### git fsck

### git reflog

### git filter-branch

## Plumbing Commands


