///////////////////////////////////////////////////////////////////////////
// By: Alan Yeats
// HNC COMPUTER GAME DEVELOPEMENT 
// GRADED UNIT
////////////////////////////////////////////////////////////////////////////
// Use:		Class Should Create the basic minion with its basic vars 
////////////////////////////////////////////////////////////////////////////

package 
{
	// Importing iteams that are needed
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.DisplayObjectContainer;

	public class Enemy extends MovieClip
	{	
		// Declaring graphics for minion
		var bmionion:firstmionon = new firstmionon();
		
		private var _root:MovieClip;
		public var xSpeed:int;			// speed going left right
		public var ySpeed:int;			// speed up and odwn
		public var maxSpeed:int = 4;	// max speed
		public var health:int = 7;		// Heath of minion
		public var BMDamange:int = 5;	// The Damage they will do to the castle


		public function Enemy()
		{
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}
		// Take place ones the class gets called 
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);

			// Finding Start Possion 
			if (_root.startDir == 'UP')
			{// start pos up and code for it
				this.y = 300;
				this.x = _root.startCoord;
				this.xSpeed = 0;
				this.ySpeed =  -  maxSpeed;


			}
			else if (_root.startDir == 'DOWN')
			{// start pos down and code for it
				this.y = -25;
				this.x = _root.startCoord;
				this.xSpeed = 0;
				this.ySpeed = maxSpeed;


			}
			else if (_root.startDir == 'LEFT')
			{// start pos up and code for it
				this.x = 550;
				this.y = _root.startCoord;
				this.xSpeed =  -  maxSpeed;
				this.ySpeed = 0;


			}
			else if (_root.startDir == 'RIGHT')
			{// start pos up and code for it
				this.x = -25;
				this.y = _root.startCoord;
				this.xSpeed = maxSpeed;
				this.ySpeed = 0;

			}

			// Adds Minions to the stage
			addChild(bmionion);



		}
		// Takes place At every Frame
		private function eFrameEvents(e:Event):void
		{

			this.x +=  xSpeed;
			this.y +=  ySpeed;
			
			// At finish point destory the minion and remove health from the castle 
			
			if (_root.finDir == 'UP')
			{
				if (this.y <= -25)
				{
					destroyThis();
					_root.castleH =  -  BMDamange;

				}
			}
			else if (_root.finDir == 'RIGHT')
			{
				if (this.x >= 550)
				{
					destroyThis();
					_root.castleH =  -  BMDamange;
				}
			}
			else if (_root.finDir == 'DOWN')
			{
				if (this.y >= 300)
				{
					_root.castleH =  -  BMDamange;
					destroyThis();
				}
			}
			else if (_root.startDir == 'LEFT')
			{
				if (this.x <= 0)
				{
					_root.castleH =  -  BMDamange;
					destroyThis();
				}
			}

			// If Game over then destory the minion
			if (_root.gameOver)
			{
				destroyThis();
			}
			
			// Remove all remaining minions if the castle has been destoryed
			if (health <= 0)
			{
				destroyThis();
			}
		}


		// Removing functions and object from the scene 
		public function destroyThis():void
		{
			_root.enemiesLeft--;
			this.removeEventListener(Event.ENTER_FRAME, eFrameEvents);
			this.parent.removeChild(this);
		}
	}
	


}