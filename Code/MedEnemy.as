///////////////////////////////////////////////////////////////////////////
// By: Alan Yeats
// HNC COMPUTER GAME DEVELOPEMENT 
// GRADED UNIT
////////////////////////////////////////////////////////////////////////////
// Use:		Class Should Create the Medium minion with its adverage vars 
////////////////////////////////////////////////////////////////////////////

package 
{
	// Importing iteams that are needed
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.DisplayObjectContainer;

	public class MedEnemy extends MovieClip
	{	
		
		
		
		private var _root:MovieClip;
		public var xSpeed:int;			// speed going left right
		public var ySpeed:int;			// speed up and odwn
		public var maxSpeed:int = 3;	// max speed
		public var health:int = 18;		// Heath of minion
		public var BMDamange:int = 20;	// The Damage they will do to the castle


		public function MedEnemy()
		{
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, everFrame);
		}
		
		private function beginClass(e:Event):void				// Take place ones the class gets called 
		{
			_root = MovieClip(root);
																
			
			if (_root.startDir == 'UP')							// Finding Start Possion 
			{													// start pos up and code for it
				this.y = 300;
				this.x = _root.startCoord;
				this.xSpeed = 0;
				this.ySpeed =  -  maxSpeed;


			}
			else if (_root.startDir == 'DOWN')
			{													// start pos down and code for it
				this.y = -25;
				this.x = _root.startCoord;
				this.xSpeed = 0;
				this.ySpeed = maxSpeed;


			}
			else if (_root.startDir == 'LEFT')
			{														// start pos left and code for it
				this.x = 550;
				this.y = _root.startCoord;
				this.xSpeed =  -  maxSpeed;
				this.ySpeed = 0;


			}
			else if (_root.startDir == 'RIGHT')
			{															// start pos right and code for it
				this.x = -25;
				this.y = _root.startCoord;
				this.xSpeed = maxSpeed;
				this.ySpeed = 0;

			}

			
			
		 	graphics.beginFill(0xFFFF00)
			this.graphics.drawCircle(12.5,12.5,8);							// Adds Minions to the stage
			this.graphics.endFill();
												



		}
		
		private function everFrame(e:Event):void							// Takes place At every Frame
		{

			this.x +=  xSpeed;												// Set Hirizontal Speed
			this.y +=  ySpeed;												// Set Vertical Speed	
			
			// At finish point destory the minion and remove health from the castle 
			
	if (_root.finDir == 'UP')
		{
				
			if (this.y <= -25)
				{
					_root.money += 50;										// Adds Money to players total.
					_root.castleH -=  BMDamange;							// Take Health off the castle
					destroyThis();											// Remove minion from stage
					

				}
			}
			else if (_root.finDir == 'RIGHT')
			{
				if (this.x >= 550)
				{
					_root.money += 50;										// Adds Money to players total.
					_root.castleH -=  BMDamange;							// Take Health off the castle
					destroyThis();											// Remove minion from stage
					
				}
			}
			else if (_root.finDir == 'DOWN')
			{
				if (this.y >= 300)
				{
					_root.money += 50;										// Adds Money to players total.	
					_root.castleH -=   BMDamange;							// Take Health off the castle
					destroyThis();											// Remove minion from stage
				}
			}
			else if (_root.finDir == 'LEFT')
			{
				if (this.x <= 0)
				{
					_root.money += 50;										// Adds Money to players total.					
					_root.castleH -=  BMDamange;							// Take Health off the castle
					destroyThis();											// Remove minion from stage
					
				}
			}
																			// If Game over then destory the minion
			if (_root.gameOver)
			{
				destroyThis();												// Remove minion from stage
			}
			
			
			if (health <= 0)
			{
				destroyThis();												// Remove all remaining minions if the castle has been destoryed
			}
		}


		
		public function destroyThis():void									// Removing functions and object from the scene 
		{
			
			this.removeEventListener(Event.ENTER_FRAME, everFrame);			
			this.parent.removeChild(this);									// Remove minions from stage
		} // end of function
	}// end of class
}// end of package