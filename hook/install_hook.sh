#!/bin/sh

# Copyright Joshua Simmons
#
# https://www.emptypath.com/git_pre_commit_testing
#
# Available under the BSD3 license, which can be found in the
# LICENSE file in the same directory as this file.

WORK=$(git rev-parse --show-toplevel) &&
GIT=$(git rev-parse --git-dir) &&
ln --symbolic --relative "$WORK"/hook/pre-commit.sh \
                         "$GIT"/hooks/pre-commit

if [ "$?" -ne 0 ]
then
    echo "Error: could not install pre-commit hook."
    exit 1
else
    echo "pre-commit hook installed successfully."
fi
