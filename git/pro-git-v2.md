# [Getting Started]

## About Version Control

### Local Version Control Systems

[RCS](https://www.gnu.org/software/rcs/) works by keeping patch sets
(that is, the differences between files) in a special format on disk; it
can then re-create what any file looked like at any point in time by
adding up all the patches.

### Centralized Version Control Systems

### Distributed Version Control Systems

## A Short History of Git

### Snapshots, Not Differences

- These other systems think of the information they store as a set of
  files and the changes made to each file over time (this is commonly
  described as *delta-based* version control).

- Instead, Git thinks of its data more like a series of snapshots of a
  miniature filesystem.

### Nearly Every Operation Is Local

### Git Has Integrity

### Git Generally Only Adds Data

### The Three States

## What is Git?

### Snapshots, Not Differences

### Nearly Every Operation Is Local

### Git Has Integrity

- Everything in Git is checksummed before it is stored and is then
  referred to by that checksum.

- The mechanism that Git uses for this checksumming is called a SHA-1
  hash.

- This is a 40-character string composed of hexadecimal characters (0--9
  and a--f) and calculated based on the contents of a file or directory
  structure in Git.

### Git Generally Only Adds Data

### The Three States

- Git has three main states that your files can reside in: *modified*,
  *staged*, and *committed*:

  + Modified means that you have changed the file but have not committed
    it to your database yet.

  + Staged means that you have marked a modified file in its current
    version to go into your next commit snapshot.

  + Committed means that the data is safely stored in your local
    database.

  This leads us to the three main sections of a Git project: the
  *working tree*, the *staging area* (its technical name in Git parlance
  is the "index", but the phrase "staging area" works just as well),
  and the *Git directory*.

## The Command Line

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

# [Git Basics]

## Getting a Git Repository

### Initializing a Repository in an Existing Directory

### Cloning an Existing Repository

- What are these protocols?

  + `https://`

  + `git://`

  + `user@server:path/to/repo.git` (the SSH transfer protocol)

## Recording Changes to the Repository

### Checking the Status of Your Files

### Tracking New Files

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

### Viewing Your Staged and Unstaged Changes

- To see what you've changed but *not* yet staged, type `git diff` with
  no other arguments.

  That command compares what is in your working directory with what is
  in your *staging area*.

  That's why if you've staged all of your changes, `git diff` will give
  you no output.

- If you want to see what you've staged that will go into your *next
  commit*, you can use `git diff --staged`.

  This command compares your staged changes to your *last commit*.

- See all the changes since the last commit, whether or not they have
  been staged for commit or not?

- Summary:

  ```
               HEAD ______git diff______ Working
                    \       HEAD       /  tree
                     \                /
                      \              /
                       \            /
                   git diff     git diff
                   --staged    (haven't yet staged)
                          \      /
                           \    /
                            \  /
                             \/
                           Staging
                            area
  ```

### Committing Your Changes

### Skipping the Staging Area

- `git commit --all` command makes Git automatically stage every file
  that is already tracked before doing the commit, letting you skip the
  `git add` part.

### Removing Files

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

## Viewing the Commit History

### Limiting Log Output

## Preventing the display of merge commits

## Undoing Things

### Unstaging a Staged File

### Unmodifying a Modified File

### Undoing things with git restore

#### Unstaging a Staged File with git restore

#### Unmodifying a Modified File with git restore

## Working with Remotes

## Remote repositories can be on your local machine.

### Showing Your Remotes

### Adding Remote Repositories

### Fetching and Pulling from Your Remotes

### Pushing to Your Remotes

### Inspecting a Remote

### Renaming and Removing Remotes

## Tagging

### Listing Your Tags

## Listing tag wildcards requires `-l`

### Creating Tags

### Annotated Tags

### Lightweight Tags

### Tagging Later

### Sharing Tags

## `git push`

### Deleting Tags

### Checking out Tags

## Git Aliases

## Summary

# [Git Branching]

## Branches in a Nutshell

### Creating a New Branch

### Switching Branches

## `git log`

## Switching branches changes files in your working directory

## Creating a new branch and switching to it at the same time

## Basic Branching and Merging

### Basic Branching

### Basic Merging

### Basic Merge Conflicts

### Changing a branch name

#### Changing the master branch name

## Branching Workflows

### Long-Running Branches

### Topic Branches

## Remote Branches

## "origin" is not special

### Pushing

## Don't type your password every time

### Tracking Branches

## Upstream shorthand

### Pulling

### Deleting Remote Branches

## Rebasing

### The Basic Rebase

### More Interesting Rebases

### The Perils of Rebasing

### Rebase When You Rebase

### Rebase vs. Merge

## Summary

# [Git on the Server]

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

# [Distributed Git]

## Distributed Workflows

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

# [GitHub]

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

# [Git Tools]

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

# [Customizing Git]

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

# [Git and Other Systems]

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

# [Git Internals]

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

# [Appendix A: Git in Other Environments]

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

# [Appendix B: Embedding Git in your Applications]

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

# [Appendix C: Git Commands]

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


