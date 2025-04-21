ESX Truck Job
This script allows players to participate in a truck delivery job in FiveM using the ESX framework. Players can choose to transport oil, goods, or gravel, with each type having different vehicles, delivery points, and rewards. The script supports configurable spawn points, vehicle options, and delivery locations. Players must park their truck at designated spots to complete the job.

Features
Multiple Job Types: Choose from transporting oil, goods, or gravel, each with different vehicles and reward amounts.

Vehicle Spawn: Vehicles are spawned with customizable locations and headings.

Job Progression: Players must travel to a delivery point, wait for a minute, and then return to the station to complete the job.

Customizable Configurations: Easily configurable delivery points, vehicles, and rewards in the config.lua file.

Blips and Markers: Shows blips for the job start and delivery points, with a visual marker to guide players.

Notifications: Players receive notifications to guide them through the job and confirm completion.

Requirements
ESX Framework: This script requires ESX to be installed and properly set up on your server.

okokNotify (optional): If you want custom notifications (instead of ESX.ShowNotification), use the okokNotify resource.

Installation
Download the repository:

Clone or download this repository into your resources folder.

Add to your server.cfg: Add the following line to your server.cfg:
ensure esx_truckjob

Configuration:

Open the config.lua file to configure vehicle spawn points, delivery points, job types, rewards, and other options.

You can set the spawn locations, heading angles, and delivery points for oil, goods, and gravel.

Dependencies:

Make sure to have the ESX framework installed and running on your server.

Optionally, install okokNotify for custom notifications (or use the default ESX notifications).

How to Use
Once the script is installed, players can access the truck job by going to the job start location (configured in config.lua).

When near the job start point, players will receive a prompt to choose a job (oil, goods, or gravel).

After selecting a job, a vehicle will spawn, and the player must drive to a delivery point.

The player will need to wait for 1 minute at the delivery point, then return to the station to finish the job and receive their reward.
