# Building preflight and other safety checks

Before moving on to consolidating all of these capabilities into a single alias, it is a good idea to add some error checking.

* There are several potential issues that may adversely affect operation of the system. For example, RF communication with the pump may be compromised. It has also been observed that the CareLink USB stick may become unresponsive or "dead", requiring a reset of the USB ports. Furthermore, in general, the system should not act on stale data. Let's look at some approaches you may consider to address these issues.

Ensuring that your openaps implementation can't act on stale data could be done by deleting all of the report files in the `monitor` directory before the reports are refreshed. You may simply use `rm -f` bash command, which removes file(s), while ignoring cases when the file(s) do not exist. If a refresh fails, the data required for subsequent commands will be missing, and they will fail to run. For example, here is an alias that runs the required bash commands:

```
openaps alias add gather '! bash -c "rm -f monitor/*; openaps get-profile && openaps monitor-cgm && openaps monitor-pump && openaps report invoke monitor/iob.json"'
```

This example also shows how an alias can be constructed using bash commands. First, all files in `monitor` directory are deleted. Then, aliases are executed to generate the required reports. A similar approach can be used to remove any old `suggested.json` output before generating a new one, and to check and make sure oref0 is recommending a temp basal before trying to set one on the pump. You may want to make sure that your `enact` alias includes these provisions.

It's also worthwhile to do a "preflight" check that verifies a pump is in communication range and that the pump stick is functional before trying anything else. The oref0 `mm-stick` command can be used to check the status of the MM CareLink stick. In particular, `mm-stick warmup` scans the USB port and exits with a zero code on success, and non-zero otherwise. Therefore,

```
$ mm-stick warmup || echo FAIL
```

will output "FAIL" if the stick is unresponsive or disconnected. You may simply disconnect the stick and give this a try. If the stick is connected but dead, `oref0-reset-usb` command can be used to reset the USB ports

```
$ sudo oref0-reset-usb
```

Beware, this command power cycles all USB ports, so you will temporarily loose connection to a WiFi stick and any other connected USB device.

Checking for RF connectivity with the pump can be performed by attempting a simple pump command or report and by examining the output. For example,

```
$ openaps report invoke monitor/clock.json
```

returns the current pump time stamp, such as "2016-01-09T10:47:56", if the system is able to communicate with the pump, or errors otherwise. Removing previously generated clock.json and checking for presence of "T" in the newly created clock.json could be used to verify connectivity with the pump.

Collecting all the error checking, a `preflight` alias could be defined as follows:

```
$ openaps alias add preflight '! bash -c "rm -f monitor/clock.json && openaps report invoke monitor/clock.json 2>/dev/null && grep -q T monitor/clock.json && echo PREFLIGHT OK || (mm-stick warmup || sudo oref0-reset-usb; echo PREFLIGHT FAIL; sleep 120; exit 1)"'
```

In this `preflight` example, a wait period of 120 seconds is added using `sleep` bash command if the USB ports have been reset in an attempt to revive the MM CareLink stick. This `preflight` example also shows how bash commands can be chained together with the bash && ("and") or || ("or") operators to execute different subsequent commands depending on the output code of a previous command (interpreted as "true" or "false").

You may experiment using `openaps preflight` under different conditions, e.g. with the CareLink stick connected or not, or with the pump close enough or too far away from the stick.

At this point you are in position to put all the required reports and actions into a single alias.
