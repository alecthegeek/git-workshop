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

To check out a project and set up the submodules:

    git clone <git://url/yourrepo.git>
    cd <yourrepo>
    # Setup the submodule .gitmodules file
    git submodule init
    # Retrieve the submodules' code
    git submodule update
    
If another developer changes the submodule, then commits the parent project and you pull and retrieve that, you'll need to update the submodules again to stop your `git status` from telling you the tree is dirty.

    git submodule update
    
The main concept is just to put the submodule in whatever state you want it to be in, then add and commit from the parent project. If a colleague does that and then you pull the parent project, you need to `update` to get the latest submodule code. Remember that submodule changes need to be pushed distinctly from their parent. If a developer fails to do that, her colleagues won't be able to retrieve the commits; the parent project will be pointing to a hash that isn't publicly available.

## Reflog
The `reflog` is the transactional journal of what's been performed on your repository, including `reset`s, `commit`s, `merge`s and `rebase`s. Can be used to identify a treeish to `reset` to (a known `HEAD@{X}` point).

    git reflog 
    817c5e7 HEAD@{0}: commit (initial): Adding files
    
    git reset HEAD@{0}

or

    git merge HEAD@{0}
    
Reflog entries are [kept for 90 days](https://www.kernel.org/pub/software/scm/git/docs/git-reflog.html). Orphaned entries are kept for 30 days.














squash