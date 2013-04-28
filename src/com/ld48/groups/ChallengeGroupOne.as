package com.ld48.groups 
{
	import com.ld48.ChallengeGroup;
	import com.ld48.challenges.*;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeGroupOne extends ChallengeGroup 
	{
		
		public function ChallengeGroupOne() 
		{
			
		}
		
		override public function init():void
		{
			background = new ActOneBackground();
			foreground = new ActOneForeground();
			
			_challenges.push(new ChallengeOne());
			_challenges.push(new ChallengeTwo());
			_challenges.push(new ChallengeThree());
			_challenges.push(new ChallengeFour());
			_challenges.push(new ChallengeSix());
			
			startSequence = new StartSequence();
			_actLabel = "Rule One";
			_actName = "Reduce";
			startSequence.seqText.textField.text = _actLabel;
			startSequence.seqSubText.textField.text = _actName;
		}
		
	}

}