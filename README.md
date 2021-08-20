
<p align="center"><a href="https://www.youtube.com/watch?v=BhuBHHfL_Ag"><img src="https://i.imgur.com/4CrNokY.png"></a></p>

# GlorifiedLeveling

![https://img.shields.io/discord/329643791063449600?label=discord](https://img.shields.io/discord/329643791063449600?label=discord)

Please do not contact me for support. I will not assist you. This is open source with an issues section for a reason.

## Installation & Usage

### Guide

- Download the latest version.
- Open the zip file using WinRar or 7-Zip.
- Drag & drop the folder into your addon's folder.
- Configure at `lua/addons/glorifiedleveling/xx_config.lua`.
- Add [this](https://steamcommunity.com/sharedfiles/filedetails/?id=2136144023) workshop link to your server's collection.

### Level Requirements in DarkRP

If you want to add level requirements to your job or entity, you have a few options:

- Type `level` like you would in Vrondakis' Leveling System.
- Type `GlorifiedLeveling_Level` under the entity/job.
- Type `Level` under the entity/job.

### Using the Admin Panel

Type `glorifiedleveling_admin` in your console if you would like to access the panel.

### Restoring Backups

- Go to your server's `data` folder.
- Open the `glorifiedleveling_backups` folder.
- Look for the timestamp you would like to restore to.
- Type `glorifiedleveling_restorebackup` timestamp in your server's console.
- Restart your server.

### Importing Vrondakis' Leveling System Data

- Make sure your SQL config is set up in GlorifiedLeveling.
- Make sure Vrondakis' Leveling System is on your server and the SQL is set up correctly.
- Type `glorifiedleveling_importvrondakisdata` in console and make sure it prints that the transfer was successful.
- Restart your server.

## Description

GlorifiedLeveling was built with optimization in mind. It is lightweight, efficient and will fit all your needs for an experience and leveling system. Configured usergroups are able to use our built-in administration panel, which provide you the key feature of modifying other players' accounts. Your players are also capable of getting certain perks which allow them to specialize in a specific field in order to advantage themselves.

Things don't always go as planned, and we understand that. There are numerous different tools included for damage control in the event that something goes wrong. Examples of these tools include our completely configurable and in-depth backup system which allow you to backup your database safely, as well as a lockdown mode that prevents the leveling system from working which can be activated from one of your configured usergroups in the event of an emergency.

### Key Features

- Easy and powerful configuration
- MySQL and SQLite compatibility
- In-depth perk system to add incentive for your players
- Leaderboard feature to show who's on top in your server
- Lockdown mode in the event of an emergency
- Exploit prevention and validation checks
- Integrations with plentiful addons
- Ability to set multipliers for certain usergroups, days of the week and whatever you like!
- Support all addons Vrondakis' leveling system does natively
- Vrondakis' data importer so your players don't miss out

### Features

- Lightweight with top tier optimization
- Backup system for damage control, fully configurable
- Integrated with numerous other addons due to our powerful API
- Ability to modify the system's colors and interface positioning
- CAMI support for certain admin privileges
- Administration panel to take full control of your server
- Satisfying effects when your players level up
- Rainbow effects when reaching max level, including a colour-changing physgun
- Easily customizable UI themes with our theme library
- Add support for other gamemodes with our easy-to-use compatibility file
- Restrict certain things - such as DarkRP jobs and entities - behind a certain level
- Translate to your own language with ease using our localization library
- DRM free and zero obfuscation