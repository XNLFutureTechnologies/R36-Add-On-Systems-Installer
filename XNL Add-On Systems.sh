#!/bin/bash
# =================================================================================
# XNL Future Technologies R36 Add-On Systems Installer
# This script is intended/developed for R36S/R36H Running on ArkOS, but I THINK
# it should also work on other systems using ArkOS
#
# This Script: Additional Systems Installer
# Purpose: This program can install additional "systems" in your EmulationStation menu.
# With my script you can currently install the following 'systems':
# XNL Ft
# Apps
#
# Systems Explanation:
# 	XNL Ft: 
#   will create a folder XNL Ft on your ROMS card (or folder if you are using one
# 	SD card). And it will add the 'system' XNL Ft to your Emulation station as availible
# 	system. In the XNL Ft folder (in your ROMS folder) you can then add .sh scripts which
# 	can be started directly from the main menu. I use these for all the tools and applications
# 	I created myself (so basically a "XNL Future Technologies Apps System"
# 	Basically this one does the same as the Apps 'System' (bellow) but it's just sorted differently
#
# Systems Explanation:
#   Apps: 
#   will create a folder Apps on your ROMS card (or folder if you are using one
#   SD card). And it will add the 'system' Apps to your Emulation station as availible
#   system. In the Apps folder (in your ROMS folder) you can then add .sh scripts which
#   can be started directly from the main menu. I use this one for other more 'common applications'
#   and other tools I have installed, added or whatever. 
#   Basically this one does the same as the XNL Ft 'System' but it's just sorted differently
#
# BACK UP YOUR ORIGINAL Emulation Station's configuration file!
# This program has an automatic backup function build in which will make a backup of your
# es_systems.cfg on your SD card (ALWAYS SD-Card1) in the folder: /roms/backup/XNL/
#
# It will copy your original es_config.cfg into this folder and add the current version number
# of ArkOS to the filename. So if you run this program after you've updated ArkOS it will
# copy it again. But this could also mean that it will then backup the cfg file WITH the 
# add-on systems already in it (if you ran this tool already before updating).
# The backup files will look something like this: /roms/backup/XNL/es_system.cfg.12242024
# Where the number at the end will ofcourse be your current ArkOS version.
#
# Q: I have activated the Addon System(s), but they don't have a nice icon, background etc in my theme!
# A: Yeah, that's very well possible. I did included some additional files for a couple templates to they
#    can show the Add-on Systems in a nicer way, but I obviously can't (and WON'T!) make a 'fancy screen'
#    or support for each theme out there. If it's not in the provided file set, I will simply not support it
#    sorry. I Just don't have the time to keep making (or updating) all kinds of theme files for everything.
#    I have my own completely custom (non released) theme, so I don't use any of the other themes out there.
#    You could however ask your theme creator to add these systems, or you could edit the theme files yourself
#    to add them. It is honestly not that hard, and often you can easily just copy another system and rename it
#    to one of the newly installed add-on systems. In that copied folder you will then often find an .xml file
#    which you can edit with a program like Notepad++. Most of the themes are quite easy to edit, if you however
#    have some super fancy over-the-top animated theme, than the files to edit might be (much) more complex.
#    However that would also be the case for me if I would have to include all those themes, I would then have to
#    install all the possibly requested themes, manually figure out what the structure of each theme is, make
#    custom assets for each theme etc etc... Nope sorry, really not gonna happen.
#
# Q: The new systems are gone after I updated ArkOS/Emulation station!!
# A: YES! This is very well possible! This is because they are not part of the official
#    distribution, and thus are also not included in the official es_systems.cfg file
#    when it gets replaced due to an update. Not sure IF this happens though, don't suspect
#    it to happen, but it is definitly possible.
#     
#    If after an update the system(s) you've installed with this program are suddenly gone,
#    then just run this program again and then install the systems you want to add again. 
#    No worries, the installed applications, their settings etc will just be there again
#    after you've re-installed the 'Add-on Systems'
#
# Q: Can I also uninstall systems with this program/tool?
# A: Yes you can, but do keep in mind that even though I tested it EXTENSIVELY! It might still corrupt
#    your settings file if you (or another external tool you've used) modified the es_config.cfg file
#	 in an unexpected way, if the structure of the es_config has been altered significantly/incorrectly etc.
#    I have installed, removed, installed, removed, installed, removed etc etc etc my Add-On Systems
#    countless of times to confirm everything is working correctly without any issues, but please does
#    keep in mind that there is a slight posibility that your config file might corrupt upon removing
#    systems from it. If you want to play it 100% safe, then I would just recommend to disable the system
#    from the visibility options in the EmulationStation settings (under UI Settings)
#
# Most likely you won't need these answers, but because I managed to mess things up quite severely (ON PURPOSE)
# while trying to cause some "worse-case-scenario's", I decided to include these answers/tips anyway, just incase
# something does gets messed-up for some reason :) However usually these kinds of error SHOULD not happen when
# you just use this program normally.
#
# Q: I (or this tool?) messed up something big time, and now I only see emulation station with favorited but
#    NO games, options, settings AT ALL anymore! (even after I copied back the backup cfg file!)
# A: No worries, you can still recover this this quite easily. I've done quite some extensive testing causing
#    various issues and situations on purpose. If you would for example accidentally completely remove the
#    file: /etc/emulationstation/es_systems.cfg, then EmulationStation will create a new template file in the
#	 folder /home/ark/.emulationstation/es_systems.cfg However the presence of this file will cause EmulationStation
#    to completely ignore the /etc/emulationstation/es_systems.cfg file, even after you've recoverd it from backup.
#    So to ensure that EmulationStation will be using your es_systems.cfg again, all you need to do is remove the
#    file: /home/ark/.emulationstation/es_systems.cfg
#
# Q: YEAH! FUNNY MATE! How the heck do I remove, copy, restore backup files if I can't even start anything anymore!
# A: NO Worries xD, You can still get into the file system using the build-in recovery system of ArkOS :)
#    Turn off your R36S/R36H, then power it back on and then keep holding the B button. You will then boot into
#    a Boot and Recovery Tools menu (BaRT), there you can enable Wifi, the remote services like SSH and FTP, but
#    you also have access to start the file manager 351Files, which will enable you to browse through the filesystem,
#    copy files, rename them (removing the digits from the backup cfg for example), remove files etc.
#    Basic steps to restore the back-up:
#	     1. Boot into BaRT by turning on the console while holding the B button
#        2. Start 351Files and navigate to /roms/backup/XNL
#	     3. Rename the file which for example is called: es_system.cfg.12242024  and remove the version (date) at the end
#           so that the file is named es_system.cfg again (by pressing Y you'll open a menu where you can select Rename)
#        4. After renaming it back to es_system.cfg, select the file again by pressing Y but this time select Copy
#        5. Navigate (back) to: /etc/emulationstation/
#	     6. Open the 'context-menu' again by pressing the Y button and now select paste.
#    If everything went well and your backup was correct, then you should be able to start back into EmulationStation again :)
#
#   But I still get that message (or something else doesn't work)
#   Sorry, then I (most likely) won't be able to help you out either and something else might be wrong, I would then suggest
#   to indeed go to the EmulationStation website, check forums or other resources for additional information. I'm not an
#   EmulationStation expert for that matter.
# 
# Q: I get a white popup saying: "IT LOOKS LIKE YOUR SYSTEMS CONFIGURATION FILE HAS NOT BEEN SET UP OR IS INVALID.
#    YOU'LL NEED TO DO THIS BY HAND UNFORTUNATELY.     VISIT EMULATIONSTATION.ORG FOR MORE INFORMATION."
# A: YUP! You, this tool or another external tool might have messed up something big-time with the es_systems.cfg file!
#    This message mostly occurs when the XML Structure of the .cfg file is 'damaged'. This most likely is the result
#    from an open-block. each system in your EmulationStation looks something like this:
#    <system>
#		<name>systemname</name>
#		<fullname>SystemName</fullname>
#		<path>/roms/systemname</path>
#		<extension>.sh .SH</extension>
#		<command>The commands for the rom/system to start</command>
#		<platform>ignore</platform>
#		<theme>systemname</theme>
#	</system>
#   But if one of those blocks (or even elements!) is missing their 'end-tag' (for example you would be missing </system>),
#   then the XML file structure is compromised, and thus EmulationStation can't load/read it properly anymore. All the way
#   at the bottom of this file you should also be able to see </systemList> which is the end of the file marker so to speak.
#   Your best bet in restoring this is either manually editing this file to restore the structure, or by simply copying back
#   the back-up as discussed in 
#
#    WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  
# WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  
#
#      THIS PROGRAM/TOOL/SCRIPT 'MESSES WITH' SYSTEM CONFIGURATION FILES USE IT AT YOUR OWN RISK
#   In the absolute worst case scenario, all that could happen though is that you either have to restore
#     the backup cfg file and copy it back into /etc/emulationstation/ (on your OS Card!) or if you
#                      aren't able to do so, you might need to re-install ArkOs.
#         But considering you want to use this program to install additional programs/.sh scripts, you
#               probably know what's going on, how this works and what the risks are ;)
#
#		I Don't expect any issues though, but do want to put this disclaimer here, because I don't want
#            people to start complaining if something goes wrong somehow. USE AT OWN RISK
#
# WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  
#    WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  
#
#------------------------
# Website: http://www.teamxnl.com/XNL-R36-Addon-Systems-Installer
# YouTube: https://www.youtube.com/XNLFutureTechnologies
# License: MIT (Basically put: Credits/Attribution and license inclusion required)
#------------------------
#
# Redistribution request:
# I would like to request those who want to redistribute these scripts
# to only do so when and if you have significantly changed them! This to prevent
# scattering of multiple versions (and possibly even outdated) versions on the internet. 
# =================================================================================

