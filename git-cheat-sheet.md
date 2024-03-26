# Git All Commands
----------------------
## Initialized
```
git init
git config --global user.email "parvazemd.masud@gmail.com"
git config --global user.name "parvaze"
git add .
git commit -m "first commit"
git remote add origin https://github.com/parvaze-masud/java-web-application.git
git push -u origin main                          
```

## Check Git info and set a new URL
```
git config --list    #For check details info
git remote -v            #view code owner
git remote set-url origin https://github.com/parvaze-masud/java-web-application.git  #to change the origin URL to a new remote repository on GitHub
```
## Git clone from a specific
```
git clone -b my-feature-branch https://git-codecommit.us-east-1.amazonaws.com/v1/repos/my-repo
```

## Restore Fill
```
git restore filename										# Roll back to previous version of file -- working area
git restore --staged store1.txt								# Restore file from staging area
git rm --cached pay.txt										# Remove file from stating area
```
## Check GIT Log
```
git log
git log --oneline
git revert commit-id
git log --name-only
git log -n 1  #Find last commit
git log --graph --decorate
```
## GIT branching
```
git branch sarah	# Create new branch
git checkout sarah	# Switch to new branch
git checkout -b sarah	# Create and switch to new branch
git branch -d sarah	# Delete branch
git branch			#check branc list
git branch -a  		# Find local and remote branch list
```
## Mergeing
```
git checkout master				
git merge story/frogs-and-ox		#Merge branch
```
## Git Push
```
git branch -M main
git push -u origin main
git push -u origin sajib
```
## GIT Pull
```
git fetch origin master
git merge origin/master
git pull origin master
```
## Merge Conflict

Remove all the lines added by git


## GIT Rebase
```
git checkout master
git pull origin master
git checkout story/hare-and-tortoise
git rebase master
git log --graph --decorate
git resabs -i HEAD~3				[Last Three commit marge with a single commit using git squash]
```
In the editor that opens, leave the first line as is, and change the second and third lines to use squash instead of pick. Then save the file. This way we pick the first commit and then squash the second and third commits to it.
In the next editor window that opens set the commit message to Add hare-and-tortoise story and save it.

## Cherry PICK to pick certain commit
```
git log --oneline [First identify the hash of the last commit that]
git checkout story/hare-and-tortoise
git cherry-pick 00a5c7f
```
## Restting and Reverting:
```
git revert bc347d8785df6465a7dc6a90f8fecb99c40a5722
git revert HEAD~0
git reset --soft HEAD~1			# Rollback to 1 commit but keep story
git reset --hard HEAD~3			#Rollback 3 step remove all commit story
git log --name-only		#Check the previous commit and identify the number of stories Sarah modified     
```
## GIT Stash: (To temporarily save half done task)
```
git stash
git checkout master
vim lion-and-mouse.txt
git add .
git commit -m "Fixed title error"
git checkout story/frogs-and-ox
git stash pop		# Back the file into the working area
git stash list
git stash show stash@{1}
```
## Rollboack hard reset commit:
```
git reflog
git reset --hard 8ad5
```
