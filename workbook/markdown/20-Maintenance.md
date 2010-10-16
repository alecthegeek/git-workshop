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
