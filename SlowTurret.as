package 
{
	import flash.display.MovieClip;
	import flash.events.*;

	/// Going to be the sameish as the normal turret but slow minions down as its shots 
	public class SlowTurret extends MovieClip
	{

		private var _root:MovieClip;
		private var angle:Number;// the angle
		private var radiansToDegrees:Number = 180 / Math.PI;// for rotation
		private var damage:int = 1;// damange of bullet
		private var range:int = 100;// shooting range
		private var enTarget;
		private var cTime:int = 0;// time since last shot
		private var reloadTime:int = 24;//time between shots
		private var loaded:Boolean = true;// can shot or not
		private var slowness:int = 2;// what % slowness to minion


		public function SlowTurret()
		{

			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}

		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);

			// basic turrent adding others after
			// draws basic graphics till get turrent 
			// http://www.adobe.com/devnet/flash/quickstart/loading_images_library_as3.html 
			// to import image
			this.graphics.beginFill(0x0033CC);
			this.graphics.drawCircle(0,0,12.5);
			this.graphics.endFill();
			this.graphics.beginFill(0x999999);
			this.graphics.drawRect(-2.5, 0, 5, 20);
			this.graphics.endFill();

		}
		private function eFrameEvents(e:Event):void
		{
			var distance:Number = range;// distance to enemy
			enTarget = null;

			for (var i:int=_root.enemyHolder.numChildren-1; i>=0; i--)
			{
				var cEnemy = _root.enemyHolder.getChildAt(i);

				if (Math.sqrt(Math.pow(cEnemy.y - y,2) + Math.pow(cEnemy.x - x,2)) < distance)
				{
					enTarget = cEnemy;
				}
			}
			if (enTarget!= null)
			{

				this.rotation = Math.atan2((enTarget.y-y), enTarget.x-x)/Math.PI*180 - 90;
				if (loaded)
				{/// checking it can shot
					loaded = false;
					var pewpew:Bullet = new Bullet();
					pewpew.x = this.x;
					pewpew.y = this.y;

					pewpew.target = enTarget;
					pewpew.damage = damage;
					pewpew.slowness =slowness;
					_root.addChild(pewpew);
				}// inter if

			}// outer if
			if (! loaded)
			{//if it isn't loaded
				cTime++;//then continue the time
				if (cTime == reloadTime)
				{//if time has elapsed for long enough
					loaded = true;//load the turret
					cTime = 0;//and reset the time
				}
			}



			if (_root.gameOver)
			{// ends if when game finishes
				this.removeEventListener(Event.ENTER_FRAME, eFrameEvents);
				MovieClip(this.parent).removeChild(this);
			}

		}
	}

}