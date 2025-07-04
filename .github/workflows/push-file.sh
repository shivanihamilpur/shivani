#!/usr/bin/env bash

# move to the root sample repo
cd "./sample"
echo "Open root of sample repo"

# check if there's already a currently existing feature branch in sample for this branch
# i.e. the altered file's already been copied there at least once before
echo "Check if feature branch $BRANCH already exists in sample repo"
git ls-remote --exit-code --heads origin $BRANCH >/dev/null 2>&1
EXIT_CODE=$?
echo "EXIT CODE $EXIT_CODE"

if [[ $EXIT_CODE == "0" ]]; then
  echo "Git branch '$BRANCH' exists in the remote repository"
  # fetch branches from sample
  git fetch
  # stash currently copied openapi.yaml
  git stash
  # check out existing branch from sample
  git checkout $BRANCH 
  # overwrite any previous file changes with current ones
  git checkout stash -- .
else
  echo "Git branch '$BRANCH' does not exist in the remote repository"
  # create a new branch in sample
  echo "Creating new branch $BRANCH in sample repo"
  git checkout -b $BRANCH
fi

git add -A .
git config user.name github-actions
git config user.email github-actions@github.com
git commit -am "feat: Update OpenAPI file replicated from Notehub"
git push --set-upstream origin $BRANCH

echo "Updated file successfully pushed to sample repo"
