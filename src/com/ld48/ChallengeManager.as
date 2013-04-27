package com.ld48 
{
	import com.ld48.challenges.ChallengeOne;
	import com.ld48.challenges.ChallengeTwo;
	import com.ld48.challenges.ChallengeThree;
	import com.ld48.ChallengeGroup;
	import fl.transitions.TweenEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.filters.*;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeManager 
	{
	
		private var _stage:Stage;
		
		private var _currentChallengeGroupNumber:int=-1;
		private var _currentChallengeNumber:int = 0;
		private var _lastChallenge:Challenge;
		private var _currentChallenge:Challenge;
		private var _currentChallengeGroup:ChallengeGroup;
		private var _currentBackground:MovieClip;
		private var _currentForeground:MovieClip;
		private var _challengeGroups:Vector.<ChallengeGroup> = new Vector.<ChallengeGroup>();
		private var _challenges:Vector.<Challenge> = new Vector.<Challenge>();
		
		private var _playingSequence:Boolean = false;
		
		public function ChallengeManager(stage:Stage) 
		{
			_stage = stage;
			
			init();
		}
		
		private function init():void
		{
			GameEventDispatcher.addEventListener(GameEvent.CHALLENGE_COMPLETE, onChallengeComplete);
			GameEventDispatcher.addEventListener(GameEvent.CHALLENGE_FAILED, onChallengeFailed);
			
			_challengeGroups.push(new ChallengeGroup());
			_challengeGroups.push(new ChallengeGroup());
			
			nextChallenge();
		}
		
		private function setupBackground():void
		{
			if (_currentBackground != null)
			{
				_stage.removeChild(_currentBackground);
				_currentBackground == null;
			}
			_currentBackground = _challengeGroups[_currentChallengeGroupNumber].background;
			_stage.addChildAt(_currentBackground, 1);
		}
		
		private function setupForeground():void
		{
			if (_currentForeground != null)
			{
				_stage.removeChild(_currentForeground);
				_currentForeground == null;
			}
			_currentForeground = _challengeGroups[_currentChallengeGroupNumber].foreground;
			_currentForeground.mouseChildren = false;
			_currentForeground.mouseEnabled = false;
			_stage.addChild(_currentForeground);
		}
		
		private function nextChallenge():void
		{
			
			_currentChallengeNumber++;
			
			if (_currentChallengeGroupNumber == -1 || _currentChallengeNumber > _challengeGroups[_currentChallengeGroupNumber].numChallenges)
			{
				_currentChallengeGroupNumber++;
				_currentChallengeNumber = 1;
				
				_currentChallengeGroup = _challengeGroups[_currentChallengeGroupNumber];
				
				playStartSequence();
				
				//check if we're on our last group
				if (_currentChallengeGroupNumber > _challengeGroups.length)
				{
					//done
				}
				
			}
			
			setupBackground();
			
			if (_currentChallenge != null)
			{
				_lastChallenge = _currentChallenge;
				_lastChallenge.cleanup();
			}
			
			_currentChallenge = _challengeGroups[_currentChallengeGroupNumber].challenges[_currentChallengeNumber - 1];
			
			if (!_playingSequence)
			{
				switchChallenges();
			}
			
			setupForeground();
			
			
			
			trace("added " + _currentChallenge + " to stage");

		}
		
		public function playStartSequence():void
		{
			_stage.addChild(_currentChallengeGroup.startSequence);
			_stage.addEventListener(Event.ENTER_FRAME, onSequenceAdvance);
			_playingSequence = true;
		}
		
		
		public function onSequenceAdvance(e:Event):void
		{
			if (_currentChallengeGroup.startSequence.totalFrames == _currentChallengeGroup.startSequence.currentFrame)
			{
				_stage.removeChild(_currentChallengeGroup.startSequence);
				_stage.removeEventListener(Event.ENTER_FRAME, onSequenceAdvance);
				_playingSequence = false;
				//continue with challengs
				switchChallenges();
			}
		}
		
		
		public function switchChallenges():void
		{
			var motionBlur:BlurFilter = new BlurFilter();
			motionBlur.quality = 3;
			motionBlur.blurX = 10;
			motionBlur.blurY = 0;
			
			//old challenge
			if (_lastChallenge)
			{
				var _lastChallengeInTween:Tween = new Tween(_lastChallenge, "x", None.easeIn, _lastChallenge.x, -_stage.width, 0.65, true);
				_lastChallengeInTween.addEventListener(TweenEvent.MOTION_FINISH, onLastChallengeTweenFinish);
				_lastChallenge.filters = [motionBlur];
			}
			
			//new challenge
			_stage.addChild(_currentChallenge);
			_currentChallenge.x = _stage.width;
			var _challengeInTween:Tween = new Tween(_currentChallenge, "x", None.easeIn, _currentChallenge.x, 0, 0.65, true);
			_challengeInTween.addEventListener(TweenEvent.MOTION_FINISH, onChallengeTweenFinish);
			
			
			_currentChallenge.filters = [motionBlur];
			
			_currentChallenge.start();
			setupForeground();
		}
		
		
		private function onChallengeTweenFinish(e:TweenEvent):void
		{
			_currentChallenge.filters = [];
		}
		
		private function onLastChallengeTweenFinish(e:TweenEvent):void
		{
			_stage.removeChild(_lastChallenge);
			_lastChallenge = null;
		}
		
		public function onChallengeComplete(e:GameEvent):void
		{
			
			//setTimeout(nextChallenge, 2500);
			nextChallenge();
			/*
			if (_currentChallengeNumber > _challenges.length - 1)
			{
				onAllChallengesComplete();
			}else
			{
				nextChallenge();
			}*/
		}
		
		public function onChallengeFailed(e:GameEvent):void
		{
			_currentChallengeNumber = 0;
			nextChallenge();
		}
		
		public function onAllChallengesComplete():void
		{
			
		}
	}

}