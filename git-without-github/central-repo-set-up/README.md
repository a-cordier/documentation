# Git without github, setting up a central repository

This is about how to to set up a central repo and use git with a more "repo-centric" approach

### init "server" repository

install git on your operating stystem

**add and set up a git user**

adduser git

su git
cd ~
mkdir .ssh
passwd 

**init a project**

mkdir ${project}.git
cd ${project}.git
git init -bare


**disable shell for git user**

:x: we don't want git user to access an unleashed shell on our server ! 

```which git-shell```

This returns ${git-shell} eg /usr/bin/git-shell 

edit /etc/passwd
``` 
git:x:1000:1000::/home/git:${git-shell} # git-shell is substituted to /bin/bash
```
**import developper public key**

cat ${user}.pub >> /home/git/.ssh/authorized_keys

### Developper side: generate public key

ssh-keygen -t rsa

follow instructions and communicate the generated **PUBLIC** key  (~/.ssh/id_rsa.pub by default) to your git central repository system administrator

### simple usage

**repository side**
```
mkdir my_project.git
cd custom-style.git
git init -bare

```

**client side**
```
cd my_project
git remote add origin git@example.com:my_project.git
git add .
git commmit -m << my comment >>
[optional] git checkout -b my_branch 
git push origin my_branch
```
## Using Gitosis

At this point we get a working repository, but how do we manage account for multiple developers ? This is where gitosis helps. This will allow not using unix accounts
