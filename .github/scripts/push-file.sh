#!/usr/bin/env bash

# move to the root test repo
cd "./test"
echo "Open root of test repo"

# check if there's already a currently existing feature branch in test for this branch
# i.e. the altered file's already been copied there at least once before
echo "Check if feature branch $BRANCH already exists in test repo"
git ls-remote --exit-code --heads origin $BRANCH >/dev/null 2>&1
EXIT_CODE=$?
echo "EXIT CODE $EXIT_CODE"

if [[ $EXIT_CODE == "0" ]]; then
  echo "Git branch '$BRANCH' exists in the remote repository"
  # fetch branches from test
  git fetch
  # stash currently copied openapi.yaml
  git stash
  # check out existing branch from test
  git checkout $BRANCH 
  # overwrite any previous file changes with current ones
  git checkout stash -- .
else
  echo "Git branch '$BRANCH' does not exist in the remote repository"
  # create a new branch in test
  echo "Creating new branch $BRANCH in test repo"
  git checkout -b $BRANCH
fi

git add -A .
git config user.name shivanihamilpur
git config user.email shivanihamilpur@github.com
git commit -am "feat: Update OpenAPI file replicated from Notehub"
git push --set-upstream origin $BRANCH

echo "Updated file successfully pushed to test repo"
