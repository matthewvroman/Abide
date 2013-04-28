package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeTwelve extends Challenge 
	{
		
		private var _items:Vector.<MovieClip> = new Vector.<MovieClip>();
		public function ChallengeTwelve() 
		{
			
		}
		
		override public function start():void
		{
			super.start();
		
			clip = new Challenge12();
			
			for (var i:int = 0; i < clip.numChildren; i++)
			{
				var child:DisplayObject= clip.getChildAt(i);
				if (child is MovieClip)
				{
					_items.push(child);
					child.addEventListener(MouseEvent.CLICK, onMouseClick);
				}
			}

		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(e.currentTarget);
			mc.rotation += 45;
			for (var i:int = 0; i < _items.length; i++)
			{
				if (_items[i].rotation < 89 || _items[i].rotation > 91)
				{
					trace(i + " : " + _items[i].rotation);
					return;
				}
			}
			
			onComplete();

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