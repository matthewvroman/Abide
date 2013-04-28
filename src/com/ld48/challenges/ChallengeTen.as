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
	public class ChallengeTen extends Challenge 
	{
		private var blackKeys:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var whiteKeys:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		public function ChallengeTen() 
		{
			
		}
		
		override public function start():void
		{
			super.start();	
			clip = new Challenge10();
			
			whiteKeys.push(clip.item1, clip.item2, clip.item3, clip.item4, clip.item5, clip.item6, clip.item7);
			blackKeys.push(clip.item8, clip.item9, clip.item10, clip.item11, clip.item12);
			
			for (var i:int = 0; i<whiteKeys.length; i++)
			{
				whiteKeys[i].addEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			for (var j:int = 0; j < blackKeys.length; j++)
			{
				blackKeys[j].addEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			whiteKeys[1].gotoAndStop(2);
			whiteKeys[2].gotoAndStop(2);
			whiteKeys[5].gotoAndStop(2);
			
			blackKeys[0].gotoAndStop(2);
			blackKeys[3].gotoAndStop(2);
		
		}
		
		
		private function onMouseClick(e:MouseEvent):void
		{
			var item:MovieClip = MovieClip(e.currentTarget);
			if (item.currentFrame < item.totalFrames)
			{
				item.gotoAndStop(item.currentFrame + 1);
			}
			else
			{
				item.gotoAndStop(1);
			}
			
			for (var i:int = 0; i<whiteKeys.length; i++)
			{
				if (whiteKeys[i].currentFrame == 1)
				{
					return;
				}
			}
			
			for (var j:int = 0; j < blackKeys.length; j++)
			{
				if (blackKeys[j].currentFrame == 2)
				{
					return;
				}
			}
			
			onComplete();
		}
		
		override public function cleanup():void
		{
			super.cleanup();
			
			for (var i:int = 0; i<whiteKeys.length; i++)
			{
				whiteKeys[i].removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			for (var j:int = 0; j < blackKeys.length; j++)
			{
				blackKeys[j].removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			whiteKeys = blackKeys = null;
		}
		
	}

}