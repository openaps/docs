# `mm-format-ns-profile`

## Help
mm-format-ns-profile: Format known pump data into Nightscout "profile".

Profile documents allow Nightscout to establish a common set of settings for
therapy, including the type of units used, the timezone, carb-ratios, active
basal profiles, insulin sensitivities, and BG targets.  This compiles the
separate pump reports into a single profile document for Nightscout.

Usage:
mm-format-ns-profile pump-settings carb-ratios active-basal-profile insulin-sensitivities bg-targets

Examples:
bewest@bewest-MacBookPro:~/Documents/openaps$ mm-format-ns-profile monitor/settings.json monitor/carb-ratios.json monitor/active-basal-profile.json monitor/insulin-sensitivities.json monitor/bg-targets.json  