# Preset Variables which make it easier to work with the path of this script and
# also make it easier/faster to re-use pieces of code in new/other scripts without
# having to pay attention to changing the correct file names
Application="XNL Future Technologies Add-On Systems Installer"
CurScriptDir=$(realpath "$(dirname "$0")")
CurScriptName=$(basename "$0")
ConfigEdited="n"


# Definitions for paths, files etc used in this program
ES_SystemsFile="/etc/emulationstation/es_systems.cfg" 
BackupDir="/roms/backup/XNL"					# This should always be on your OS card if I'm correct (I don't use a second card)!

# Take control of tty1 (the terminal), clearing the terminal and printing the "Application" start text in color
sudo chmod 666 /dev/tty1
printf "\033c" > /dev/tty1
printf "\e[34mStarting XNL Add-on Systems Installer\n\e[32mPlease wait...\e[0m" > /dev/tty1
reset


# hide cursor
printf "\e[?25l" > /dev/tty1
dialog --clear

# Preset dialog height and width
height="15"
sheight="10"
width="55"
swidth="45"

# If it's running on a device containing RG503 in it's name then adjust the
# dialog size. NOT needed for my R36S/R36H tools, but I have left them in for
# SOME compatibility if users do run my scripts on other devices which run ArkOS
if test ! -z "$(cat /home/ark/.config/.DEVICE | grep RG503 | tr -d '\0')"
then
  height="20"
  sheight="15"
  width="60"
  swidth="50"
