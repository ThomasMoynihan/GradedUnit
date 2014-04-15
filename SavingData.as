package  {
	
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	
	public class SavingData extends MovieClip  {

		public function SavingData() {
			sharedObject = SharedObject.getLocal( "mjwScores" );
		}
		
		public function setStat(totalM:Number): void{
			
			
			trace(totalMinions);
//			sharedObject.data.totalMinions = totalM;
//			trace(sharedObject.data.totalMinions);
//			sharedObject.flush();
			
		}

	}
	
}
