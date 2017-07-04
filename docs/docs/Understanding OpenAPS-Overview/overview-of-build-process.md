# How you will build your rig

The OpenAPS setup process can be broken up into several parts:

* Acquiring the hardware and information you'll need to build your OpenAPS system
* Testing your pump and settings
* Preparing your Edison (installing jubilinux, wifi networks, and other information)
* Setting up Nightscout
* Building your loop
* Adding in your personal preferences and features

As with all things new, there is a little bit of a learning curve to building your first OpenAPS rig.  Read slowly, double-check your spelling and make sure you don't skip steps.  If you get stuck or are unsure, you can use the screenshots to compare how the resulting screens should look.  You can also post to Gitter or Facebook to ask for specific if you find yourself stuck.

Over time, you may also choose to enable advanced features or update your rig, as more features and algorithm improvements become available. You should make sure to stay plugged in to key channels (like openaps-dev google group; Looped on Facebook; and on Twitter by following @OpenAPS) so you can be aware when updates become available. You should also make sure to tell us when you’ve closed your loop, which includes notes on how to join the safety-critical announcement list in case we need to alert you to any safety-related changes or updates.

## What you’ll see in this guide

* Wherever you see text that is formatted `like this`, it is a code snippet. You should copy and paste instead of attempting to type this out; this will save you debugging time for finding your typos.

* Wherever there are `<bracketed_components>`, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `myopenaps` as your  `<myopenaps>` directory, you must use `myopenaps` every time you see `<myopenaps>`. Choose carefully when naming things so it’s easy to remember. Do not include the `< >` brackets in your name.
