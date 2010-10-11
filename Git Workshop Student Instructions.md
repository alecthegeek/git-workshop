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




# Some History

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
    
or the [Grails project](http://github.com/grails/grails-core), which has several branches:

    git clone http://github.com/grails/grails-core.git
    git clone git://github.com/grails/grails-core.git

## Cloning an HTTP repo
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

## Adding
    git add <WILDCARD>
    git add <SPECIFICFILENAME>

Interactive

    git add -i

Interactive patch mode

    git add -p
    
## Removing
Remove a file from being tracked

    git rm FILENAME
    
## Renaming (Moving)
Rename a tracked file

    git mv FILENAME NEWFILENAME

## Committing
Commit changes with a message provided interactively ($GIT_EDITOR or $EDITOR)

    git commit
    
Or preview what would have occurred

    git commit --dry-run

Commit with a message provided on the CLI

    git commit -m'Some message'

Commit and add any modified tracked files in one unified command

    git commit -a

## Git Ignores
Stored in a file at any level of the tree.

    .gitignore

Can apply recursively.

    **/*.tmp

Glob pattern format

    **/log*/*.log

Exclusions

    !logstuffweneedtokeep




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

## Reset
    
Reset soft and hard

    git reset --hard
    
Revert history to two commits ago (discarding them)

    git reset --hard HEAD^^

## Cleaning
Remove untracked files (generally temp, generated, compiled)

    git clean
    
But it will complain that you aren't asking it to actually clean (force, `-f`)

    git clean -f
    
Or preview (`-n` or `--dry-run`) what will be done

    git clean -n
    git clean --dry-run

Or clean directories (`-d`) too (not just files)

    git clean -f -d




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
    
### Merge Conflicts
--ours
--theirs

Merge conflict. How do we fix it? How do we continue?

    git add --continue
    
Merge with rebase is a better option for linear history

Merge without commit

    git merge --no-commit


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

Examine the project's `.git/config` file for automatic mappings. Projects locally created won't be tracking the remote repository so you would need to `git push origin master` or `git push origin master` verbosely each time. You'd see an error like this:

    git pull
    You asked me to pull without telling me which branch you
    want to merge with, and 'branch.master.merge' in
    your configuration file does not tell me, either. Please
    specify which branch you want to use on the command line and
    try again (e.g. 'git pull <repository> <refspec>').
    See git-pull(1) for details.

    If you often merge with the same branch, you may want to
    use something like the following in your configuration file:

        [branch "master"]
        remote = <nickname>
        merge = <remote-ref>

        [remote "<nickname>"]
        url = <url>
        fetch = <refspec>

    See git-config(1) for details.

or even if you specify a remote, but no branch:

    git pull origin
    From http://gitfarm.appspot.com/git/students10
     * [new branch]      master     -> origin/master
    You asked to pull from the remote 'origin', but did not specify
    a branch. Because this is not the default configured remote
    for your current branch, you must specify a branch on the command line.

To have the branch track a remote without re-checking it out, just edit the `.git/config` file. The branch will look like this:

    [core]
    	repositoryformatversion = 0
    	filemode = true
    	bare = false
    	logallrefupdates = true
    	ignorecase = true
    [remote "origin"]
    	url = http://students10:password@gitfarm.appspot.com/git/students10.git
    	fetch = +refs/heads/*:refs/remotes/origin/*

    
and needs to be changed to look like this:

    tag

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

## Checkout
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

## Rerere
If you merge a branch often, you don't want to keep telling Git how to merge it every time you merge. With rerere enabled (just an option switch), it will remember your resolutions and use them next time to minimize your effort.

    git config --global rerere.enabled 1




# Managing Checkpoints

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
    
Note that `.git/refs/tags` are the non-object tags.


## Remotes
Show all remotes' simple names

    git remote

Show remotes with URLs

    git remote -v

Add a new remote

    git remote add NAME URL




# Transporting Changes

## Bundles
Bundles are binary compressed archives that contain a series of commits. This format can be easily transmitted via email or USB stick.

Create a bundle from a range of commit treeish

    git bundle create catchupsusan.bundle HEAD~8..HEAD

Create a bundle from a range of time

    git bundle create catchupsusan.bundle --since=10.days master

Show contents of a bundle

    git ls-remote catchupsusan.bundle

Pull in the blobs from a bundle as if they were a remote, but don't merge them

    git fetch catchupsusan.bundle

## Patching
Build an email that contains the patch

    git email-patch

Apply a patchfile

    git apply <patchfile>




# GUIs

## Bundled GUIs
Visualizes previous commits

    gitk

Facilitates new commits

    git gui

## IDEs
* NetBeans
  * [NBGit plugin](http://nbgit.org/)
  * Good support for day-to-day commands
* Eclipse
  * EGit (GUI) and JGit (framework) projects.
  * Was separate, but now officially at Eclipse.org
  * Git now the default new repository format at Eclipse.org
  * Significant investment in this plugin.
* IntelliJ
  * Bundled with the product
  * Earliest IDE to include support
* SmartGit by Syntevo
  * Standalone product
  * Commercial and free licenses
  * Derivative of SmartSVN

## Editors
* emacs
* vi
* TextMate

## Shell Plugins
* Tortise Git
* Cheetah
* Git Shell Extensions (for Windows)
* For Mac
* For Unix




# Interoperability

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

## ClearCase
* Conversion Tools
  * [CMBridge](http://www.clearvision-cm.com/version-control-connectors/cmbridge/ash_flypage.tpl.html)
    * Commercial tool
    * Round-trip conversion
    * SVN and Git support
  * A workflow that uses [ClearCase for checkouts and Git for desktop version control](http://genaud.net/2008/08/clearcase-globally-git-locally/)
    * Merely a manual way of working with the two systems
    * Puts strain on the developer to maintain state in Git and push back to CC as needed
    * Can require locking
  * [Another workflow](http://www.turbodad.com/articles/24/12-revision) that slightly improves on the previous one
    * Still no real automation
    * Burdens the developer
    * But doesn't require the approval, purchase or download of any bridging tools
  * [git-cc scripts](http://github.com/charleso/git-cc)
    * Provides `gitcc` script.
    * Offers convenience "bridge" functions to put changes back into CC, treating it as the source-of-record.
    * Similar to the git-svn bridge that is part of the official Git distribution
  * [git-clearcase bridge](http://gitorious.org/git-clearcase)
    * [Readme](http://gitorious.org/git-clearcase/git-clearcase/blobs/master/README)
    * Perl based
    * Only works with one view
    * No history import
    * `gitclearcase initcc` to start
    * `gitclearcase pullcc` to push changes back in (checkout, merge, checkin to CC)
    * If conflicts, resolve, then `gitclearcase commitcc`    
  * Native Git conversion
    * Write your own scripts
    * git fast-import
    
## Fast-Import
Git `fast-import` is a human-readable transport format for recreating repositories. Ben Lynn has written a quick description of [fast-import](http://crypto.stanford.edu/~blynn/gitmagic/ch05.html) that is helpful to read.

The standard use of fast-import is a one time import of source code history from another version control system. Using sed, awk, grep and similar tools, developers can craft an output to almost any version control system that matches this fast-import file format.
    
Example export:

    blob
    mark :1
    data 13
    Testing
    JUNK

    blob
    mark :2
    data 14
    Testing2
    JUNK

    commit refs/heads/master
    mark :3
    author Matthew McCullough <matthewm@ambientideas.com> 1286663588 -0600
    committer Matthew McCullough <matthewm@ambientideas.com> 1286663588 -0600
    data 11
    More stuff
    M 100644 :1 test1.txt
    M 100644 :2 test2.txt

    blob
    mark :4
    data 22
    Testing
    JUNK
    MOREJUNK

    blob
    mark :5
    data 23
    Testing2
    JUNK
    MOREJUNK

    commit refs/heads/master
    mark :6
    author Matthew McCullough <matthewm@ambientideas.com> 1286664669 -0600
    committer Matthew McCullough <matthewm@ambientideas.com> 1286664669 -0600
    data 15
    Another commit
    from :3
    M 100644 :4 test1.txt
    M 100644 :5 test2.txt
    
Create a Git repository from this formatted input file:

    mkdir importedproject
    cd importedproject
    git init
    git fast-import --date-format=rfc2822 < /myimportfile
    
and then switch to the master branch after the import with:

    git checkout master .
    
There is an equivalent `git fast-export` command that outputs an already-Git repository to this plaintext format. It can be used to study the format and learn how to craft your own import files.

    git fast-export HEAD^^..HEAD
    
You'll likely want to redirect this output to a file.
    


# Power Tools

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
    
If you want to manually mark the status of the current checkout and proceed to the next, type either of the following:

    git bisect bad
    git bisect good

Show the results of the bisect

    git bisect log

Start the bisect over again or to finish the process

    git bisect reset

If you wish to automate the run of the tests and marking boolean outcome (testing), use the `run` command. The program must return 0 for `good`, 125 for `skip`, 1-127 (except 125) for `bad`, and any negative value like -1 for `abort`.

    git bisect run <COMMAND>

Diagram the result of testing

    git bisect visualize




# Maintenance

## File System Check
File system check verifies integrity. Finds corrupt objects.

    git fsck

## Prune
Prune is a command that optimizes your repository by removing commits that are not orphaned.

    git prune

or to see what is orphaned, but not actually touch them:

    git prune --dry-run

## Garbage Collect
GC compacts old loose commits into pack files and `prune`s orphan commits. It is a superset of the `prune` command and is more commonly run than `prune`.

    git gc




# Servers & Web Interfaces

## Git Daemon
Run a local Git server on port 9418 (`DEFAULT_GIT_PORT`). The `--base-path` option sets up a virtual new root for cloning. Otherwise, the cloning end would need to know the actual path on your disk from the root to the repository folder. That is generally undesirable and the more common expectation is that repos are at the top level.

    git daemon --export-all --base-path=. .
    
Then the client can clone this with:

    git clone git://<somehostoripaddr>/myrepo
    
The `--export-all` option is necessary to force sharing of all repositories found, even if the marker file `git-daemon-export-ok` is not present in the specific repos you wish to share. If you do create the marker file, then the following will suffice:

    git daemon --base-path=. .

## Gitosis
The next lightest weight Git repository hosting solution.

* Managed via cloning and pushing changes to a gitosis-admin repository.
* No UI
* Medium-grained control of access to repositories per user.
* Keys committed to subfolder of admin repo and are pushed into `authorized_keys` by a post-commit hook.

## Gitolite
A medium-weight Git repository management solution.

* Finer grained control over permissions and access than Gitosis.
* Can lock glob patterns (branches, folders, repos) per repo
* Like Gitosis, has a folder of the admin repo for keys, which are automatically inserted in `authorized_keys` when pushed.
* Requires administrator to publish SSH keys for users (can't be published by the users)
* Offers "personal playground" repos per user.
* Offers feedback on permissions if ssh to the host is tried

Sample output:

    ssh gitolite@myserver
    
    PTY allocation request failed on channel 0
    hello mccm06, the gitolite version here is v1.5.5-68-g3cf2970
    the gitolite config gives you the following access:
         R   W 	gitolite-admin
        @R  @W 	testing
        @R   W 	testinglessaccess
    Connection to myserver closed.

## Gitorious
A "heavier" Ruby web interface and Git repository hosting solution.

* Medium grained access control.
* Public instance at Gitorious.com
* Users can self-publish their SSH key via the web interface.

## Instaweb
User interface only. No hosting capabilities.

To run a Git read-only http interface while sitting at a prompt inside a git repository:

    git instaweb

Then open a browser to [http://127.0.0.1:1234/](http://127.0.0.1:1234/).

On Linux, just `apt-get` the `lighttpd` package.

On Mac, use MacPorts or HomeBrew to install package `lighttpd`

On Windows, this is a [bit more challenging](http://asimilatorul.com/index.php/2009/10/12/git-instaweb-using-mongoose-and-msysgit/) to set up.
    
## Fisheye
[Atlassian Fisheye 2.2 has support for Git and Clearcase](http://www.clearvision-cm.com/clearvision-news/atlassian-fisheye-2.2-adds-support-for-git-and-ibm-rational-clearcase.html)

## ViewVC
TODO: Is Git support ready yet? On an experimental branch?

## Gerrit
Tool for code reviews.
Invented at Google.



# Continuous Integration

## Bamboo
Git support is available as a [plugin for Bamboo](http://www.atlassian.com/software/bamboo/tour/bamboo-plugin.jsp]

[The Git plugin](https://plugins.atlassian.com/plugin/details/9510) was authored by Kristian Rosenvold of Zenior AS in Norway and Don Brown of Atlassian.

For post-build pushes of repos up-stream, the [Pre/Post Build Command Plugin](https://plugins.atlassian.com/plugin/details/5581) will assist in calling git (must be on the Bamboo server's path):

    git push FULLREPOURL BRANCHNAMETOPUSH:BRANCHNAMEONREMOTESIDE
    
With an actual URL

    git push git://git.apache.org/commons-logging.git master-trial:master
    
Can walk through setting up a Git based project (from Apache Git sources)

    [Bamboo on http://localhost:8085/](http://localhost:8085/)

## Hudson

[Hudson](http://hudson-ci.org/) is an open source CI server. It has excellent Git integration via the [Git plugin](http://wiki.hudson-ci.org/display/HUDSON/Git+Plugin).



    
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
      dw = diff --word-diff
      dh = diff HEAD
      dc = diff --cached
      who = shortlog -s --
      ph = push
      pl = pull
      lg = log -p
      lgod = log --oneline --decorate

Let's discuss some of these shortcuts and try them out in our own.

Aliases can also be added via the config command, but find this to be less efficient than editing the `~/.gitconfig` file directly.

    git config –-global alias.who shortlog -s --
    
Aliases only allow for Git commands by default, but you can coax it to run shell commands by prefixing the alias with an exclamation `!`.

    dm = !git diff | mate
    dv = !git diff | vim
    publish = !git checkout master && git pull && git checkout dev && git rebase master && git checkout master && git

The `publish` command comes from the [ideas of Justin French](http://justinfrench.com/notebook/git-aliases-rock).

## Submodules
This is the equivalent to SVN externals. Submodules are subdirectories of a Git project that point to another Git project.

Starting in an existing Git repository, add a submodule.

    git submodule add git://somehost/someproject.git mysubproj
    
This will create a subfolder named `mysubproj` in the current directory and a new file called `.gitmodules` that contains mappings to the repositories.

Git tracks the submodule and the parent module separately. To change, update, or modify the submodule, `cd` into it's directory.

Git helps the parent project precisely track the commit (not a symbolic `master` or `HEAD`) hash that the submodule is at for this parent project. This commit point can be different than another parent project that points to this submodule at a different commit point.

## Reflog
The `reflog` is the transactional journal of what's been performed on your repository, including `reset`s, `commit`s, `merge`s and `rebase`s. Can be used to identify a treeish to `reset` to (a known `HEAD@{X}` point).

    git reflog 
    817c5e7 HEAD@{0}: commit (initial): Adding files
    
    git reset HEAD@{0}

or

    git merge HEAD@{0}
    
Reflog entries are [kept for 90 days](https://www.kernel.org/pub/software/scm/git/docs/git-reflog.html). Orphaned entries are kept for 30 days.





# Scalability
* Linux kernel averaging 2-4 changes per hour continuously for the last 4 years
* Have used with repos up to 2.4 GB in size, but that's on the large size
* `git gc` on an 8GB project is quite slow
* Modularization of your project is key (submodules)
* A multi-GB file can cause Git to run out of memory while commiting it.




# Ecosystem

## Git-converted Projects
* [Apache (select project only, read-only mode)](http://git.apache.org/)
* 1.3 million projects at [GitHub](http://github.com)
* Android
* Perl
* Grails
* Hibernate

## External Merge Tools
Araxis

    git difftool HEAD HEAD^ -- test2.txt
    
Setup

    #[diff]
    #	tool = adifftool
    #	external = git-difftool--helper
    
or

    [difftool "adifftool"]
    	cmd = araxis-difftool.sh \"$LOCAL\" \"$REMOTE\" \"$MERGED\"
    [difftool]
    	prompt = false

    #Automatically do all merges with this mergetool
    [merge]
    	tool = amergetool
    [mergetool "amergetool"]
    	cmd = araxis-mergetool.sh \"$PWD/$LOCAL\" \"$PWD/$BASE\" \"$PWD/$REMOTE\" \"$PWD/$MERGED\"
    [mergetool]
    	prompt = false
    	
## Shortlog
For release notes

    git shortlog

Author summary only

    git shortlog -s -10
    
## Describe
Short notation to refer to a commit based on its position relative to a branch point.

    git describe





# TODO:
cat-file
