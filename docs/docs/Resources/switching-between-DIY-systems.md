# Tips for switching from another DIY closed loop system to OpenAPS rig (or running both)

**Note:** This is a high level switchover cheat sheet, and will primarily discuss Loop and OpenAPS comparisons (but may be relevant for helping you understand the differences of OpenAPS from other DIY systems as well). For the purposes of this Loop-to-OpenAPS switchover cheat sheet, we’re going to assume a few things and therefore are not covering all the possible options for setting up an OpenAPS rig.  If you want to find out options that exist beyond the assumptions in this page, please refer back to the [main OpenAPS documentation pages](http://openaps.readthedocs.org/en/latest/).  In fact, please refer back to the main documentation sections anyway.  It really has a lot of information you’ll find helpful.  This page is more of a quick cheat sheet to help you get the high levels rather than a thorough setup guide (that’s what the OpenAPS documentation is for). There will be links throughout to the relevant OpenAPS documentation for more details when referenced.

### Other things you should know before starting:

* OpenAPS is similar to Loop (they’re both temp basal-based DIY closed loops), but different, even beyond the hardware. The algorithm of OpenAPS is referred to as “[oref0](https://github.com/openaps/oref0/)”. You can look at that code (it’s written to be pretty straight forward - [see this example](https://github.com/openaps/oref0/blob/master/lib/determine-basal/determine-basal.js#L346), and the [glossary](http://openaps.readthedocs.io/en/latest/docs/Resources/glossary.html) may be helpful as well), but you can also read this plain language “[reference design](https://openaps.org/reference-design/)” that guides how OpenAPS was built. 
* _Paying it forward_: OpenAPS is part of the #WeAreNotWaiting movement...built 100% by volunteers...and that also includes the documentation! If you spot something in the documentation that needs fixing or improving, please flag it and/or submit an edit yourself to fix the documentation then and there! 
  * This is called “making a pull request” or “making a PR”, which presents your edit for someone to review, approve, and update the overall documentation - which means everyone can use your fix moving forward! We all have a responsibility to keep adding to and improving the documentation. You can find [a guide to creating a pull request/submitting your edit here](http://openaps.readthedocs.io/en/latest/docs/Resources/my-first-pr.html), and if you ask, we’re happy to help answer questions as you do your first pull request. 
* **You can do this**.
  * One user estimates setting up OpenAPS takes only 20 mouse clicks; 29 copy and paste lines of code; 10 entries of passwords or logins; and probably about 15-20 random small entries at prompts (like your NS site address or your email address or wifi addresses). So if you can copy and paste, you’ll be able to do this!

---

If you’re coming to try OpenAPS from a Loop system, there’s going to be some pretty obvious differences.  And it starts with “building” the system.  

### Main Hardware Differences:

<table>
  <thead>
    <tr>
      <th></th>
      <th>Built using</th>
      <th>Brains sit</th>
      <th>Communications reside</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Loop<sup></th>
      <td>xCode on an Apple computer</td>
      <td>on your iPhone</td>
      <td>on the Rileylink</td>
    </tr>
    <tr>
      <th>OpenAPS</th>
      <td>any computer</td>
      <td>on the “rig” (can be multiple kinds of rigs)</td>
      <td>on the rig (usually with a built-in radio stick)</td>
    </tr>

  </tbody>
</table>

**Loop** is built using XCode app on an Apple computer.  The brains of the system sit on your iPhone.  The communications reside in the RileyLink.  

**OpenAPS** is built using “script” commands (can be wide variety of computers that are used).  The brains and communications of the system reside on a “rig” which acts as a mini-computer.  

### Assumptions for this Cheat Sheet Guide

1.  Using an explorer board and Edison
2.  Using an Apple computer
3.  Using a Loop-compatible Medtronic pump (note - OpenAPS can actually use an additional set of pumps, the x12 series, although it requires one extra step not documented here. See this page in OpenAPS docs for all compatible pumps.)

### High Level Recommended Rig parts list

See [this short list for what to buy for an Edison/Explorer Board OpenAPS rig.](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/edison-explorer-board-Mac.html#high-level-recommended-rig-parts-list )

### Getting started on OpenAPS - the setup links

#### Building your Rig: 
* [Start here for the Mac version]( http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/edison-explorer-board-Mac.html ) (with pictures!)
* ([Reference this page](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/setup-edison.html ) if you’re using any other type of computer to build.)

#### Flashing your rig:
* [For Mac](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/edison-explorer-board-Mac.html#preparing-flashing-the-edison) (with pictures!)
* ([For other computers.](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/setup-edison.html))

#### Nightscout
* We highly recommend Nightscout. Go to [nightscout.info](http://nightscout.info) if you have not yet setup
* If you’re already on Nightscout, you just need to add openaps like you did loop to enable the OpenAPS pill. You will also want to enable the OpenAPS forecast line(s) when you switch to an OpenAPS rig. 
* [See this page for more details about Nightscout and OpenAPS]( http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-1/index.html )

#### Installing oref0/”installing the loop”
* [Existing instructions for this (Phase 2 of OpenAPS documentation) are here.](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/index.html)

#### Personalizing your loop:
* [Phase 3 instructions are here.](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/index.html)

## The big differences between Loop and OpenAPS:

### Targets and algorithm differences

* Loop pulled targets from the app. OpenAPS pulls targets from the pump. Here’s [more detail on the data OpenAPS pulls and how it outputs data for you to understand the algorithm in action](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/Understand-determine-basal.html).
* OpenAPS can have [multiple temp targets](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/advanced-features.html#eating-soon-and-activity-mode-temporary-targets) (i.e. Eating Soon and Workout, etc., and can be set via the Nightscout Care Portal if the rig is online, and via [IFTTT/Alexa/pebble/scheduled in advance/location based triggers](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/ifttt-integration.html).
* OpenAPS has no bolus momentum or safety guard that prevents boluses; but has other key safety settings (see below)

### “MaxIOB” and other safety settings

#### MaxIOB
* This is the max cap of how much you want to allow the rig to add in additional basal. It defaults to 0, but if you’re coming from Loop you’re probably ok starting with something other than 0 for maxIOB.  If you've been running successfully on Loop, you can probably put in something like half your max basal, or 1-2x your regularly scheduled basal.  So if your normal basal is 0.5U/hr, and your max basal that you let Loop give is 2U/hr, starting with a max IOB of 1U would allow OpenAPS to give the max basal for about 45 minutes before backing off once basal IOB hits 1U.
* After you get comfortable with how OpenAPS operates, you can easily [(here's how)](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#editing-your-preferences-json) update this number later. 

#### Other safety settings
* In addition to maxIOB, there are other safety caps built into OpenAPS to help protect you. **NOTE:** OpenAPS will use the LOWEST of the following three values to cap your basal rates, to make sure you don’t get a disproportionate amount of insulin.
 * **“Max Basal”** refers to the max basal set on the pump. (If you change this, it will be read in the next time your rig pulls pump settings.) 
 * **“Max Daily Safety Multiplier”** limit your basals to be 3x (in this example, which is the default and works for most people) your biggest basal rate stored in the pump. If someone tells you your basal is capped by the “3x max daily; 4x current” for safety caps, this is what it is. This is built into the OpenAPS code.
 * **“Max Current Basal Safety Multiplier”:** This is the other half of the key OpenAPS safety caps, and the other half of “3x max daily; 4x current” of the safety caps. This means your basal, regardless of max basal set on your pump, cannot be any higher than this number times the current level of your basal. This is to prevent people from getting into dangerous territory by setting excessively high max basals before understanding how the algorithm works. Again, the default is 4x; most people will never need to adjust this and are instead more likely to need to adjust other settings if they feel like they are “running into” this safety cap. This is built into the OpenAPS code.
* Read about [all of the other optional safety settings here](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#understanding-your-preferences-json).

### Parents in particular may want to review the optional settings

* Parents should [read this blog post by Katie DiSimone for a parent's perspective about various pros/cons](http://seemycgm.com/2017/02/01/loop-vs-openaps/) for parents and kids evaluating DIY closed loop systems
* **Override the high target with the low** ([see this explanation](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#override-high-target-with-low) for enabling this feature)
 * This makes it easier for secondary caregivers (like school nurses) to do conservative boluses at lunch/snack time, and allow the closed loop to pick up from there. The secondary caregiver can use the bolus wizard, which will correct down to the high end of the target; and setting this value in preferences to “true” allows the closed loop to target the low end of the target. Based on anecdotal reports from those using it, this feature sounds like it’s prevented a lot of (unintentional, diabetes is hard) overreacting by secondary caregivers when the closed loop can more easily deal with BG fluctuations.
* **Carb ratio adjustment ratio** ([see this explanation](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#carbratio-adjustmentratio) for enabling this feature)
 * If parents would prefer for secondary caregivers to bolus with a more conservative carb ratio, this can be set so the closed loop ultimately uses the correct carb amount for any needed additional calculations.

### Connectivity

* Loop works offline automatically; but often needs tuning and fixing if you go out of range and come back in range.
* OpenAPS needs some tricks to maximize connectivity (see below), but tends to resume working correctly once you come back into range without having to do anything special.
 * [Bluetooth tethering](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/bluetooth-tethering-edison.html) is one good option; as soon as you walk out of wifi range, it can automatically bluetooth tether to your phone to get connectivity
 * Mifi is one good option, to always keep if you travel and hit dead spots
 * You can add ([here's how](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/accessing-your-rig.html)) your school or work or as many locations as you have as “known” wifi networks so your rig will automatically connect to the wifi in these places.
* OpenAPS will also default to always setting a temp basal (this can be turned off; [see description here](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#skip-neutral-temps)), which means it’ll be easier to look down at the pump and see if a temp basal is active to know that the loop has been working recently.

### Carbs
* Loop requires carb input and absorption setting in the app AND you must bolus from the phone.
* OpenAPS: no absorption setting per meal required. You can bolus from the pump (either easy bolus button, or using bolus wizard), and carbs can be entered via the pump or via Nightscout Care Portal (or via Pebble, Alexa, etc. if you set that up)

### Boluses and how OpenAPS gets pump history
* Loop users must bolus from phone or apple watch. You can tell Loop to calculate IOB based on event history, or reservoir volume.
* OpenAPS users bolus from the pump (either bolus wizard, or easy bolus button). OpenAPS will read the information about the bolus and other insulin activity based on the pump’s event history. 
 * The pros of this means you won’t have to do anything special for pump rewinds/primes/site changes.
 * The downside of this means you DO need to temp to 0 before suspending, so OpenAPS will know that you didn’t get insulin during the time of suspend (i.e. for shower or taking off the pump to swim, etc.)

### Multiple rigs
* Loop mainly works with one RileyLink
* OpenAPS you can have multiple rigs. For Edison/explorer board rigs, you should see significant range improvement compared to a RileyLink, and a phone does not need to be nearby.
* If you have multiple OpenAPS rigs, they're built to be polite to each other - so even if you had 2+ rigs in same room, they won't trip each other up. They “wait for silence” before issuing any commands to the pump.

### Troubleshooting
* Loop - often requires tuning with rileylink.
* OpenAPS - once set up and has connectivity, less often babysitting of rig needed. Most problem self-resolve in <10 minutes. Also, parents can log in to rig remotely to troubleshoot, reboot, etc.
 * Is it looping? (Check on pump to see if temp set)
 * What do the logs say? (Check the OpenAPS logs and/or the OpenAPS pill; it will probably say why it is stuck)
 * Reboot the rig (either via ssh’ing in, or using the power button on the rig)
 * Make sure it’s connected to wifi
 * Make sure you’re in range of the rig; CGM data is flowing; etc. 

## Running multiple kinds of DIY systems
* You can run different DIY systems (like Loop and OpenAPS) side by side, if you want to compare algorithms and how they behave.
* **Tip:** For those who like Loop's capabilities for bolusing from the phone, but don't want the requirement to enter carb absorption rates by meal, you can set Loop to "open loop" mode and use it for bolusing, and otherwise allow OpenAPS to be the primary closed loop to take advantage of the [Advanced Meal Assist (AMA)](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/advanced-features.html#advanced-meal-assist-or-ama) algorithm, [autosensitivity](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/advanced-features.html#auto-sensitivity-mode) to automatically adjust ISF, etc.  With Loop in "open loop" mode, you can optionally use the Loop interface to enter carbs and upload them to Nightscout where OpenAPS can retrieve them, or enter carbs into Nightscout any [other way](../walkthrough/phase-4/ifttt-integration.md).

---

#### Ready to get started with OpenAPS?

Click [here](http://openaps.readthedocs.org/en/latest/) to go to a high-level view of the OpenAPS docs

#### Where to get help with OpenAPS setup and maintenance: 
* See [this page](http://openaps.readthedocs.io/en/latest/docs/introduction/communication-support-channels.html) for various places for OpenAPS support; [the intend-to-bolus Gitter channel](https://gitter.im/nightscout/intend-to-bolus) is the best place for real-time troubleshooting assistance!
  * Don't hesitate to ask any question, any time. If it gets missed because there's a lot of activity, feel free to ask again!
* You’ll probably also want to make sure and join [the openaps-dev Google Group](https://groups.google.com/forum/#!forum/openaps-dev), where new features and tools are most commonly announced and shared via email, so you’ll know when there are new things available to try.
