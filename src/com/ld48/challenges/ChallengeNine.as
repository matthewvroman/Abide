package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeNine extends Challenge 
	{
		private var _items:Vector.<MovieClip> = new Vector.<MovieClip>();
		public function ChallengeNine() 
		{
			
		}
		
		override public function start():void
		{
			super.start();
		
			clip = new Challenge09();
			
			_items.push(clip.item1, clip.item2, clip.item3, clip.item4);
			for (var i:int = 0; i < _items.length; i++)
			{
				_items[i].addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_items[i].addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
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
			if ((DisplayObject(clip.quadOne).getRect(this).containsRect(clip.item1.getRect(this))
			&& DisplayObject(clip.quadTwo).getRect(this).containsRect(clip.item2.getRect(this))
			&& DisplayObject(clip.quadThree).getRect(this).containsRect(clip.item3.getRect(this))
			&& DisplayObject(clip.quadFour).getRect(this).containsRect(clip.item4.getRect(this))))
			{
				onComplete();
			}

		}
		
	}

}