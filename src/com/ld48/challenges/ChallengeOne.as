package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeOne extends Challenge 
	{
		
		private var items:Vector.<MovieClip> = new Vector.<MovieClip>();
		public function ChallengeOne() 
		{
		}
		
		override public function start():void
		{
			super.start();
		
			clip = new Challenge01();
			//clip.addEventListener(MouseEvent.CLICK, onMouseClick);
			for (var i:int = 0; i < clip.numChildren; i++)
			{
				var child:DisplayObject = clip.getChildAt(i);
				if (child is MovieClip)
				{
					items.push(child);
					items[i].addEventListener(MouseEvent.CLICK, onMouseClick);
				}
				
			}
		
		}
		
		override public function cleanup():void
		{
			for (var i:int = 0; i < items.length; i++)
			{
				items[i].removeEventListener(MouseEvent.CLICK,onMouseClick);
			}
			items = null;
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			trace("mouse down!");
			for (var i:int = 0; i < items.length; i++)
			{
				if (items[i] == MovieClip(e.currentTarget))
				{
					items[i].alpha = 0;
					items[i].removeEventListener(MouseEvent.CLICK, onMouseClick);
					items.splice(i, 1);
					if (items.length <= 1)
					{
						onComplete();
					}
					return;
				}
			}
			onComplete();
		}
		
	}

}