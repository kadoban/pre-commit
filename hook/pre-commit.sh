#!/bin/sh

# Copyright Joshua Simmons
#
# https://www.emptypath.com/git_pre_commit_testing
#
# Available under the BSD3 license, which can be found in the
# LICENSE file in the same directory as this file.

# You usually should not have to make any changes to this file!
#
# Add or change tests in the `auto_tests.sh` file instead.

# redirect output to stderr
exec 1>&2

# if we're not on an orphan branch
if git rev-parse --verify -q HEAD > /dev/null
then
    BEFORE_STASH=$(git rev-parse --verify -q refs/stash)
    git stash save --keep-index --include-untracked -q
    AFTER_STASH=$(git rev-parse --verify -q refs/stash)

    if [ "$BEFORE_STASH" = "$AFTER_STASH" ]
    then
        echo "pre-commit: nothing to test"
        sleep 1
        exit 0
    fi

    ORPHAN=0
else
    ORPHAN=1
    echo "pre-commit WARNING:"
    echo "Be extra careful that you've staged all changes."
    echo "On a newly created orphan branch, tests will run on"
    echo "everything in the working directory, not on just the"
    echo "content to be commited as is usually done!"
    sleep 5
fi

./hook/auto_tests.sh
TEST_RESULT=$?

if [ "$ORPHAN" -eq 0 ]
then
    git reset --hard -q && git stash pop -q --index
fi

if [ "$TEST_RESULT" -ne 0 ]
then
    echo "Error found, aborting commit"
    exit 1
fi

exit 0
