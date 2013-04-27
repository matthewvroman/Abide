package com.ld48 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Matt
	 */
	public class Challenge extends MovieClip
	{
		
		private var _clip:MovieClip;
		protected var _failed:Boolean=false;
		
		public function Challenge() 
		{

		}
		
		public function set clip(mc:MovieClip):void
		{
			if (_clip != null)
			{
				this.removeChild(_clip);
			}
			_clip = mc;
			this.addChild(_clip);
		}
		
		public function get clip():MovieClip
		{
			return _clip;
		}
		
		public function start():void
		{
			_failed = false;
		}
		
		public function cleanup():void
		{
			
		}
		
		protected function fail():void
		{
			_failed = true;
			GameEventDispatcher.dispatchEvent(new GameEvent(GameEvent.CHALLENGE_FAILED));
		}
		
		protected function onComplete():void
		{
			trace("On complete!");
			//notify challenge manager
			GameEventDispatcher.dispatchEvent(new GameEvent(GameEvent.CHALLENGE_COMPLETE));
		}
		
	}

}