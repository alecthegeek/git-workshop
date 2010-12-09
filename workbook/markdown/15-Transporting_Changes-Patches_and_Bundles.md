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

