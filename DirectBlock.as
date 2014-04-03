///////////////////////////////////////////////////////////////////////////
// By: Alan Yeats
// HNC COMPUTER GAME DEVELOPEMENT 
// GRADED UNIT
////////////////////////////////////////////////////////////////////////////
//	Use: 		To Create the dirction blocks for the pathing
////////////////////////////////////////////////////////////////////////////
package 
{
	// Imports
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class DirectBlock extends MovieClip
	{	
		private var cooldown:int = 10;		// Set the cooldown
		private var _root:MovieClip;		
		private var directType:String;		// Direction type

		public function DirectBlock(type:String,xVal:int,yVal:int)
		{
			directType = type;
			this.addEventListener(Event.ADDED, beginClass);
			this.addEventListener(Event.ENTER_FRAME, eFrame);


			
			this.x = xVal;				 // setting the X coords to Xvalue
			this.y = yVal;				 // setting the Y coords to Yvalue
 		}
		// Runs only when the function is called
		private function beginClass(e:Event):void
		{
			_root = MovieClip(root);
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//		DEBUG: DRAW A PATH AT MOMENT WILL REMOVE WHEN HAVE MAP WITH GRAPHICS
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////
			this.graphics.beginFill(0x111111);
			this.graphics.drawRect(0,0,25,25);
			this.graphics.endFill();



				if (directType == 'START')		//if this is a start block
				{
												//then define the startDir and StartCoord based on it's coordinates
					if (this.x == 0)
					{
						
						_root.startDir = 'RIGHT';
						_root.startCoord = this.y;
					}
					else if (this.y == 0)
					{
						_root.startDir = 'DOWN';
						_root.startCoord = this.x;
					}
					else if (this.x == 525)
					{	
						_root.startDir = 'LEFT';
						_root.startCoord = this.y;
					}
					else if (this.y == 275)
					{	
						_root.startDir = 'UP';
						_root.startCoord = this.x;
					}
					else
					{
					}//this level won't work if not any of these values
				}
			
			else if (directType == 'FINISH')			//if this is a finish block
			{
														//then define the finDir based on it's coordinates
				if (this.x == 0)
				{	;
					_root.finDir = 'LEFT';
				}
				else if (this.y == 0)
				{	
					_root.finDir = 'UP';
				}
				else if (this.x == 525)
				{
					_root.finDir = 'RIGHT';
				}
				else if (this.y == 275)
				{
					_root.finDir = 'DOWN';
				}
				else
				{
				}
			}//this level won't work if not any of these values
		}
	


	// Runs every Frame in function being called
	private function eFrame(e:Event):void
	{

		if (_root.gameOver == true)
		{

				this.removeEventListener(Event.ENTER_FRAME, eFrame);
				MovieClip(this.parent).removeChild(this);

		}


		if (directType !='START' && directType != 'FINISH') // If its neither the start or end block
			{

				for (var i:int = 0; i<_root.enemyHolder.numChildren; i++) // Loop
				{
					var enTarget = _root.enemyHolder.getChildAt(i); //  create the traget from the enemy holder
			
			
					if (this.x >= enTarget.x - enTarget.width*.5 && this.x <= enTarget.x + enTarget.width*.5
					&& this.y >= enTarget.y - enTarget.height*.5 && this.y <= enTarget.y + enTarget.height*.5)
					{
				
						if (directType == 'UP')							// IF the Direcion is UP
						{
							_root.money += 1;							// Adds money 
							enTarget.xSpeed = 0;						// Sets X Speed
							enTarget.ySpeed =  -  enTarget.maxSpeed;	// Changes Y speed 
							
						}else if (directType == 'RIGHT')				// IF the Direcion is RIGHT
						{
							_root.money += 1;							// Adds money 
							enTarget.xSpeed = enTarget.maxSpeed;		// Change X Speed
							enTarget.ySpeed = 0;						// Sets Y Speed
							
						}else if (directType == 'DOWN')					// IF the Direcion is DOWN
						{
							_root.money += 1;							// Adds money 
							enTarget.xSpeed = 0;						// Sets X Speed
							enTarget.ySpeed = enTarget.maxSpeed;		// Changes Y Speed
							
						}else if (directType == 'LEFT')					// IF the Direcion is LEFT
						{
							_root.money += 1;							// Adds money
							enTarget.xSpeed = enTarget.maxSpeed;		// Changes X Speed
							enTarget.ySpeed = 0;						// Sets Y Speed
							
							
						}// End of Else IF
					}// End of IF
				}// End of FOR
			}//OF of IF
		}// End of Function
	}// end of class
}//END of package


