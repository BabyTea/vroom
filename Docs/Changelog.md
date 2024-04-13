# Mar 29th 2024
- First changelog
- Current state of game:
	- Driving mechanics
	- Simple Physics and collisions
	- Basic score system to 'deliver' packages
	- GPS Arrow pointing to next objective
	- Game over screen after delivering all packages
	- Basic animations for objectives coming in and out of existence

## Changes:
- Fixed bug where another package would spawn after 'winning'
- Added basic health and damage system
# Mar 30th 2024
- Added process for throwing packages from vehicle when making delivery - Will use this process to make it so player literally throws their deliveries into/at homes on completion.
- Tried hand at 3D modeling using BlockBench and created a simple truck for the player instead of the block stand-in. 
- Adjusted center of mass of new vehicle model.
# Mar 31st 2024
- Changed/reworked package throwing and drop-off spawn system - Now all dropoff locations have a child marker which is where the package is aimed. So you can place the dropoff location at the end of a driveway, for example, and the 'landing' point on the porch of the house, and the package is thrown toward the porch.
- Made a test level specifically for testing package delivery mechanics.
- Tried to make a road. It sucked. Will not be using this.
- Cleaned up SOME scripting, but not enough.