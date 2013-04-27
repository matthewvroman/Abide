package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.ld48.ChallengeManager;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class Main extends Sprite 
	{
		
		private var _challengeManager:ChallengeManager;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			_challengeManager = new ChallengeManager(stage);
		}
		
	}
	
}