package com.ld48.groups 
{
	import com.ld48.ChallengeGroup;
	import com.ld48.challenges.*;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeGroupThree extends ChallengeGroup 
	{
		
		public function ChallengeGroupThree() 
		{
			
		}
		
		override public function init():void
		{
			background = new ActThreeBackground();
			foreground = new ActOneForeground();
			
			
			_challenges.push(new ChallengeEleven());
			_challenges.push(new ChallengeTwelve());
			
			_challenges.push(new ChallengeNine());
			_challenges.push(new ChallengeEight());
			_challenges.push(new ChallengeSeven());
			
			

			startSequence = new StartSequence();
			_actLabel = "Rule Three";
			_actName = "Repeat";
			startSequence.seqText.textField.text = _actLabel;
			startSequence.seqSubText.textField.text = _actName;
		}
		
	}

}