fi

export TERM=linux
export XDG_RUNTIME_DIR=/run/user/$UID/

pgrep -f gptokeyb | sudo xargs kill -9
pgrep -f osk.py | sudo xargs kill -9

# Compatibility for additional systems (originally from the ArkOs wifi.sh)
# Do note though that most of my scripts are only developed for and tested on
# R36S and R36H devices! Most of them should run fine on other systems, but this
# is just a guess and NOT supported by me in any way.
if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
if test ! -z "$(cat /home/ark/.config/.DEVICE | grep RG503 | tr -d '\0')"
then
	sudo setfont /usr/share/consolefonts/Lat7-TerminusBold20x10.psf.gz
else
	sudo setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz
fi
else
sudo setfont /usr/share/consolefonts/Lat7-Terminus16.psf.gz
fi
printf "\033c" > /dev/tty1


RequiredVersion="12242024"
DetectedVersion=""

# Function to compare the versions based on date
SystemHasMinimalVersionArkOK() {
	# Reading the passed parameter (the required minimal version of ArkOS)
    local RequiredVer="$1"
	
	# The path where the ArkOS update files (well the 'version registration') can be found
	ConfigDir="/home/ark/.config/"
	
	
	# Check if we have a the ark config folder and abort if we haven't (we don't want to mess with other RetroConsole interfaces!)
	if [ ! -d "$ConfigDir" ]; then
		dialog --backtitle "$Application" --title "Fatal Error" --msgbox "Unable to detect the directory:\n$ConfigDir\n\nAre you sure that you are running ArkOS on your device?\n\nThe program will now abort!" 12 $swidth
		exit 1
	fi
	
	# Find all the update files, filter by .update prefix, and sort by the date part in the filename (and ignore any dashes)
	local CurrentVer=$(sudo ls "$ConfigDir" -at | grep '^\.update' | sed 's/^\.update\([^-]*\).*/\1/' | head -n 1)


	if [ -z "$CurrentVer" ]; then
		dialog --backtitle "$Application" --title "Fatal Error" --msgbox "Unable to detect ANY ArkOS updates in the directory:\n$ConfigDir\n\nAre you sure that you are running on a valid ArkOS installation?\n\nThe program will now abort!" $height $swidth
		exit 1
	fi

    # Convert MMDDYYYY to a comparable format (Unix timestamp)
    local CurrentVerTimestamp
    local RequiredVerTimestamp
    CurrentVerTimestamp=$(date -d "${CurrentVer:0:2}/${CurrentVer:2:2}/${CurrentVer:4:4}" +%s)
    RequiredVerTimestamp=$(date -d "${RequiredVer:0:2}/${RequiredVer:2:2}/${RequiredVer:4:4}" +%s)

    # Now we compare the timestamps and will detect if the currently installed version of ArkOS is
	# older than the latest update this program was designed for and/or tested on
    if [ "$CurrentVerTimestamp" -lt "$RequiredVerTimestamp" ]; then
        return 1 # In bash anything above 0 in a return code bascially put means 'error code' 
    else
		DetectedVersion="$CurrentVer"
        return 0 # In bash this means 'okay resume' 
    fi
}


