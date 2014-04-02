package 
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.DisplayObjectContainer;

	public class Enemy extends MovieClip
	{	var bmionion:firstmionon = new firstmionon();
		private var _root:MovieClip;
		public var xSpeed:int;// speed going left right
		public var ySpeed:int;// speed up and odwn
		public var maxSpeed:int = 4;// max speed
		public var health:int = 7;
		public var BMDamange:int = 5;


		public function Enemy()
		{
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}

		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);

			//going back to start direction
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

			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			////// NEEDS TO BE OPTIMIZED PROBLEMS MAKING GAME LAG. CRITAL BUG
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			addChild(bmionion);

			//this.graphics.beginFill(0xFF0000);
//			this.graphics.drawCircle(12.5,12.5,5);
//			this.graphics.endFill();

		}
		private function eFrameEvents(e:Event):void
		{

			this.x +=  xSpeed;
			this.y +=  ySpeed;

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

			if (_root.gameOver)
			{
				destroyThis();
			}
			if (health <= 0)
			{
				destroyThis();
			}
		}



		public function destroyThis():void
		{
			_root.enemiesLeft--;
			this.removeEventListener(Event.ENTER_FRAME, eFrameEvents);
			this.parent.removeChild(this);
		}
	}
	// destoy this;


}