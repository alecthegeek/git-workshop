# Git Workshop Instructions

## WiFi for Demos
We may try to use a private network today (without port blocking or restrictions) to share code amongst ourselves. I've brought along a small WiFi device that can handle 30-50 people, but won't give us Internet access. That's alright though as we aren't going to use the 'net much.

Please ensure you can sign on to the following wireless network:

Wireless SSID:
    AI-MOBILE
Password:
    students
    
Additionally, try to connect to my laptop (ping it), as I'll host some repos there.  My notebook IP address is:
    10.0.1.2

## Handouts
These instructions are downloadable at GitHub from, of all things, a Git repo:
[http://github.com/matthewmccullough/git-workshop](http://github.com/matthewmccullough/git-workshop)

You don't need Git to download them though. GitHub has a download link at the top of each page that lets you get the files in ZIP format without a client Git tool.

## Bookmarks
Matthew maintains a list of interesting (hand-picked) resources about Git tools, features, releases, and uses.  These bookmarks are updated weekly and can be [found on Delicious](http://delicious.com/matthew.mc).


## Dates for other VCSes
There have been a plethora of VCSes over the years. All seem like an incremental improvement over the previous model.

* SCCS
* RCS
* PVCS
* CVS, 1980s
* SVN, 1990s
* Git, 2005

Some firms think SVN is the thing to move to. But would you use a Palm Pilot today? Then why are you using CVS or SVN? They are roughly the same age!

We also need to be conservative in our choice of tools. We don't want to use something that is going to fade away next year. But Git isn't new by technology by any stretch. It is over 5 years old now.


# SSH Setup

## Setting up an SSH Key
This next step works with msysGit (Git for Windows) or on any *NIX system.

    ssh-keygen -t rsa -C "yourname@yourcompany.com"
  
The `-t` flag is the algorithms used to create the key. The `-C` flag is the comment attached to the key. The comment can serve as a reminder of which system you use this with if you are going to generate more than one key pair to partition your Git SSH key from other SSH-authenticated systems and servers.
  
Other algorithms, like DSA, can also be used for SSH authentication and are compatible with Git, since Git is merely using the operating system's underlying SSH capabilities.

    ssh-keygen -t dsa -C "yourname@yourcompany.com"

Lengthier instructions for SSH key generation can be found at the [excellent GitHub page](http://help.github.com/msysgit-key-setup/).

The decision whether or not to use a passphrase for your SSH keys can [also be found on GitHub](http://help.github.com/working-with-key-passphrases/).

## Sharing the Public portion of the Key
Most Git services use half of the key we just generated for authenticating instead of the typical username and password.  In security terms, SSH keys are quite a bit stronger than usernames.

Keep the private half of the key (`id_rsa`) protected. Give away the public half (`id_rsa.pub`) liberally. You could even store it in a directory service if desired.

## Authorizing the key on another server
If you are in control of a server on which you'll be storing Git repos, you can authorize your account to automatically sign in. While logged in to the remote server, put the contents of a user's `id_rsa.pub` file on a single line (*absolutely no linebreaks!*) on a file named `~/.ssh/authorized_keys`.

Similarly, key strings are copied-and-pasted to web based repositories like GitHub via the user interface. Copy the contents of `id_rsa.pub` to the clipboard and paste it into the appropriate textbox in the web UI of GitHub.

## Testing SSH
If you wish to test if you have passwordless (key authentication) working correctly, just SSH to the server. It will use your `id_rsa` and `id_rsa.pub` files automatically if they live in `~/.ssh/`. You should not see any prompt for a password.

    ssh SERVERNAME

In the case of a gitolite server, it will report your repository permissions before terminating.

    hello mccm06, the gitolite version here is v1.5.5-68-g3cf2970
    the gitolite config gives you the following access:
         R   W 	gitolite-admin
        @R  @W 	testing
        @R   W 	testinglessaccess
    Connection to mybigserver closed.


# Setting up Git

## Get binaries
On UNIX:

  * From source
    * [Web UI to browse source](http://git.kernel.org/?p=git/git.git;a=summary)
    * Git repo for source: `git://git.kernel.org/pub/scm/git/git.git`
  * Package manager
    * `apt-get git-core`
    * `apt-get git-gui`
    * `apt-get git-doc`
    * `apt-get git-svn`

On Mac:

  * [MacPorts](http://www.macports.org/) (user-compiled)
  * [HomeBrew](http://github.com/mxcl/homebrew) (user-compiled)
  * [git-osx-installer](http://code.google.com/p/git-osx-installer/) (precompiled)

On Windows:

  * Two [msysGit](http://code.google.com/p/msysgit/) choices: a full toolkit, or just a precompiled distribution.
  * [Precompiled](http://msysgit.googlecode.com/files/Git-1.7.3.1-preview20101002.exe) is named "Git-XXXexe"
  * [Full toolkit](http://msysgit.googlecode.com/files/msysGit-fullinstall-1.7.3.1-preview20101002.exe) with gcc compiler is named "msysGit-fullinstall-XXX.exe"
  
If you get stuck, a series of [help pages at GitHub](http://help.github.com/) are almost certain to assist.

## Configuring your Git username and email address
Establish the one-time parameters stored in your home directory:

    git config --global user.name "Your Name"
    git config --global user.email "you@example.com"
    git config --global color.ui "auto"

View our handiwork

    echo ~/.gitconfig


# The Basics

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

## Creating a free hosted repo
Free hosting for small private Git repositories can be found at a number of sites on the web. A canonical list is maintained at [the official Git site](http://git.wiki.kernel.org/index.php/GitHosting).

The one we'll use today is [GitFarm](http://gitfarm.appspot.com), which is hosted on the Google App Engine.

I've already set up a repository for us to try:

    git clone http://students10@gitfarm.appspot.com/git/students10.git
    password: password
  
    git clone http://students10:password@gitfarm.appspot.com/git/students10.git

# The Internals

## Looking around the .git folder
The .git folder is the "magic" directory

    cd .git
    ls -al
    tree

There is only one .git folder at the top of the tree.

## Showing current Status
Status of a repo while sitting anywhere in that repo's directory tree)

    git status

Everything unstaged diffed to the last commit

    git diff
    
Everything staged diffed to the last commit

    git diff --cached
    
Everything unstaged and staged diffed to the last commit

    git diff HEAD

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
    
Or preview what would have occurred

    git commit --dry-run

Commit with a message provided on the CLI

    git commit -m'Some message'

Commit and add any modified tracked files in one unified command

    git commit -a


# Fixing Mistakes

## Amend
Oops. You *just* committed something with a bad message or the wrong files. Redo a recent commit's file changes or comment. Get the file system in the state you want it before issuing this command.

    git commit --amend

or if you missed a few files that weren't in the last commit

    git commit -a --amend

or if you need to remove a file that wasn't supposed to be in the commit

    # Commit two files.
    # Oops. Only meant to commit one.
    git reset --soft HEAD^
    # Puts files back into staged area.
    # Edit files and/or remove one file from staging.
    git reset HEAD file1.txt
    # Recommit
    git commit -a -c ORIG_HEAD
    
or if you merely need to add more files or changes to the previous commit (not removing any files from the set)

    git commit -a --amend

## Revert
Oops. You realize you made a bad commit yesterday, but it's already been shared across other Git repositories.

Revert to a previous commit (via a new commit), but don't commit it until you review what's going to be in this commit. This is similar to a banking transaction in which you fix the old error by a new journal entry, not deleting the mistaken one. This leaves an audit trail. 

    git revert -n

Revert is the better choice in the situation where the previous changes have been pushed to another repository. If they have, `amend` is a bad idea; you are re-writing history. Your remote repository may subsequently deny your amended push if the original was previously pushed.


# Branches

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

Examine the project's `.git/config` file for automatic mappings


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

Switch to a detached (arbitrary, detached) HEAD
    git checkout TREEISH


## Showing Contents
Show the contents of the most recent commit in patch format

    git show

Show the contents of a arbitrary commit

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
    
Or perform the rebase interactively, where you can change the order of the commits

    git rebase -i <branchname>


## Tagging
List all existing tags
    git tag

Mark a lightweight tag at the current point in history on the current branch
    git tag TAGNAME

Mark a lightweight tag at some previous point in history
    git tag TAGNAME TREEISH
    
Push tags to a remote repo
    git push --tags
    
Overwrite an existing lightweight tag (locally)
    git tag TAGNAME -f

Create a tag object without a digital signature
    git tag TAGNAME -a
    
Find tags containing a commit (do these tags have this fix?)
    git tag --contains TREEISH


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
Build an email that contains the patch
    git email-patch
Apply a patchfile
    git apply <patchfile>

Merge conflict. How do we fix it? How do we continue?
    git add --continue
    
Merge with rebase as a better option for linear history

Merge without commit
    git merge --no-commit
    
Reset soft and hard
    git reset --hard
    
Revert history to two commits ago (discarding them)
    git reset --hard HEAD^^

## Cleaning
Remove untracked files (generally temp, generated, compiled)

    git clean
    
But it will complain that you aren't asking it to actually clean (force, `-f`)

    git clean -f
    
Or preview (`-n`) what will be done

    git clean -n

Or clean directories (`-d`) too (not just files)

    git clean -f -d
    

## Git Server
Git local server
    git serve .
Git read-only http interface
    git instaweb
    
# Making Git Better

## Aliases
Commands can be composed and renamed in Git to better suit your working style. For example, I've renamed `git status` to `git s` and I've composed `git log --oneline --decorate` to `git logod`.

The configuration lives in a file in your home directory called `.gitconfig`.

Alias can be set up in section like the following in the `.gitconfig` file:

    [alias]
      br = branch
      bra = branch -a
      s = status
      cl = clone
      ci = commit
      co = checkout
      d = diff
      dh = diff HEAD
      dc = diff --cached
      who = shortlog -s --
      ph = push
      pl = pull
      lg = log -p
      lgod = log --oneline --decorate

Let's discuss some of these shortcuts and try them out in our own


## Dry Run
Works with cleaning, commits
--dry-run
