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
		private var _actLabel:String;
		private var _actName:String;
		private var _currentChallengeNumber:int;
		private var _currentChallenge:Challenge;
		private var _challenges:Vector.<Challenge> = new Vector.<Challenge>();
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
			background = new ActOneBackground();
			foreground = new ActOneForeground();
			
			_challenges.push(new ChallengeOne());
			_challenges.push(new ChallengeTwo());
			_challenges.push(new ChallengeThree());
			_challenges.push(new ChallengeFour());
			_challenges.push(new ChallengeFive());
			
			startSequence = new StartSequence();
			_actLabel = "Rule One";
			_actName = "Reduce";
			startSequence.seqText.textField.text = _actLabel;
			startSequence.seqSubText.textField.text = _actName;
		}
		
	}

}