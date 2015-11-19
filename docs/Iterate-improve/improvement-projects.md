# Iterating and Improving

At this point, you're probably familiar enough to understand some of the limitations or usability frustrations of this DIY system. (You get one point for having your own complaint, one point for hearing Dana complain about "frying a Pi", and one point to hear someone talking about using an Edison or a "RileyLink" or another tool to cut down on the size of their openAPS implementation.) The main point here is that this is still not a set-and-forget system, and there's lots to improve on. This page will serve as a landing page to point out to various other projects, or notes on how people might be improving the system.

### Using other pumps

There's a group trying to figure out the Omnipod communication. There is an [omnidocs repository](https://github.com/openaps/omnidocs) that they may use to share their work, but they're more frequently chatting in a Slack channel. Email dana@openaps.org if you'd like to join that channel and check in on their progress.

### Using other devices instead of a raspberry pi

* RileyLink - check out this [repo](https://github.com/ps2/rileylink) or join the [gitter channel](https://gitter.im/ps2/rileylink). RileyLink is custom designed Bluetooth Smart (BLE) to 916MHz module. It can be used to bridge any BLE capable smartphone to the world of 916Mhz based devices. This project is focused on talking to Medtronic insulin pumps and sensors.

* Edison - There is also work to see if an Edison can be used instead of a Raspberry Pi.

* HAPP - Tim Omer has put together an Android-based app that is a manual temp-basal recommendation engine, based off the OpenAPS reference design. It's not a closed loop, but his work could be used to create an Android-driven loop implementation. [Check out HAPP on Github here](https://github.com/timomer/happ). 
