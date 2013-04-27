package 
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.display.NativeMenu;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import com.ld48.ChallengeManager;
	import fl.transitions.Tween;
	import fl.transitions.easing.None;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class Main extends Sprite 
	{
		private var _tickPosition:Number;
		private var _tickLastPosition:Number;
		private var _t:int;
		public static var deltaTime:Number = 0;
		private var _framePeriod:Number = 1;
		
		private var _challengeManager:ChallengeManager; 
		private var _menu:Menu;
		
		private var _waitingForMenuFade:Boolean = false;
		private var _playBtnStartScale:Number;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			_t = getTimer();
			this.addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			_menu = new Menu();
			_menu.foreground.mouseChildren = false;
			_menu.foreground.mouseEnabled = false;
			_playBtnStartScale = _menu.playBtn.inside.scaleX;
			stage.addChild(_menu);
			_menu.playBtn.addEventListener(MouseEvent.CLICK, onPlayBtnClicked);
			_menu.playBtn.addEventListener(MouseEvent.MOUSE_OVER, onPlayBtnMouseOver);
			_menu.playBtn.addEventListener(MouseEvent.MOUSE_OUT, onPlayBtnMouseOut);
		}
		
		private function onPlayBtnClicked(e:MouseEvent):void
		{
			_menu.playBtn.removeEventListener(MouseEvent.CLICK, onPlayBtnClicked);
			_menu.playBtn.removeEventListener(MouseEvent.MOUSE_OVER, onPlayBtnMouseOver);
			_menu.playBtn.removeEventListener(MouseEvent.MOUSE_OUT, onPlayBtnMouseOut);
			_menu.play();
			_waitingForMenuFade = true;
			trace("mouse clicked");
			// entry point
			
		}
		
		private function OnEnterFrame(e:Event):void
		{
			
			if (_waitingForMenuFade && _menu)
			{
				if (_menu.currentFrame == _menu.totalFrames)
				{
					setTimeout(removeMenu,2000);
					_waitingForMenuFade = false;
					_challengeManager = new ChallengeManager(stage);
				}
			}
			
			_tickPosition = int((getTimer() % 1000) / _framePeriod);
			var t:int = getTimer();
			deltaTime = (t- _t) * 0.001;
			_t = t;

		   if (_tickLastPosition != _tickPosition)
		   {
				_tickLastPosition = _tickPosition;
		   }
		}
		
		private function removeMenu():void
		{
			stage.removeChild(_menu);
			_menu = null;
		}
		
		private function onPlayBtnMouseOver(e:MouseEvent):void
		{
			var tweenX:Tween = new Tween(_menu.playBtn.inside, "scaleX", None.easeIn, _playBtnStartScale, (_playBtnStartScale*.10)+_playBtnStartScale, 0.15, true);
			var tweenY:Tween = new Tween(_menu.playBtn.inside, "scaleY", None.easeIn, _playBtnStartScale, (_playBtnStartScale*.10)+_playBtnStartScale, 0.15, true);
		}
		
		private function onPlayBtnMouseOut(e:MouseEvent):void
		{
			var tweenX:Tween = new Tween(_menu.playBtn.inside, "scaleX", None.easeIn, _menu.playBtn.inside.scaleX, _playBtnStartScale, 0.15, true);
			var tweenY:Tween = new Tween(_menu.playBtn.inside, "scaleY", None.easeIn, _menu.playBtn.inside.scaleY, _playBtnStartScale, 0.15, true);
		}
		
	}
	
}