ProgramStart(){
	# We'll check if the system has at least the latest version of ArkOs I've tested this on
	if ! SystemHasMinimalVersionArkOK "$RequiredVersion"; then
		dialog --backtitle "$Application" --title "ArkOS Outdated" --msgbox "It seems like you are running an older version of ArkOS!\n\nThe minimal version of ArkOS this program was developed for and tested on is: $RequiredVersion\n\nHowever because my method of version checking isn't 100% fail proof, the program will resume anyway.\n\nBut please do keep in mind that this program might not be compatible with your ArkOS installation!" $height $width
	fi

	if [[ "$CurScriptDir" == /roms/xnlft* || "$CurScriptDir" == /roms/apps* || "$CurScriptDir" == /roms2/xnlft* || "$CurScriptDir" == /roms2/apps* ]]; then
		dialog --backtitle "$Application" --title "SAFETY ISSUE DETECTED!" --msgbox "NOPE!\n\nIt seems like it that you are NOT running this application from either /roms/tools or /roms2/tools!\n\nBut instead from one of the folders/systems which this program can actually install and uninstall.\n\nTo prevent you from accidentally uninstalling the system in which this program is installed, it is not allowed to run this program from one of those folders!\n\nPlease install this program in either /roms/tools or /roms2/tools if you're using a secondary SD-Card.\n\nThe XNL Add-On Systems Installer will now exit.\n\n" $height $width
		exit 0
	fi

	# On start of the application we'll check if the folder /roms/backup/XNL exists, it not we'll try to create it
	# this will make a backup of es_systems.cfg with the current version of ArkOS attached to the filename.
	# Doing so will ensure that IF ArkOS overwrites the entire es_systems.cfg (which I don't suspect though!) on update
	# that we have a new (recent) backup again if the user tries to 're-activate' my custom system(s)
	if [ ! -d "$BackupDir" ]; then
		mkdir -p "$BackupDir"

		# Check if the directory creation was successful
		if [ $? -eq 0 ]; then
			printf "\e[32m OK\e[0m" > /dev/tty1
		else
			printf "\e[31m FAIL!\e[0m" > /dev/tty1
			dialog --backtitle "$Application" --title "Fatal Error" --msgbox "There seems to be a problem while trying to create the backup in the directory:\n/roms/backup/XNL/$DetectedVersion\n\nFor safety reasons the program will not continue!" $sheight $swidth
			exit 0
		fi
	fi
	
	# Make a backup of the current version of es_system.cfg IF it doesn't exist as backup yet!
	if [[ ! -f "$BackupDir/es_systems.cfg.$DetectedVersion" ]]; then
		cp "/etc/emulationstation/es_systems.cfg" "$BackupDir/es_systems.cfg.$DetectedVersion"
		dialog --backtitle "$Application" --title "XNL Backup System" --msgbox "Initial Backup of:\n/etc/emulationstation/es_systems.cfg\n\nCreated at:\n$BackupDir/es_systems.cfg.$DetectedVersion\n\nFor ArkOS version: $DetectedVersion" 12 50
	fi
	
	# Jump to the main menu
	MainMenu
}


