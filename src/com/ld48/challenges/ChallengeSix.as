package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeSix extends Challenge 
	{
		
		private var items:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var item3Complete:Boolean;
		private var item2Complete:Boolean;
		private var item1Complete:Boolean;
		
		public function ChallengeSix() 
		{
			
		}
		
		override public function start():void
		{
			super.start();	
			clip = new Challenge06();
			
			item3Complete = item2Complete = item1Complete = false;
			
			items.push(clip.item1, clip.item2, clip.item3);
			for (var i:int = 0; i<items.length; i++)
			{
				items[i].addEventListener(MouseEvent.CLICK, onMouseClick);
			}
		}
	
		override public function cleanup():void
		{
			super.cleanup();
			for (var i:int = 0; i<items.length; i++)
			{
				items[i].removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			items = null;
		}
	
		private function onMouseClick(e:MouseEvent):void
		{
			var clicked:MovieClip = MovieClip(e.currentTarget);
			
			if (clicked == clip.item1 || clicked == clip.item2)
			{
				if (clicked.currentFrame < clicked.totalFrames)
				{
					clicked.gotoAndStop(clicked.currentFrame + 1);
				}
				else
				{
					clicked.gotoAndStop(1);
				}
				
				item1Complete = (clip.item1.currentFrame == clip.item1.totalFrames);
				item2Complete = (clip.item2.currentFrame == clip.item2.totalFrames);
			}
			else if (clicked == clip.item3)
			{
				clip.item3.rotation += 45;
				item3Complete = (Math.ceil(clip.item3.rotation) % 45 == 0);
			}
			
			if (item1Complete && item2Complete && item3Complete)
			{
				onComplete();
			}
		}
	}

}