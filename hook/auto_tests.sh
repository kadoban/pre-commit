#!/bin/sh

# Copyright Joshua Simmons
#
# https://www.emptypath.com/git_pre_commit_testing
#
# Available under the BSD3 license, which can be found in the
# LICENSE file in the same directory as this file.

# Change the following commands to run your
# personalized tests.
#
# It should return non-zero if an error is found.
# What exactly an error is depends on your content
# and your judgement.
#
# If you have multiple testing commands to run,
# you can either chain them together with &&
# or you can add them below the `if` block
# and *copy* the `if` block below your new command.
echo "WARNING: Tests not fully set up!" &&
echo "edit auto_tests.sh to finish setup"

if [ "$?" -ne 0 ]
then
    exit 1
fi

exit 0
