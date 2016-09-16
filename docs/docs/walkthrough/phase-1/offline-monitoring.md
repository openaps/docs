# Offline monitoring

## Pancreabble

Nightscout is the default way to visualize what your loop is doing, but your OpenAPS rig must be connected to the internet to upload its status. [Pancreabble] is a way to monitor your loop _locally_, by pairing a Pebble smartwatch directly with the Raspberry Pi or Intel Edison.

In other words, whereas the default setup looks like this:

```
Raspberry Pi/Intel Edison -> network -> Nightscout server -> network -> smartphone
                                                                     |
                                                                     -> laptop
                                                                     |
                                                                     -> Pebble watch
```

And by default, your Pebble is paired thus:

```
               smartphone -> Bluetooth -> Pebble watch
```

With Pancreabble, the setup looks like this:

```
Raspberry Pi/Intel Edison -> Bluetooth -> Pebble watch
```

Using a Pebble watch can be especially helpful during the "open loop" phase: you can send the loop's recommendations directly to your wrist, making it easy to evaluate the decisions it would make in different contexts during the day (before/after eating, when active, etc.).

See [Pancreabble] for setup instructions.

[Pancreabble]: https://github.com/mddub/pancreabble
