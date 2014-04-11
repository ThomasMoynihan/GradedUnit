package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.net.SharedObject;
	
	public class SavingData extends MovieClip  {

		public function SavingData() {
			sharedObject = SharedObject.getLocal( "mjwScores" );
		}
		
		public function setStat(totalM:Number): void{
			
			_root.totalMinions = totalM.toString();
			sharedObject.data.totalMinions = totalM;
			trace(sharedObject.data.totalMinions);
			sharedObject.flush();
			
		}

	}
	
}
