package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeFive extends Challenge 
	{
		
		private var _items:Vector.<MovieClip> = new Vector.<MovieClip>();
		public function ChallengeFive() 
		{
			
		}
		
		override public function start():void
		{
			super.start();
		
			clip = new Challenge05();
			
			_items.push(clip.item1, clip.item2, clip.item3);
			for (var i:int = 0; i < _items.length; i++)
			{
				_items[i].addEventListener(MouseEvent.CLICK, onMouseClick);
			}

		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(e.currentTarget);
			mc.rotation += 45;
			if (Math.ceil(_items[0].rotation) == 90
			&& Math.ceil(_items[1].rotation) == 90
			&& Math.ceil(_items[2].rotation) == 90
			)
			{
				onComplete();
			}	
		}
		
		
		override public function cleanup():void
		{
			for (var i:int = 0; i < _items.length; i++)
			{
				_items[i].removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			_items = null;
		}
		
	}

}