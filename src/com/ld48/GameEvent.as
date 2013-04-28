package com.ld48
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const DEFAULT_GAME_EVENT:String = "DefaultGameEvent";
		public static const CHALLENGE_COMPLETE:String = "ChallengeComplete";
		public static const CHALLENGE_FAILED:String = "ChallengeFailed";
		public static const ALL_CHALLENGES_COMPLETE:String = "AllChallengesComplet";
		public var data:*;
		
		public function GameEvent(type:String=GameEvent.DEFAULT_GAME_EVENT, eventData:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, bubbles, cancelable);
			data = eventData;
		}
		
		override public function clone():Event {
			// Return a new instance of this event with the same parameters.
			return new GameEvent(type, data, bubbles, cancelable);
		}
	}
}