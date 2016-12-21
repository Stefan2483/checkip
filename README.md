# checkip
A script that will check your ip every minute and will send a push notification if this changes (with Pushover API)

You will need to have a Pushover account created and a TOKEN and a USER to configure the script. Also internet connection needed ;)

INSTALLATION:

Modify the checkip.sh script and add TOKEN and USER save and give proper permission to the script with chmod
Add script to crontab:

#* * * * * /path_to_script/check.sh 2>&1