MainMenu(){
  SelectedItem="${1:-0}" # Use the passed parameter or default to "0"

  XNLSysStatus="Install XNL Ft. System/Category"
  AppsSysStatus="Install Apps System/Category"
  
  if GetSystemExists "xnlft"; then
	XNLSysStatus="Uninstall XNL Ft. System/Category"
  fi

  if GetSystemExists "apps"; then
	AppsSysStatus="Uninstall Apps System/Category"
  fi

  mainoptions=( 1 "Disclaimer (read first!)" 2 "Help and Info" 3 "$XNLSysStatus" 4 "$AppsSysStatus" 5 "Exit")

  while true; do
    mainselection=(dialog \
   	--backtitle "$Application" \
   	--title "Main Menu" \
   	--no-collapse \
   	--clear \
	--cancel-label "Exit" \
	--default-item "$SelectedItem" \
    --menu "Categories" $height $width 15)
	
	mainchoices=$("${mainselection[@]}" "${mainoptions[@]}" 2>&1 > /dev/tty1)
	if [[ $? != 0 ]]; then
	  exit 1
	fi
    for mchoice in $mainchoices; do
      case $mchoice in
		1)
			dialog --backtitle "$Application" --title "DISCLAIMER" --msgbox "USE OF THIS TOOL IS AT YOUR OWN RISK\n\nI have tested this Add-on Systems Installer VERY extensively, even intentionally causing major failures, errors and corruptions in the system files to eliminate as much risks as possible. And to be able to write 'help sections' in the documentaion for several scenarios which MIGHT happen in rare cases.\n\nBecause this program modifies the es_systems.cfg file, it COULD happen that the file turns corrupted if the file has already been edited (incorrectly), which in turn might cause EmulationStation to no longer start properly.\n\nIt does however automatically create an backup of your es_systems.cfg on your (OS) SD-Card, and there are also very elaborate instructions in the documentation provided with the download and on the website, on how you could (possibly) recover your EmulationStation IF something might go wrong. You can even find these instructions by opening this script in Notepad for example.\n\nConsidering how extremely I have tested this tool, installed it on 8 different R36S and R36H consoles over and over without ANY issues, I don't expect any problems with it. But again: This does depend on if you (or another tool) has altered the es_config.cfg file (incorrectly) before.\n\n " 40 80
			MainMenu
			;;
		2)
			dialog --backtitle "$Application" --title "Information / Help" --msgbox "With this small tool you can add the extra systems the main menu of EmulationStation.\n\nI for example use the XNL Ft. category to put all my applications, tools and such in there so they are all in one managed location instead of cluttered in the options / tools menu.\n\nQ: Can you add support for [theme name here]?\nA: No, sorry. I have included a couple themes in the download, others you will either have to ask the theme developer or edit the files yourself (more information about this in the documentation)\n\nQ: Will the Add-On Systems remain after an ArkOS update?\nA: I don't think they will be removed due to an ArkOS or EmulationStation update, but if this does happen for some reason, then you can just run this tool again and re-activate them. Your apps etc will then re-appear after you re-activated the Add-on System(s).\n\nQ: Why don't I see the newly added Add-On System(s)?\nA: Make sure that they are set to visible in the EmulationStation settings AND that you have installed at least one app, tool or rom (depending on the system you install of course) in the folder on your \roms partition that belongs to the system (Emulation station will by default hide 'empty systems')\n\nQ: Can you add [console name here]?\nA: No, I'm not (actively) working on new emulators, consoles or anything like that, sorry.\n\nQ: Can I use this tool on other consoles than the R36S / R36H?\nA: It will most likely work if you're running on ArkOS, but my tools are mainly (well only basically) designed for the R36S and R36H, so it's not recommended and at your own risk (as usual)\n\nQ: How do I install the provided theme files for your Add-on Systems?\nA: This information can be found in the documentation of the download and/or on the website.\n\nQ: Your provided theme files for my theme don't work!?\nA: Sorry, can't help you with that, I added some theme files for some themes to be a bit helpful, but I don't (and won't) actively develop or update all kinds of themes for these Add-Ons\n\nQ: I have a different question/problem!\nA: Please check the documentation provided with the download and/or on the website of the XNL R36 Add-on Systems Installer\n\n" 40 80
			MainMenu
			;;
		3) 
			AddRemoveSystemXNLFt
			;;
        4) 
			AddRemoveSystemApps
			;;
        5) 
			exit 0
			;;
      esac
    done
  done
}



