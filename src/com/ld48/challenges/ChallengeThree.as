package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeThree extends Challenge 
	{
		private var items:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		public function ChallengeThree() 
		{
			
		}
		
		override public function start():void
		{
			super.start();	
			clip = new Challenge03();
			
			items.push(clip.item1, clip.item2, clip.item3);
			for (var i:int = 0; i<items.length; i++)
			{
				items[i].addEventListener(MouseEvent.CLICK, onMouseClick);
				items[i].gotoAndStop(i + 1);
			}
		
		}
		
		
		private function onMouseClick(e:MouseEvent):void
		{
			var item = MovieClip(e.currentTarget);
			if (item.currentFrame < item.totalFrames)
			{
				item.gotoAndStop(item.currentFrame + 1);
			}
			else
			{
				item.gotoAndStop(1);
			}
			
			var checkFrame = item.currentFrame;
			for (var i:int = 0; i < items.length; i++)
			{
				if (items[i].currentFrame != checkFrame)
				{
					return;
				}
			}
			
			onComplete();
		}
		
		override public function cleanup():void
		{
			for (var i:int = 0; i<items.length; i++)
			{
				items[i].removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			items = null;
		}
		
	}

}