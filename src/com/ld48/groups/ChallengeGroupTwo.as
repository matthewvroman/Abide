package com.ld48.groups 
{
	import com.ld48.ChallengeGroup;
	import com.ld48.challenges.*;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeGroupTwo extends ChallengeGroup 
	{
		
		public function ChallengeGroupTwo() 
		{
			
		}
		
		override public function init():void
		{
			background = new ActTwoBackground();
			foreground = new ActOneForeground();
			
			_challenges.push(new ChallengeSix());
			_challenges.push(new ChallengeTwo());
			_challenges.push(new ChallengeThree());
			_challenges.push(new ChallengeFour());
			_challenges.push(new ChallengeFive());
			
			startSequence = new StartSequence();
			_actLabel = "Rule Two";
			_actName = "Organize";
			startSequence.seqText.textField.text = _actLabel;
			startSequence.seqSubText.textField.text = _actName;
		}
		
	}

}