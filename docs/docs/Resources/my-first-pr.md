### Making your first PR (Pull Request)

At some point it will be suggested to you that you make a PR. PR is short for pull request.
It's actually not too hard to do one and it is a great way to contribute. This documentation is here because people like you made PRs.

* The general idea is to make edits and improvements to code or document by making a copy of the repository you'd like to change.
* Double-check that your edits look good to you on your copy.
* Make a few notes for what you did so people can understand why you made the change.
* Then do a pull request, which is to ask the administrators of the repository to pull your changes back into the appropriate branch of the main repository.
* They will do a quick review and merge your changes in, or comment if there are errors that need fixing first, or if it's a large enough change that it needs to go to another branch like dev for further work before being merged to master.

OK, let's get started. For our example we are going to make an edit to the openaps docs repository.  This does NOT need to be done in the linux environment.  This can be done on any Windows PC.

1. Go to https://github.com/openaps/docs and hit Fork in the upper right to make your own copy of the repository.
2. Github will automatically take you to your copy (notice in the address bar you are now in your own personal github directory)
3. Now we need to find the file we want to edit. Click through the directory structure until you find and are looking at the content of the file you want to change. (OR, from the "Read The Docs" link, look to the bottom right hand corner and find the box that says v: latest, for example. Click on that, and in the expanded box you should see a "View" and "Edit" option on Github. Click "Edit".)
4. Next, press the pencil icon in the upper right next to the trash can icon.
5. Make edits to the file as necessary.
6. Next we want to commit our changes. But first we should note what we changed and why. Scroll to the bottom of the page and type your comments in the text field that reads, "Add an optional extended description..." Be sure to include at least one line explaining the reason you made your changes.
7. Click the green "Commit changes" button.
8. Now look and make sure everything you changed looks like you meant it to (no typos, etc). If you see any problems, go back and edit again and save again.

We now have an improved file that we want to be pulled back into the openaps/docs repository at https://github.com/openaps/docs

1. Go to https://github.com/[YOUR_GITHUB_USERNAME]/docs
 * Or you can go to https://github.com and then click on "docs" in the "Your repositories" section in the lower right.  Both methods will get you to the right place.
2. Click the "New pull request" button
3. Under the Comparing Changes heading, click "compare across forks". 
4. Set up the the branches you are targeting. The easiest way of thinking about the branch range is this: the base branch is where you think changes should be applied, the head branch is what you would like to be applied.
5. So, choose the base fork as openaps/docs and then the base as master (or whichever branch you edited). The head fork is going to be <i>youraccount</i>/docs and the base as master (unless this is a large change that needs to go to dev first).
![Pull Request](../Images/Pull_Request.png)
6. It should show the list of changes you made. If not, you did something wrong so stop here and ask for help. If the list looks like your changes then put a note in there to what the overarching reason for the changes are (in your case you only made one, but you could have made a bunch). Click the green "Create pull request" button.
7. Type a title for your pull request, and then type a description in the "Write" text field. Click the green "Create pull request" button.

Your entry will now be in a list of PR's that the team will review and potentially give feedback on before committing to the main documentation for openaps!

Congrats, you made your first contribution!

PS, your fork will still be sitting on your own personal github account. After you get a notification that your PR has been merged, you can delete your branch/fork if you are done with it. In the future, be sure to pull a fresh copy from github.com/openaps/docs before making new edits.
