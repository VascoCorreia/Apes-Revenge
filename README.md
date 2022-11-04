<p align="center">
  <img src="https://user-images.githubusercontent.com/25254690/199989699-1ee3d1b6-561a-4164-82ab-eaeb1d9a32a4.png" />
</p>

My second game developed! Developed using Lua scripting languange and the Love2d framework.

In order to play 2 players are necessary, one using the keyboard and another using a controller. The reason I decided to developed Apes Revenge this way is because I wanted the challenge of implementing controller adaptation into the game and making it work in a framework that is not adpated for this (Does not make a lot of sense but my past self wanted the challenge).

**1. Player Controllers**

P - Pauses the game

 **1.1. Keyboard**

| Key  | Action |
| ------------- | ------------- |
| W | Jump  |
| A  | Move Left  |
| D  | Move Right  |
| Mouse1  | Shoot  |


 **1.2. Controller**
  
| Key  | Action |
| ------------- | ------------- |
| X | Jump  |
| Left Arrow  | Move Left  |
| Right Arrow  | Move Right  |
| Right Analog  | Aim  |
| R1  | Shoot  |

**2. Weapons**

Two random weapons will spawn every 5 seconds, in random locations in the arena, in order to collect them the players hitbox just needs to collide with the weapon hitbox. 

  **2.1. Pistol**
  
  Shoots a projectile with slow travelling speed, same speed as the player movement.
  
  ![Pistol](https://user-images.githubusercontent.com/25254690/200000424-153f44ad-f4f9-4274-9683-fd0de43f7d5a.png)
  
  **2.2. Shotgun**

  Projectile 1 will move forward in a straight line. Projectile 2 will shoot diagonally in a π/24 radians angle clockwise relative to projectile that moves forward.     Projectile 3 shoot diago-nally in a - π/24 radians angle clockwise relative to projectile that moves forward. Rare spawn rate. 
    
  ![Shotgun](https://user-images.githubusercontent.com/25254690/200001174-c01f1942-9ba8-4595-8ef8-d9848d9ef7de.png)

  **3. Trampolines**
  
  There are 2 trampolines at the edges of the arena that when stepped on will make the character travel across the map in an arc at fast speed.
  
