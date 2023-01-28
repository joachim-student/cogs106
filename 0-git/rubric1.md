# Rubric for Assignment 1

Assignment 1 had these instructions:

> Write and run a shell script: update-version.sh 
>
> The script should do these things: 
>
> 1. Ensure that the local repository is up to date with the one on github.com 
> 2. Saves the current date and time in a file called version 
> 3. Updates your github repository with the new file

One of multiple possible solutions looks like this:

```bash
#!/bin/bash

# Ensure that the local repository is up to date with the one on github.com
git pull origin main

# Save the current date and time in a file called version
date > version

# Update the github repository with the new file
git add version
git commit -m "updated version file"
git push origin main
```

In order to run the script you must first make it executable by running `chmod +x update-version.sh` and then call it using `./update-version.sh`. Also, you need to be in the same directory where the script is located and you need to have git properly configured both on the local machine and on github.

Note that the commands in this script will push to the remote repository named "origin" and the branch "main". If your repository uses different settings, you will need to adjust the script accordingly.

## Line by line

```bash
#!/bin/bash
```

This line specifies the shell interpreter that will be used to run the script (in this case, the Bourne Again SHell `bash`).

```bash
git pull origin main
```

This line uses the git command to pull (i.e., download and merge) the latest changes from the remote repository named "origin" and the branch named "main". This ensures that the local repository is up to date with the one on Github.

```bash
date > version
```

This line uses the date command to get the current date and time and "pipe" that to a file called "version". The `>` operator redirects the output of the echo command to the "version" file, replacing any existing content in the file (there is also the `>>` pipe, which would not overwrite but amend the file).

```bash
git add version
```

This line uses the git command to stage the "version" file, which means that it will be included in the next commit.

```bash
git commit -m "updated version file"
```

This line uses the git command to create a new commit with the changes made in the previous step. The -m option allows you to specify a commit message, in this case, "updated version file".

```bash
git push origin main
```

This line uses the git command to push the new commit to the remote repository named "origin" and the branch named "main". This updates the Github repository with the new "version" file.

## Grading

This is our first assignment, so we'll grade with a gentle touch.  If your script runs without error and contains the `git pull`, then something to update the "version" file, and then `git add`, `git commit`, and `git push`, you deserve an A+ because you rock.

Miss any one of those and you get a regular A on this assignment.

