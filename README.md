# UCSD ACSWeb Site Deploy Github Action

Deploy your personal or organization website to an acsweb.ucsd.edu account, all on Github! 


**Warning before you use this**: If you have any files in your ascsweb web account under `public_html`, it will be deleted if you use this action! Make sure to backup anything you have before running this action.  

## Inputs

### `username`

**Required** The username of the acsweb account that you want to deploy to.

### `password`

**Required** The password to your acsweb account listed above.

WARNING: Make sure you make a [Github secret](https://help.github.com/en/github/automating-your-workflow-with-github-actions/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) for this field! Do NOT put your raw password here!

### `local_dir`

**Optional** A specific directory inside of your git repo that you want to sync. Default "./" (the root of your git repo).

NOTE: If you define this, make sure it ends in a `/` ! If not, the `rsync` command may deploy the directory into the site, and not just the contents of the directory. 

### `remote_dir`

**Optional** A specfic directory in your acsweb account that you want to deploy to. For example, if you want to deploy to `org.ucsd.edu/events`, then have `remote_dir: "./events/"`. We haven't tested this yet, so if you run into any problems create an issue above and we can work it out!

## Example usage

### Minimal setup - http://acsweb.ucsd.edu/~asg017

The repo is [here](https://github.com/asg017/my-acsweb-site), and the site is live [here](http://acsweb.ucsd.edu/~asg017/). This is the most minimal example of this Github action that you could do. If you want to sync all files in a repository WITHOUT any preprocessng (e.g. building a React app, Jekyll, etc.), then this is what you want!

#### `.github/workflows/main.yml`

```yml
name: Deploy

# Only deploy when pushing to master (and not other branches)
on: 
  push:
    branches: 
      - master

jobs:
  build:

    runs-on: ubuntu-latest
    
    # Checkout the repo, then deploy all files to the asg017 account
    steps:
    - uses: actions/checkout@v1
    - uses: asg017/actions/acsweb@master
      with:
        username: asg017
        password: "${{secrets.password}}"
```


### A React app - http://eceusc.ucsd.edu

The repo is [here](https://github.com/eceusc/eceusc.ucsd.edu), and the live site exsts [here](http://eceusc.ucsd.edu/). 

This site is a little more complex than the example above. The repo contains a [React app](https://reactjs.org/), not a raw website. So, we first have to compile the React app down to normal `.html` and `.js` files, and then only sync those compiled files to our site.

The final [workflow](https://github.com/eceusc/eceusc.ucsd.edu/blob/master/.github/workflows/main.yml) looks like this:

```
name: Deploy to eceusc.ucsd.edu

on:
  push:
    branches: 
      - master

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    # Checkout the repository
    - uses: actions/checkout@v1
    
    # Setup node (used to download the React app's dependencies and to build the app)
    - uses: actions/setup-node@v1.1.0
    
    # Install the React app's dependencies
    - run: npm install 
    
    # Build the React app itself
    - run: npm run build
    
    # Deploy the compiled result to the eceusc acsweb account
    - uses: asg017/actions/acsweb@master
      with:
        username: eceusc
        password: "${{secrets.ACSWEB_PASSWORD}}"
        
        # `npm run build` above compiles the React app to normal `.html` and `.js` files inside of
        # the `build` directory. So, let's just sync those files
        local_dir: "./build/"
```

## Caveats

### Hidden files are not synced

If the repo/directory that you're syncing has any hidden files, it will NOT be synced. This is because you probably don't want to sync your `.git` folder to a public facing website. So, this does not sync any hidden files to your acsweb site.

If you do want this as a feature, feel free to open a Github issue above and we can work it out!

### Host Checking is turned off

This action doesn't check the host before deploying your site, because of how Github Actions are ran. If you're just building a personal site and don't care too much about this, you probably don't have worry about this. If you're building something crazier and really care about security, then definitely make sure you understand this before using. But TBH since you're already making your site "public" by putting it on acsweb, the scope for this being abused is pretty low, I beleive. 