AddRemoveSystemXNLFt(){
	if GetSystemExists "xnlft"; then
		dialog --defaultno --backtitle "$Application" --title "Uninstall Add-on System" --yesno "Are you sure that you want to uninstall the XNL Ft. system from your emulation station configuration?\n\nThis will NOT remove the apps folder and it's contents from your roms folder/card.\n\nNOTE: It's recommended to just turn off the visibility of add-on systems in the RetroArch Settings instead!\n\n" 14 55
		if [ $? -ne 0 ]; then
			MainMenu 3
		else
			RemoveSystem "xnlft"
			ConfigEdited="y"
		fi
	else
		dialog --defaultno --backtitle "$Application" --title "Install Add-on System" --yesno "With this option you can add an additional category/system to the main menu of EmulationStation/your console.\n\nThis option will add the category XNL Ft. which can be used to install/place all my console tools, programs, tweaks etc in, so that they are nicely organized instead of cluttered in your Options / tools menu.\n\nThis System will create the following folder on your roms card: xnlft in which you can place .sh files which can then be started from that category.\n\nAre you sure that you want to install the XNL Ft. category/system in your EmulationStation main menu?\n\n " 40 80
		if [ $? -ne 0 ]; then
			MainMenu 3
		fi

		XNL_FT_SYSTEM="\    <system>\n        <name>xnlft</name>\n        <fullname>XNL Ft.</fullname>\n        <path>/roms/xnlft/</path>\n        <extension>.sh .SH</extension>\n        <command>sudo chmod 666 /dev/tty1; %ROM% 2>&1 > /dev/tty1; printf \"\033c\" >> /dev/tty1</command>\n        <platform>ignore</platform>\n        <theme>xnlft</theme>\n    </system>"
		sed -i "/<\/systemList>/i $XNL_FT_SYSTEM" "$ES_SystemsFile"
		
		ConfigEdited="y"
		dialog --backtitle "$Application" --title "Add-On System Installed" --msgbox "The XNL Ft. 'system' has been installed in EmulationStation.\n\nSystem Name:      XNL Ft.\nRoms Folder:      /roms/xnlft\nSupported Files:  .sh\n\nFor more information about add-on systems, if you can't see them, theme style etc, please check the Help and Info in the main menu or the provided documention with the download or on the website." 50 80

		# Create the system folders if it doesn't exist so users can install apps in it
		# if we detect that the folder /roms/themes exists, then we can fairly certain assume that this card is mounted properly and has a roms folder
		# (which is basically always the case with the OS card though ;) )
		if [[ -d "/roms/themes" ]]; then
			mkdir -p "/roms/xnlft"
		fi

		# if we detect that the folder /roms2/themes exists, then we can fairly certain assume that the second card is mounted and is used for roms
		if [[ -d "/roms2/themes" ]]; then
			mkdir -p "/roms2/xnlft"
		fi
	fi

	# Return to the main menu
	MainMenu 3
}


