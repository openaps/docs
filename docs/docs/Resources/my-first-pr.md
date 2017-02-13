### Making your first PR (pull request)

At some point it will be suggested that you make a PR. PR is short for pull request, and it is a way of adding or editing information stored in GitHub.  It's actually not too hard to do one and it is a great way to contribute. This documentation is here because people like you made PRs.  Don't worry about making a mistake or somehow editing the wrong documents.  There is always a review process before changes are merged into the "formal" openaps repositories.  You can't mess up the originals through any accidents in the PR process.  The general process is:

* Make edits and improvements to code or documentation by editing the existing content.
* Double-check that your edits look good to you.
* Make a few notes of what's changed so people may understand the edits.
* Create a pull request, which asks the administrators to use your changes.
* They will do a review and either (1)merge your changes, (2)comment back to you about your changes, or (3)start a new document with your changes.

OK, let's get started. For our example we are going to make an edit to the openaps docs.  This does NOT need to be done in the linux environment.  This can be done on any Windows PC.

1. Go to https://github.com/openaps/docs and hit Fork in the upper right to make your own copy of the repository.

![Fork repo](https://github.com/Kdisimone/docs/blob/pr-update/docs/docs/Images/PR0.png)

2. Go to http://openaps.readthedocs.io/en/latest/docs/introduction/index.html or similar and navigate to the page you want to edit.

![RTD io](https://github.com/Kdisimone/docs/blob/pr-update/docs/docs/Images/PR1.png)

3. Click on the black and green box at page bottom right with the word "v: latest" or similar. In the pop up window that appears click the word "edit". An alternative is to navigate the directory tree from https://github.com/openaps/docs to the page you want to edit and press the pencil icon in the upper right next to the trash can icon. 

![edit doc](https://github.com/Kdisimone/docs/blob/pr-update/docs/docs/Images/PR2.png)

4.  Either of the options in Step 3 will create a new branch in YOUR repository where your edits will be saved.  Make your edits to the file.

![Edit branch](https://github.com/Kdisimone/docs/blob/pr-update/docs/docs/Images/PR3.png)

5. You have been working in the "<>Edit file" tab. Select the "Preview changes" tab for a fresh look to make sure everything you changed looks like you meant it to (typpos sic.). If you see a needed improvement, go back to the edit tab to make more improvements.

![preview mode](https://github.com/Kdisimone/docs/blob/pr-update/docs/docs/Images/PR5.png)

6. When you have finsihed your edits, scroll to the bottom of the page.  In the box at the bottom, provide your comments in the text field that reads, "Add an optional extended description...". The default title has the file name. Try to include a sentence explaining the __reason__ for the change. Relating the reason helps reviewers understand what you are attempting to do with the PR.

![commit comments](https://github.com/Kdisimone/docs/blob/pr-update/docs/docs/Images/PR4.png)

7. Click the green "Propose file changes" or "Commit changes" button. In the page that appears click "Create Pull Request" and again in the next page click "Create Pull Request".


8. That completes the opening of a pull request, PR. It has a number assigned to it located after the title and a hash mark. Return to this page to check for feedback (or, if you have Github notifications emailed to you, you will get emails notifying you of any activity on the pull request. The edit will now be in a list of PR's that the team will review and potentially give feedback on before committing to the main documentation for openaps!

Congrats, you made your first contribution!

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



PS, your fork will still be sitting on your own personal github account. After you get a notification that your PR has been merged, you can delete your branch/fork if you are done with it. In the future, be sure to pull a fresh copy from github.com/openaps/docs before making new edits.
