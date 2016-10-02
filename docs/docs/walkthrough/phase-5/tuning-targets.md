# Tuning your targets

After you adjust your max iob and go beyond low glucose suspend mode, run the system overnight under close observation with the following considerations around targets:

* You should start with high targets and a good safety margin. For example, you might start with your target at 150 to see how the system does. OpenAPS has a "min" target floor which prevents you from setting it below 80.

* Before adjusting your target, you should have at least one night with zero low alarms (in three days) before considering dropping the max target below 160.

* Each time you adjust your target, it should be no more than 5-10 points at a time, again observing the outcomes over a few days.

If you are going low overnight for three+ days, your "min" target may need to be raised.

After you tune your targets, min can be set to be equivalent of max. However, when you first start, start with a 10-point range (i.e. 150-160).