AddRemoveSystemApps(){
	if GetSystemExists "apps"; then
		dialog --defaultno --backtitle "$Application" --title "Uninstall Add-on System" --yesno "Are you sure that you want to uninstall the Apps system from your emulation station configuration?\n\nThis will NOT remove the apps folder and it's contents from your roms folder/card.\n\nNOTE: It's recommended to just turn off the visibility of add-on systems in the RetroArch Settings instead!\n\n" 14 55
		if [ $? -ne 0 ]; then
			MainMenu 4
		else
			RemoveSystem "apps"
			ConfigEdited="y"
		fi
	else
		dialog --defaultno --backtitle "$Application" --title "Install Add-on System" --yesno "This will add the additional category/system Apps to the main menu of EmulationStation.\n\nThis category/system can be used to install/place extra Apps, games, scripts in which you download elsewhere or make yourself.\n\nSome of my apps will also install in this folder if it exists.\n\nThis System will create the following folder on your roms card: apps in which you can place .sh files which can then be started from that category.\n\nAre you sure that you want to install the Apps category/system in your EmulationStation main menu?\n\n " 40 80
		if [ $? -ne 0 ]; then
			MainMenu 4
		fi

		APPS_SYSTEM="\    <system>\n        <name>apps</name>\n        <fullname>Apps</fullname>\n        <path>/roms/apps/</path>\n        <extension>.sh .SH</extension>\n        <command>sudo chmod 666 /dev/tty1; %ROM% 2>&1 > /dev/tty1; printf \"\033c\" >> /dev/tty1</command>\n        <platform>ignore</platform>\n        <theme>apps</theme>\n    </system>"
		printf "%s" "$APPS_SYSTEM" | sed -i "/<\/systemList>/i $(cat)" "$ES_SystemsFile"

		ConfigEdited="y"
		dialog --backtitle "$Application" --title "Add-On System Installed" --msgbox "The Apps 'system' has been installed in EmulationStation.\n\nSystem Name:      Apps\nRoms Folder:      /roms/apps\nSupported Files:  .sh\n\nFor more information about add-on systems, if you can't see them, theme style etc, please check the Help and Info in the main menu or the provided documention with the download or on the website." 50 80
	
		# Create the system folders if it doesn't exist so users can install apps in it
		# if we detect that the folder /roms/themes exists, then we can fairly certain assume that this card is mounted properly and has a roms folder
		# (which is basically always the case with the OS card though ;) )
		if [[ -d "/roms/themes" ]]; then
			mkdir -p "/roms/apps"
		fi
	
		# if we detect that the folder /roms2/themes exists, then we can fairly certain assume that the second card is mounted and is used for roms
		if [[ -d "/roms2/themes" ]]; then
			mkdir -p "/roms2/apps"
		fi
	fi

	MainMenu 4
}


#==============================================================================================================================
# Function to remove a system by name
# !!! USE WITH CAUTION!!!! 
# function is ONLY intended to be used internally by my script(s) and could cause "serious" damage to the EmulationStation
# configuration if used incorectly! It has no special safety checks which would take 'external use' into account!
#==============================================================================================================================
RemoveSystem() {
    # System to be removed (by name) passed as an argument
	local SystemToRemove="$1"

    # First we'll check IF the system even exists in the es_systems.cfg file
	if GetSystemExists "$SystemToRemove"; then
		FileBuffer=""			# The full 'FileBuffer' which is used to "reconstruct" the entire configuration file while removing the unwanted system
		SystemBlockBuffer=""	# The buffer which will hold an entire system block until we decide to (re-)add it again
		InSystemBlock="n"		# Variable which lets the script know if we're currently inside a system block
		AddSystemOnEndBlock="y" # Tells the system if we need to add the system block back to the file or that it's the one we want to remove

        # Here we're reading the entire configuration file line by line
		# - Yes, I could have also first read it to a variable using cat for example but I didn't.
		# - Yes, I could have used XML parser tools, BUT I tried several which where either problematic due to emulation station
		#   using 'special characters' like % etc in the commands making the parsers cause issues (requiring extra filtering) and
		#   secondly I didn't wanted to install extra dependencies just for something as simple as this.
		# - Yes, I most likely could also have done this with something like sed or awk, but I'm no "hero" in those tools when it
		#   comes to complexer tasks like making sure system blocks would be inserted before the end of the file tag, without risking
		#   I would mess up something big time. This approach is also easier for beginners to follow and learn from, and for me personally
		#	this is much more reliable when not using XML Parsers. So no, no pull-request needed/accepted to change this to akw/sed/an xml parser ;)
		while IFS= read -r line || [[ -n "$line" ]]; do
			# Detect if the current read line CONTAINS <system> in a case insensitive way
			# while the *'s also ensure that the line still validates as true if there are
			# either leading or trailing characters in this line
			if [[ "${line,,}" == *"<system>"* ]]; then
				InSystemBlock="y"			# Tell the script we're currently inside a system block
				AddSystemOnEndBlock="y"		# By default we assume the system should be added at the end of the block
			fi

			if [[ $InSystemBlock == "n" ]]; then
				# Any line that is detected and not part of a system block will get added to the FileBuffer instantly
				FileBuffer+="$line"$'\n'
			else	
				# If we find the system name INSIDE a system block....
				if [[ "${line,,}" == *"<name>$SystemToRemove</name>"* ]]; then
					# We'll tell the script to NOT add this SystemBlockBuffer back to the FileBuffer when the block ends
					AddSystemOnEndBlock="n"
				fi

				# If we are inside a system block we'll add it to the SystemBlockBuffer
				SystemBlockBuffer+="$line"$'\n'
			fi

			# Detect if we have reached the end of a system block
			if [[ "${line,,}" == *"</system>"* ]]; then
				InSystemBlock="n"			# Tell the script we're no longer in a SystemBlock
				if [[ $AddSystemOnEndBlock == "y" ]]; then
					FileBuffer+="$SystemBlockBuffer"	# Add the system to the FileBuffer if it wasn't the one we wanted to remove
				fi
				SystemBlockBuffer=""					# Clear the SystemBlockBuffer for the next detected system
				AddSystemOnEndBlock="y"					# Making sure that the following blocks will be able to be added again
			fi
		done < "$ES_SystemsFile"

		# Write the modified configuration file back to disk (making the change permanent)
		echo "$FileBuffer" > "$ES_SystemsFile" 

		dialog --defaultno --backtitle "$Application" --title "Add-on System Removed" --msgbox "The Add-on system ($SystemToRemove) has been removed from the EmulationStation configuration\n\n" 10 50
    fi
}


