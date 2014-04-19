///////////////////////////////////////////////////////////////////////////
// By: Alan Yeats
// HNC COMPUTER GAME DEVELOPEMENT 
// GRADED UNIT
////////////////////////////////////////////////////////////////////////////
//	Use: 		To Create the towers that slow down the minons 
////////////////////////////////////////////////////////////////////////////
package 
{	
	// Importing 
	import flash.display.MovieClip;
	import flash.events.*;

	/// Going to be very simmilar to normal turret but the bullets will add a slowness to the minions as well as a small amount of damage 
	
	public class SlowTurret extends MovieClip
	{
		var shootSS:turretsounds = new turretsounds();
		private var _root:MovieClip;
		
		// All Varible can be change if needed to balance the game
		
	
		private var angle:Number;								// the angle
		private var radiansToDegrees:Number = 180 / Math.PI;	// for rotation
		private var damage:int = 1;								// damange of bullet - Made very low to be able to 
		private var range:int = 100;							// shooting range
		private var enTarget;									// The target the turret is facing
		private var cTime:int = 0;								// time since last shot
		private var reloadTime:int = 36;						//time between shots
		private var canShoot:Boolean = true;					// can shot or not
		private var slowness:int = 2;							// what % slowness to minion


		public function SlowTurret()
		{

			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, everFrame);
		}


		// Runs only once when the function is called 
		private function beginClass(e:Event):void
		{	
			_root = MovieClip(root);
			// Draws Turrets and sends them to the stage.
			
			
			// basic turrent adding others after
			// draws basic graphics till get turrent 
			// http://www.adobe.com/devnet/flash/quickstart/loading_images_library_as3.html 
			// to import image
			this.graphics.beginFill(0x0033CC);
			this.graphics.drawCircle(0,0,12.5);
			this.graphics.beginFill(0x999999);
			this.graphics.drawRect(-2.5, 0, 5, 20);
			this.graphics.endFill();

		}
		// Runs every Frame the function is active 
		private function everFrame(e:Event):void
		{
			var distance:Number = range;	// distance to enemy
			enTarget = null;				// Makes sure the target is emtpy 


			// Finds the Target for the turret based on the distance to the minions
			
			for (var i:int=_root.enemyHolder.numChildren-1; i>=0; i--) // Loop 
			{
				var cEnemy = _root.enemyHolder.getChildAt(i);

				if (Math.sqrt(Math.pow(cEnemy.y - y,2) + Math.pow(cEnemy.x - x,2)) < distance)
				{
					enTarget = cEnemy;
				}// end of IF
			}// End of For
			
			// If a target has been found 
			if (enTarget!= null)
			{


				
				// checking the turret can shot
				if (canShoot)
				{
					shootSS.play();
					canShoot = false; 					// Reset canShoot 
					var pewpew:SBullet = new SBullet();	// Create a new bullet object
					pewpew.x = this.x;					// Setting the X Coords for the bullet to curret X
					pewpew.y = this.y;					// Setting the Y Coords for the bullet to curret Y

					
					pewpew.target = enTarget;			// Set the target to the bullets target
					pewpew.damage = damage;				// Setting the damage to the damange of the bullet
					pewpew.slowness = slowness;			// Setting the slowness to the bullet slownless effect
					_root.addChild(pewpew);				// Sending the bullet the stage
					
				}// inter if

			}// outer if
			
			if (! canShoot) // If they turret can't shoot 
			{
				cTime++;	//then continue the time
				
				
				if (cTime == reloadTime)	//if ime between shots has been long enough
				{
					canShoot = true;		//load the turret
					
					cTime = 0;				//and reset the time
					
				}// inter IF
				
			} // Outer IF



			if (_root.gameOver) // ends if when game finishes
			{
				// remove from stage
				
				this.removeEventListener(Event.ENTER_FRAME, everFrame);
				MovieClip(this.parent).removeChild(this);
			} // End of IF

		} // End of function
		
	} // End of Class

}// End of Package