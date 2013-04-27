package com.ld48 
{
	import com.ld48.Challenge;
	import com.ld48.challenges.*;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeGroup 
	{
		protected var _actLabel:String;
		protected var _actName:String;
		protected var _currentChallengeNumber:int;
		protected var _currentChallenge:Challenge;
		protected var _challenges:Vector.<Challenge> = new Vector.<Challenge>();
		public function get challenges():Vector.<Challenge> { return _challenges; }
		public function get numChallenges():int { return _challenges.length; }
		
		public var background:MovieClip;
		public var foreground:MovieClip;
		public var startSequence:StartSequence;
		
		public function ChallengeGroup() 
		{
			init();
		}
		
		public function init():void
		{
			
		}
		
	}

}