#==============================================================================================================================
# Simple function to detect if a certain 'system' has already been added to the EmulationStation configuration
#==============================================================================================================================
GetSystemExists(){
	SystemToCheck="$1"
	if grep -q "<name>${SystemToCheck}</name>" "$ES_SystemsFile"; then
		return 0
	else
		return 1
	fi
}


#==============================================================================================================================
# Cleanup function to 'cleanup after our script' 
#==============================================================================================================================
CleanUpOnExit() {
  printf "\033c" > /dev/tty1				# Clear the terminal😉
  if [[ ! -z $(pgrep -f gptokeyb) ]]; then  # Kill all running gptokeyb instances
    pgrep -f gptokeyb | sudo xargs kill -9 
  fi
  # Used to check for a specific platform this script is running on (a different device
  # than the R36S/H but I re-used this part for POSSIBLE future compatibility with other
  # handhelds like mine (code re-used from wifi.sh)
  if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
    sudo setfont /usr/share/consolefonts/Lat7-Terminus20x10.psf.gz
  fi
  
  # If we've changed the config file we want to restart EmulationStation so it can load the new system(s)
  if [[ $ConfigEdited == "y" ]]; then
	sudo systemctl restart emulationstation
  fi
  
  exit 0
}

#==============================================================================================================================
# Gamepad control, 'trapping' the script exit and starting the menu
#==============================================================================================================================
# Set the permissions to interact with uinput (the 'device')
sudo chmod 666 /dev/uinput

# Loading a database (Simple DirectMedia Layer) which holds the info for lots of 'pre-configured' controllers so that the
# gamepad(s) (which also include the internal gamepad of the R36S/H) buttons are propperly assigned with gptokeyb
#(Gamepad to Keyboard/Mouse).
export SDL_GAMECONTROLLERCONFIG_FILE="/opt/inttools/gamecontrollerdb.txt"

# Find all (already) running processes of gptokeyb and kill (terminate) them. We do this to ensure that you for example
# wont get double key emulations or other issues which might arrise from multiple instances running.
if [[ ! -z $(pgrep -f gptokeyb) ]]; then
  pgrep -f gptokeyb | sudo xargs kill -9
fi

# Here we link gptokeyb to our script so that gptokeyb knows which script to instantly kill when we press
# Select + Start on the R36S or R36H. and option -C (followed by the file .gptk file location) tell gptokyb
# which buttons have to be emulated when we press the game controller buttons (and thus convert them to
# keyboard presses). The last section of this line basically ensures that gptokeyb runs in the background
# and that all it's output will be 'tossed into dev/null' (aka disappear in oblivion)/be discarded,
# esentially making it run silently.
/opt/inttools/gptokeyb -1 "$CurScriptName" -c "/opt/inttools/keys.gptk" > /dev/null 2>&1 &

# Reset/clear the terminal
printf "\033c" > /dev/tty1

# This ensures that the function CleanUpOnExit will be called when the script exits.
# we can/will use this to perform additional clean-ups and/or other routines we (might) need to
# do at the end our script/program
trap CleanUpOnExit EXIT

ProgramStart