﻿///////////////////////////////////////////////////////////////////////////
// By: Alan Yeats
// HNC COMPUTER GAME DEVELOPEMENT 
// GRADED UNIT
////////////////////////////////////////////////////////////////////////////
//	Use: 		To Create the bullets that attack the minions
////////////////////////////////////////////////////////////////////////////
package 
{
	// Imports
	import flash.display.MovieClip;
	import flash.events.*;

	public class Bullet extends MovieClip
	{
		private var _root:*;			
		public var target;					// Target of bullet
		public var damage:int;				// Damage of the bullet
		public var slowness:int;			// Slowness effect of the bullet
		private var xSpeed:Number;			// Horrizontal Speed
		private var ySpeed:Number;			// Vertical Speed
		private var maxSpeed:Number = 5;	// Maxium Speed bullet can travel


		public function Bullet()
		{
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME,eFrame);
		}
		
		// Only runs once when the function is called
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);

			// Draws a basic bullet 
			// Likely to be change? Will add the graphics when completed
			// Sends Bullet to the stage
			
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawCircle(0,0,2);
			this.graphics.endFill();

		}
		// Runs every frame when the function is called 
		private function eFrame(e:Event):void{
			
			var yDist:Number=target.y+12.5 - this.y;	 // Work out the distance from the target 
			var xDist:Number=target.x+12.5 - this.x;
			var angle:Number=Math.atan2(yDist,xDist);
			
			ySpeed=Math.sin(angle) * maxSpeed;			// Create the speed of the bullet
			xSpeed=Math.cos(angle) * maxSpeed;
			
			this.x +=  xSpeed;							// Speed gets added to the possition
			this.y +=  ySpeed;			
			
			if(this.hitTestObject(target)){				// Use hit test to work out of hit the target 
				target.health -=damage;					// Remove damage of the bullet from the heath of the target
				target.maxSpeed -= slowness				// Apply slownless effect to target 
				destoryThis();							// Destory Bullet
				
			} // End of IF
			
			if (target == null || _root.gameOver == true){		// If Target is enemy and the game is over
				destoryThis();									// Destroy the bullet
				
			}// End of IF
			
		}// End of Function
		
		public function destoryThis():void				// Remove this function
		{
			// Remove object from the stage
			this.removeEventListener(Event.ENTER_FRAME,eFrame);
			MovieClip(this.parent).removeChild(this);
		}// End of Destorythis fucntion
		
		
	}// End of class

}// End of 