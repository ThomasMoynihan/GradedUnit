package{
////////////////////////////////////////////////////////////////////
// DEBUG OPTION TO BE ABLE TO ADD MORE TURRET 
// NOT IN FINAL GAME REALISE 
////////////////////////////////////////////////////////////////////
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	
	public class EmptyBlock extends MovieClip{
		
		
		private var _root:MovieClip;
		
		public function EmptyBlock(){
			
			//this.addEventListener(Event.ADDED, beginClass);
			
			//this.addEventListener(Event.ENTER_FRAME, eFrameEvents);
		}
		
		
		private function beginClass(e:Event):void{
			_root = MovieClip(root);
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);
			this.addEventListener(MouseEvent.CLICK, thisClick);
		}
		private function eFrameEvents(e:Event):void{
			if(_root.gameOver){//remove this and listeners if game is over
				this.removeEventListener(Event.ENTER_FRAME, eFrameEvents);
			this.removeEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);
				this.removeEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);
				this.removeEventListener(MouseEvent.CLICK, thisClick);
				MovieClip(this.parent).removeChild(this);
			}
		}
		private function thisMouseOver(e:MouseEvent):void{
			//changing the background so the user know's it's clickable
			this.graphics.beginFill(0x006600);
			this.graphics.drawRect(0,0,25,25);
			this.graphics.endFill();
		}
		private function thisMouseOut(e:MouseEvent):void{
			//changing the background back
			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(0,0,25,25);
			this.graphics.endFill();
		}
		private function thisClick(e:MouseEvent):void{
			_root.makeTurret(this.x,this.y);//make the turret
			//remove all the listeners so it can't be clicked on again
			this.buttonMode = false;
			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(0,0,25,25);
			this.graphics.endFill();
			this.removeEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);
			this.removeEventListener(MouseEvent.CLICK, thisClick);
		}
	}
}