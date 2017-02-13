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

PS, your fork and branch will still be sitting on your own personal GitHub account. After you get a notification that your PR has been merged, you can delete your branch/fork if you are done with it. For future edits, if you follow this procedure the edits will always start with an updated version of the openaps repositories.  If you choose to use another method to start a PR request (e.g., editing starting from your forked repo's master branch as the starting point), you will need to ensure your repo is up-to-date by performing a "compare" first and merging in any updates that have happened since you last updated your fork.  Since people tend to forget to update their repos, we recommend using the PR process outlined above until you get familiar with performing "compares".
