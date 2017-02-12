# Tips for switching from another DIY closed loop system to OpenAPS rig (or running both)

**Note:** This is a high level switchover cheat sheet, and will primarily discuss Loop and OpenAPS comparisons (but may be relevant for helping you understand the differences of OpenAPS from other DIY systems as well). For the purposes of this Loop-to-OpenAPS switchover cheat sheet, we’re going to assume a few things and therefore are not covering all the possible options for setting up an OpenAPS rig.  If you want to find out options that exist beyond the assumptions in this page, please refer back to the [main OpenAPS documentation pages](http://openaps.readthedocs.org/en/latest/).  In fact, please refer back to the main documentation sections anyway.  They really have a lot of information you’ll find helpful.  This page is more of a quick cheat sheet to help you get the high levels rather than a thorough setup guide (that’s what the OpenAPS documentation is for). There will be links throughout to the relevant OpenAPS documentation for more details when referenced.

### Other things you should know before starting:

* OpenAPS is similar to Loop (they’re both temp basal-based DIY closed loops), but different, even beyond the hardware. The algorithm (looping code) of OpenAPS is referred to as “[oref0](https://github.com/openaps/oref0/)”. You can look at that code (it’s written to be pretty straight forward - [see this example](https://github.com/openaps/oref0/blob/master/lib/determine-basal/determine-basal.js#L346), and the [glossary](http://openaps.readthedocs.io/en/latest/docs/Resources/glossary.html) may be helpful as well), but you can also read this plain language “[reference design](https://openaps.org/reference-design/)” that guides how OpenAPS was built. 
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

**Loop** is built using XCode app on an Apple computer.  The brains of the system sit on your iPhone.  The communications reside in the RileyLink, acting as a communicator between the iPhone and pump.  

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
* If you’re already on Nightscout, you just need to add openaps, like you did Loop, to enable the OpenAPS pill. You will also want to enable the OpenAPS forecast line(s) when you switch to an OpenAPS rig. 
* [See this page for more details about Nightscout and OpenAPS]( http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-1/index.html )

#### Installing oref0/”installing the loop”
* [Existing instructions for this (Phase 2 of OpenAPS documentation) are here.](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/index.html)

#### Personalizing your loop:
* [Phase 3 instructions are here.](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/index.html)

## The big differences between Loop and OpenAPS:

### Targets and algorithm differences

* Loop pulled targets from the app. OpenAPS pulls targets from the pump. Here’s [more detail on the data OpenAPS pulls and how it outputs data for you to understand the algorithm in action](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/Understand-determine-basal.html).
* Loop has temporary targets available by using the workout mode in the Loop app.  OpenAPS can have [multiple temp targets](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/advanced-features.html#eating-soon-and-activity-mode-temporary-targets) (i.e. Eating Soon and Workout, etc., and can be set via the Nightscout Care Portal if the rig is online, and via [IFTTT/Alexa/pebble/scheduled in advance/location based triggers](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/ifttt-integration.html).
* OpenAPS has no bolus momentum or safety guard that prevent boluses; but has other key safety settings (see below)

### “MaxIOB” and other safety settings

#### MaxIOB
* This is the max cap of how much "extra basal IOB" you want to allow the loop to add, above and beyond any regular basal and bolus IOB. In other words, the amount of high temp basal IOB your loop will be allowed to carry.  It is not the same as a max basal rate.  The default setting is 0, but if you’re coming from Loop, you’re probably ok starting with something other than 0 for maxIOB.  If you've been running successfully on Loop, you can probably put in something like half your max basal, or 1-2x your regularly scheduled basal.  So if your normal basal is 0.5U/hr, and your max basal that you let Loop give is 2U/hr, starting with a max IOB of 1U would allow OpenAPS to give the max basal for about 45 minutes before backing off once basal IOB hits 1U.
* After you get comfortable with how OpenAPS operates, you can easily [(here's how)](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#editing-your-preferences-json) update this number later. 

#### Other safety settings
* In addition to maxIOB, there are other basal-related safety caps built into OpenAPS to help protect you. These are to prevent people from getting into dangerous territory by setting excessively high max temp basals before understanding how the algorithm works. There are default values provided when the OpenAPS loop is first built; most people will never need to adjust these and are instead more likely to need to adjust other settings if they feel like they are “running into” or restricted by these safety caps. If you do want to adjust these default values, they are located in the same preferenes file as linked in the max-iob discussion above.  **NOTE:** OpenAPS's loop will use the LOWEST of the following three values to cap your temp basal rate, to make sure you don’t get a disproportionate amount of insulin.
 * **“Max Basal”** refers to the max basal set on the pump. (If you change this, it will be read in the next time your rig pulls pump settings.) 
 * **“Max Daily Safety Multiplier”** limits the temp basal set by OpenAPS loop to be a multiplier of your HIGHEST regularly-scheduled basal rate in the pump. The default setting for this multiplier is 3x...meaning no more than three times your maximum programmed basal rate for the day.  If someone tells you your basal is capped by the “3x max daily; 4x current” for safety caps, this is what they'd be referring to.
 * **“Max Current Basal Safety Multiplier”:** limits the temp basal set by OpenAPS loop to be a multiplier of your CURRENT regularly-scheduled basal rate in the pump.  The default setting for this multiplier is 4x...meaning no more than four times your current programmed basal rate.  
* Read about [all of the other optional safety settings here](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#understanding-your-preferences-json).

### Parents in particular may want to review the optional settings

* Parents should [read this blog post by Katie DiSimone for a parent's perspective about various pros/cons](http://seemycgm.com/2017/02/01/loop-vs-openaps/) for parents and kids evaluating DIY closed loop systems.
* **Override the high target with the low** ([see this explanation](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#override-high-target-with-low) for enabling this feature)
 * This makes it easier for secondary caregivers (like school nurses) to do conservative boluses at lunch/snack time, and allow the closed loop to pick up from there. The secondary caregiver can use the bolus wizard, which will correct down to the high end of the target; and setting this value in preferences to “true” allows the closed loop to target the low end of the target. Based on anecdotal reports from those using it, this feature sounds like it’s prevented a lot of (unintentional, diabetes is hard) overreacting by secondary caregivers when the closed loop can more easily deal with BG fluctuations.
* **Carb ratio adjustment ratio** ([see this explanation](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#carbratio-adjustmentratio) for enabling this feature)
 * If parents would prefer for secondary caregivers to bolus with a more conservative carb ratio, this can be set so the closed loop ultimately uses the correct carb amount for any needed additional calculations.

### Connectivity

* Loop works offline automatically; but may often need tuning and fixing if you go out of range and come back in range.
* OpenAPS needs some tricks to maximize connectivity (see below), but tends to resume working correctly once you come back into range without having to do anything special.
 * [Bluetooth tethering](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/bluetooth-tethering-edison.html) is one good option; as soon as you walk out of wifi range, it can automatically bluetooth tether to your phone to get connectivity
 * Mifi is one good option, if you travel and are without wifi networks, as it will provide a network without draining your iPhone battery.  Mifi systems typically use your cell phone data plan and needs cell data coverage (3g or 4g LTE).
 * You can add ([here's how](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/accessing-your-rig.html)) your school or work or as many locations as you have as “known” wifi networks so your rig will automatically connect to the wifi in these places.  You may want to contact the school before attempting to connect to their wifi network to see if you need any special accomodations in a 504 plan or IT department involvement to allow the rig to connect.
* OpenAPS will also default to always setting a temp basal (this can be turned off; [see description here](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#skip-neutral-temps)), which means it’ll be easier to look down at the pump and see if a temp basal is active to know that the loop has been working recently.
* The existing SkyLoop watchface for Pebble watches works seamlessly with OpenAPS looping.  No changes are needed if you plan to try OpenAPS or Loop.

### Carbs
* Loop requires carb and absorption time inputs through the app AND you must bolus from the Loop app or Apple watch.  Carbs can be read from the pump if they are entered by pump's bolus wizard, but boluses cannot be read from the pump by Loop app.
* OpenAPS: no absorption time entries required for meals. You bolus directly from the pump (either easy bolus button, or using bolus wizard), and carbs can be entered via the pump or via Nightscout Care Portal (or via Pebble, Alexa, etc. if you set that up).  Nightscout's bolus calculator can also serve to calculate a meal bolus as it tracks IOB from temp basals set by OpenAPS (you need to keep your basal profile current for accurate IOB tracking).

### Boluses and how OpenAPS gets pump history
* Loop users must bolus from Loop app or Apple watch. Loop tracks IOB through reservoir volume changes as the default, and will fallback to the pump's event history in the event reservoir readings aren't continuous.
* OpenAPS users bolus from the pump (either bolus wizard, or easy bolus button). OpenAPS will read the information about the bolus and other insulin activity based on the pump’s event history. 
 * The pros of this means you won’t have to do anything special for pump rewinds/primes/site changes. OpenAPS will also provide treatment notes on your Nightscout site showing pump events such as suspensions, bolus wizard changes, basal profile edits, and primes.
 * The downside of this means you DO need to set a temp basal to 0 unit/hour before suspending, so OpenAPS will know that you didn’t get insulin during the time of suspend (i.e. for shower or taking off the pump to swim, etc.)

### Multiple rigs
* Loop uses one RileyLink paired via bluetooth.  Typically users keep their RileyLink fairly close to the pump (like using a pants pocket) to help maintain communications. 
* If using a single OpenAPS Edison/explorer board rig, you should see significant range improvement compared to a RileyLink, and a phone does not need to be nearby (beyond whatever needed for your dexcom system).
* If you have multiple OpenAPS rigs, they're built to be polite to each other - so even if you had 2+ rigs in same room, they won't trip each other up. They “wait for silence” before issuing any commands to the pump.  By setting up multiple stationary rigs through a house, kids can move from room-to-room without carrying rigs because the rigs will pass-off comms as the kid moves in and out of the rig's range.  Stationary rigs will not need lipo batteries and can be plugged directly into the wall from the explorer board.

### Troubleshooting
* Loop - depending on environment and t1d's habits, RileyLink may require retuning to get Loop running again (automatically scheduled to retune at 14 minute intervals, but sometimes manual tunes are required). 
* OpenAPS - once setup and network connected, there is little required troubleshooting of rig. Most problems should self-resolve in <10 minutes, and if not a power button push usually solves the issue.  Also, parents can login to rig remotely to troubleshoot, reboot, etc. (when using the same wifi network as the rig) using an iPhone app.
  * Is it looping? (Check on pump to see if temp basal has been set)
  * What do the logs say? (Check the OpenAPS logs and/or the OpenAPS pill; it will probably say why it is stuck)
  * Reboot the rig (either via logging in, or using the power button on the rig)
  * Make sure it’s connected to wifi
  * Make sure you’re in range of the rig; CGM data is flowing; etc. 

## Running multiple kinds of DIY systems

* You can run different DIY systems (like Loop and OpenAPS) side-by-side, if you want to compare algorithms and how they behave.
* For those who like Loop's capabilities for bolusing from the phone, but don't want the requirement to enter carb absorption rates by meal, you can set Loop to "open loop" mode and use it for bolusing, and otherwise allow OpenAPS to be the primary closed loop to take advantage of the [Advanced Meal Assist (AMA)](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/advanced-features.html#advanced-meal-assist-or-ama) algorithm, [autosensitivity](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/advanced-features.html#auto-sensitivity-mode) to automatically adjust ISF, etc. However, see the following safety warnings below.
 * **SAFETY WARNING:** If you choose to keep a Loop rig running alongside OpenAPS, you MUST turn off Loop's ability to write to Nightscout. If you neglect to do this, Nightscout will display double entries of carbs and/or boluses and greatly confuse you in the future. To enter carbs, you can enter directly through Nightscout Care Portal; [use the variety of IFTTT configurations to enter carbs to Nightscout via your Pebble watch, Alexa, Siri, etc.](../walkthrough/phase-4/ifttt-integration.md); or enter using the pump's bolus wizard. Even if you're just using the Loop app in open loop mode, and enter carbs or bolus from the pump bolus wizard for use in OpenAPS, you need to turn off Loop's ability to write to Nightscout.  If you don't, Loop will read the boluses and carbs entered via the pump, upload them to Nightscout, and the duplicate entries will result in suboptimal post-meal decisions. You can either turn off Loop's ability to write to Nightscout, or simply close the app, but reopening the app for even a few minutes may still cause it to double enter to Nightscout if uploads are not disabled. If you do not plan to actively use Loop and DO want to bolus from the pump (via bolus wizard or easy bolus button) with OpenAPS, you should either disable Loop's Nightscout uploads, or plan to close the Loop app and not run them side-by-side. 
 * **Caution**: You may want to disable the Nightscout COB pill, especially if you are using multiple DIY closed loop systems, as it will likely cause confusion. You should look to the (DIY closed loop system you are using)'s pill for information about COB. This means looking in the OpenAPS or Loop pill for information about COB. 


---

#### Ready to get started with OpenAPS?

Click [here](http://openaps.readthedocs.org/en/latest/) to go to a high-level view of the OpenAPS docs

#### Where to get help with OpenAPS setup and maintenance: 
* See [this page](http://openaps.readthedocs.io/en/latest/docs/introduction/communication-support-channels.html) for various places for OpenAPS support; [the intend-to-bolus Gitter channel](https://gitter.im/nightscout/intend-to-bolus) is the best place for real-time troubleshooting assistance!
  * Don't hesitate to ask any question, any time. If it gets missed because there's a lot of activity, feel free to ask again!
* You’ll probably also want to make sure and join [the openaps-dev Google Group](https://groups.google.com/forum/#!forum/openaps-dev), where new features and tools are most commonly announced and shared via email, so you’ll know when there are new things available to try.
