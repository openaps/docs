# Note about recovery from Camping Mode/Offline mode

### Note for Medtronic CGM users going back online
If you have been running offline for a significant amount of time, and use a Medtronic CGM, you may need to run

```
openaps first-upload
```
from inside your openAPS directory, before your loop will start updating correctly to your nightscout site.
