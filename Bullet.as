///////////////////////////////////////////////////////////////////////////
// By: Alan Yeats
// HNC COMPUTER GAME DEVELOPEMENT 
// GRADED UNIT
////////////////////////////////////////////////////////////////////////////
//	Use: 		To Create the bullets that attack the minions
////////////////////////////////////////////////////////////////////////////
package 
{

	import flash.display.MovieClip;
	import flash.events.*;

	public class Bullet extends MovieClip
	{
		private var _root:*;
		public var target;
		public var damage:int;
		public var slowness:int;
		private var xSpeed:Number;
		private var ySpeed:Number;
		private var maxSpeed:Number = 5;


		public function Bullet()
		{
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME,eFrame);
		}

		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);


			//bullet need to get image will import later
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawCircle(0,0,2);
			this.graphics.endFill();

		}
		private function eFrame(e:Event):void{
			var yDist:Number=target.y+12.5 - this.y; // how far the directionm
			var xDist:Number=target.x+12.5 - this.x;
			var angle:Number=Math.atan2(yDist,xDist);
			
			ySpeed=Math.sin(angle) * maxSpeed;
			xSpeed=Math.cos(angle) * maxSpeed;
			
			this.x +=  xSpeed;
			this.y +=  ySpeed;			
			
			if(this.hitTestObject(target)){
				target.health -=damage;
				target.maxSpeed -= slowness
				destoryThis();
			}
			if (target == null || _root.gameOver == true){
				destoryThis();
			}
		}
		
		public function destoryThis():void{
			this.removeEventListener(Event.ENTER_FRAME,eFrame);
			MovieClip(this.parent).removeChild(this);
		}
		
		
	}

}