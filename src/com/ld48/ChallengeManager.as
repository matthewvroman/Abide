package com.ld48 
{
	import com.ld48.challenges.*;
	import com.ld48.groups.ChallengeGroupOne;
	import com.ld48.groups.*;
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
		private var _currentChallenge:Challenge=null;
		private var _currentChallengeGroup:ChallengeGroup;
		private var _currentBackground:MovieClip;
		private var _currentForeground:MovieClip;
		private var _challengeGroups:Vector.<ChallengeGroup> = new Vector.<ChallengeGroup>();
		private var _challenges:Vector.<Challenge> = new Vector.<Challenge>();
		
		private var _playingSequence:Boolean = false;
		
		private var motionBlur:BlurFilter = new BlurFilter();
			
		
		public function ChallengeManager(stage:Stage) 
		{
			_stage = stage;
			
			init();
		}
		
		private function init():void
		{
			GameEventDispatcher.addEventListener(GameEvent.CHALLENGE_COMPLETE, onChallengeComplete);
			GameEventDispatcher.addEventListener(GameEvent.CHALLENGE_FAILED, onChallengeFailed);
			
			
			motionBlur.quality = 3;
			motionBlur.blurX = 10;
			motionBlur.blurY = 0;
			
			_challengeGroups.push(new ChallengeGroupThree());
			_challengeGroups.push(new ChallengeGroupOne());
			_challengeGroups.push(new ChallengeGroupTwo());
			
			
			
			start();
		}
		
		private function start():void
		{
			_currentChallengeGroupNumber = 1;
			_currentChallengeNumber = 1;
			
			_currentChallengeGroup = _challengeGroups[_currentChallengeGroupNumber-1];
			_currentChallenge = _currentChallengeGroup.challenges[_currentChallengeNumber-1];
			
			setupBackground();
			playStartSequence();
			setupForeground();
		}
		
		private function setupBackground():void
		{
			if (_currentChallengeNumber == 1)
			{
				//first time in group
				_stage.addChild(_currentChallengeGroup.background);
				var tween:Tween = new Tween(_currentChallengeGroup.background, "alpha", None.easeIn, 0, 1, 0.75, true);
				tween.addEventListener(TweenEvent.MOTION_FINISH, onBackgroundTweenComplete);
				
			}else{
			
				if (_currentBackground != null)
				{
					_stage.removeChild(_currentBackground);
					_currentBackground == null;
				}
				
				_currentBackground = _currentChallengeGroup.background;
				_stage.addChildAt(_currentBackground, 1);
			}
		}
		
		private function onBackgroundTweenComplete(e:TweenEvent):void
		{
			if (_currentBackground != null)
				{
					_stage.removeChild(_currentBackground);
					_currentBackground == null;
				}
				
				_currentBackground = _currentChallengeGroup.background;
		}
		
		private function setupForeground():void
		{
			if (_currentForeground != null)
			{
				_stage.removeChild(_currentForeground);
				_currentForeground == null;
			}
			_currentForeground = _challengeGroups[_currentChallengeGroupNumber-1].foreground;
			_currentForeground.mouseChildren = false;
			_currentForeground.mouseEnabled = false;
			_stage.addChild(_currentForeground);
		}
		
		private function nextChallenge():void
		{
			
			_currentChallengeNumber++;
			
			if (_currentChallengeGroupNumber == -1 || _currentChallengeNumber > _currentChallengeGroup.numChallenges)
			{
				_currentChallengeGroupNumber++;
				_currentChallengeNumber = 1;
				
				//check if we're on our last group
				if (_currentChallengeGroupNumber > _challengeGroups.length)
				{
					//done
				}
				
				_currentChallengeGroup = _challengeGroups[_currentChallengeGroupNumber-1];
				
				
				
			}
			
			setupBackground();
			
			if (_currentChallengeNumber == 1)
			{
				playStartSequence();
			}
			
			if (_currentChallenge != null)
			{
				_lastChallenge = _currentChallenge;
			}
			
			_currentChallenge = _currentChallengeGroup.challenges[_currentChallengeNumber - 1];
			
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
			_currentChallengeGroup.startSequence.gotoAndPlay(1);
			_playingSequence = true;
		}
		
		
		public function onSequenceAdvance(e:Event):void
		{
			if (_currentChallengeGroup.startSequence.totalFrames == _currentChallengeGroup.startSequence.currentFrame)
			{
				trace("end of sequence");
				_stage.removeChild(_currentChallengeGroup.startSequence);
				_stage.removeEventListener(Event.ENTER_FRAME, onSequenceAdvance);
				_playingSequence = false;
				//continue with challengs
				switchChallenges();
			}
		}
		
		
		public function switchChallenges():void
		{
			
			
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
			
			_currentChallenge.cleanup();
			setTimeout(nextChallenge, 2000);
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