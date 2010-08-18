# Git Workshop Instructions

## WiFi for Demos
Please sign on to the following wireless network

Wireless SSID:
    AI-MOBILE
Password:
    <PLACEHOLDER>

Instructions downloadable at GitHub:
[http://github.com/matthewmccullough/git-workshop](http://github.com/matthewmccullough/git-workshop)

Matthew's notebook IP address:
    10.0.1.2


## Dates for other VCSes
SCCS
RCS
PVCS
CVS, 1980s
SVN, 1990s

Would you use a Palm Pilot?  Then why are you using CVS!


## Setting up Git
Establish the one-time parameters stored in your home directory
    git config --global user.name "Your Name"
    git config --global user.email "you@example.com"
    git config --global color.ui "auto"

View our handiwork
    echo ~/.gitconfig


## Building a new repo
    mkdir anewproject
    cd anewproject
    git init

or Naked, no local files, and with group UNIX permissions for headless use
    git --bare init --shared


## Cloning someone else's Git protocol-hosted repo
List of Git-hosted projects
    http://git.apache.org
Get a full copy of a Git project
    git clone git://git.apache.org/commons-logging.git


## Cloning a HTTP repo
Apache also is pushing nightly syncs to GitHub
    http://github.com/apache/commons-logging
Clone from GitHub (can be forked)
    git clone http://github.com/apache/commons-logging.git


## Looking around the .git folder
The .git folder is the "magic" directory
    cd .git
    ls -al
    tree

There is only one .git folder at the top of the tree.


## Showing current Status
Status of a repo while sitting anywhere in that repo's directory tree)
    git status

    git diff
everything unstaged diffed to the last commit

    git diff --cached
everything staged diffed to the last commit

    git diff HEAD
everything unstaged and staged diffed to the last commit


## Adding, removing, renaming, committing
    git add <WILDCARD>
    git add <SPECIFICFILENAME>

Interactive
    git add -i

Interactive patch mode
    git add -p

Remove a file from being tracked
    git rm FILENAME

Rename a tracked file
    git mv FILENAME NEWFILENAME

Commit changes with a message provided interactively ($GIT_EDITOR or $EDITOR)
    git commit

Commit with a message provided on the CLI
    git commit -m'Some message'

Commit and add any modified tracked files in one unified command
    git commit -a


## Oops!
Redo a recent commit's files or comment
    git commit --amend
Get the file system in the state you want it before issuing this command.

Revert to a committed change (via a new commit), but don't commit
    git revert -n


## Branching
Show local branch names
    git branch
Show all branch names
    git branch -a
Show all branch names with URLs
    git branch -a -v

List remote tracking branches only
    git branch -r

Create a new branch and check it out
    git branch <new branch name> <from branch>
    git checkout <new branch name>

Create a new branch and check it out in one unified operation
    git checkout -b <new branch name> <from branch>


## Visualizing
Show the contents of the last commit
    git show

Show the current branch's merge status
    git show-branch

Show every branch's merge status
    git show-branch --all

Show the contents further back the parent tree
    git show-branch --more=5

Show a max of 10 entries from no more than 1 hour ago for the master branch
    git show-branch --reflog="10,1 hour ago" --list master

Show three branches and their merge status
    git show-branch master feature1 feature2

### Understanding the branch visualizations
* The branch head that is pointed at by HEAD is prefixed with an asterisk * character
* Other heads are prefixed with a ! character.
* Following these N lines, one-line log for each commit is displayed, indented N places.
    * If a commit is on the I-th branch, the I-th indentation character shows a + sign
    * Otherwise it shows a space (does not exist here).
            * Merge commits are denoted by a - sign.


## Merging
Merge a branch into the current branch
    git merge <OTHERBRANCHNAME>

Merge multiple branches into the current branch
    git merge <BRANCHONE> <BRANCHTWO> <BRANCHTHREE> <BRANCHFOUR>


## Pushing to a repo
My Git playground repo URL
    git@github.com:matthewmccullough/hellogitworld.git

Push the current branch
    git push
    
Push to a specific remote and only a specific branch
    git push origin master
    git push <remote name> <branch name>

Push a branch to a different name on the remote
    git push <remote name> <local branch name:remote branch name>
    git push origin master:newbranch

Delete a remote branch
    git push origin somebranch:
    
Push all branches, all tags
    git push --all

Push even if refs disagree on parents
    git push --force


## Retrieving code
Pull in the blobs into our repo, but don't merge them
    git fetch <remote name>

What changes did we get?
    git log master..origin

Merge them in
    git merge <remote name/remote branch>

Automatic fetch and merge
    git pull
    git pull <remote name>
    git pull <remote name> <branch name>

Examine .git/config file for automatic mappings


## Log history
Show all history
    git log

Show a week of history
    git log --since="one week ago"

Show the history of one file
    git log -- SOMEFILENAME

Show the number of lines modified (statistics)
    git log --stat

Show the diff (patch) of code changes from a specific commit
    git log trunk~259 -p
    git log HEAD^^^ -p

Show a finite range of commit messages
    git log HEAD~4..HEAD^1


## Checkouts
Switch to a given branch
    git checkout BRANCHNAME

Switch to a detached (arbitrary) HEAD
    git checkout TREEISH


## Showing Contents
Show the contents of a commit
    git show HEAD^^


## Composition of a file
Visualize the file's commits that brought it to the current state, including  developer, branch, date
    git blame FILENAME


## Stash
Safely stash work in progress while interrupted
    git stash

Put the work back on the current branch via a merge, leaving it on the stack
    git stash apply

Put the work back on the current branch and remove it from the stack
    git stash pop

Show what is on the current stack of stashes
    git stash list


## Resetting to a Previous State
Move staged files back to unstaged state
    git reset

Discard any uncommitted changes
    git reset --hard

Restore a single file to its last committed state
    git checkout -- SOMEFILE

Restore a file to a past specified state
    git checkout TREEISH -- SOMEFILE


## Rebase
Linearize the branch commits. Rebranches at the latest <source branch name> and replays committed branch work on top of that.
    git rebase <source branch name>


## Tagging
Mark a tag at the current point in history on the current branch
    git tag TAGNAME

Mark a tag at some previous point in history
    git tag TAGNAME TREEISH


## Remotes
Show all remotes' simple names
    git remote

Show remotes with URLs
    git remote -v

Add a new remote
    git remote add NAME URL


## Bundles
Create a bundle from a range of commit treeish
    git bundle create catchupsusan.bundle HEAD~8..HEAD

Create a bundle from a range of time
    git bundle create catchupsusan.bundle --since=10.days master

Show contents of a bundle
    git ls-remote catchupsusan.bundle

Pull in the blobs from a bundle as if they were a remote, but don't merge them
    git fetch catchupsusan.bundle
    

## GUIs
Visualizes previous commits
    gitk

Facilitates new commits
    git gui


## SVN
Clone one part (branch, folder, tree) of a Subversion repository
    git svn clone URL

Clone an entire SVN repo with tags, trunks, and branches
    git svn clone --stdlayout URL
    git svn clone --stdlayout http://svn.apache.org/repos/asf/commons/proper/logging/
    git svn clone --stdlayout http://ambientideas.unfuddle.com/svn/ambientideas_sample11-svnscm/

or just the trunk
    git svn clone http://ambientideas.unfuddle.com/svn/ambientideas_sample11-svnscm/trunk

Get new commits from Subversion
    git svn rebase

Push Git commits back to Subversion
    git svn dcommit


## Git Ignores
Stored in a file at any level of the tree.
    .gitignore

Can apply recursively.
    **/*.tmp

Glob pattern format
    **/log*/*.log

Exclusions
    !logstuffweneedtokeep


## Searching in Code
Find text in the tracked files
    git grep
    git grep <TREEISH>


## Finding a bug
Start the process of finding a commit where tests broke
    git bisect start

Mark current point as bad
    git bisect bad

Mark an older point as good
    git bisect OLDERTREEISH

Show the results of the bisect
    git bisect log

Start the bisect over again
    git bisect reset

Indicate the CLI command to run for the boolean outcome (testing)
    git bisect run <COMMAND>

Diagram the result of testing
    git bisect visualize


## Repo Maintenance
File system check:
    git fsck

Compact old loose commits into pack files and prune orphans
    git gc


# TODO:
git apply <patchfile>
git email-patch

Merge conflict
Merge with rebase
git add --continue

Merge without commit
Reset soft and hard
git clean -f -d

SSH setup, keygen, save to GitHub
git serve .
git instaweb