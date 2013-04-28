package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeEleven extends Challenge 
	{
		private var _items:Vector.<MovieClip> = new Vector.<MovieClip>();
		public function ChallengeEleven() 
		{
			
		}
		
		override public function start():void
		{
			super.start();
		
			clip = new Challenge11();
			
			for (var i:int = 0; i < clip.numChildren; i++)
			{
				var child:DisplayObject= clip.getChildAt(i);
				if (child is MovieClip)
				{
					_items.push(child);
					child.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					child.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				}
			}

		}
		
		override public function cleanup():void
		{
			super.cleanup();
			for (var i:int = 0; i < _items.length; i++)
			{
				_items[i].removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_items[i].removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			
			_items = null;
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			MovieClip(e.currentTarget).startDrag();
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			MovieClip(e.currentTarget).stopDrag();
			
			for (var i:int = 0; i < _items.length; i++)
			{
				if (_items[i].x == 320)
					return;
			}
			
			onComplete();
		}
	}

}