package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import com.ld48.MathHelper;
	import flash.display.DisplayObject;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeTwo extends Challenge 
	{

		private var items:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var currentItem:MovieClip;
		
		public function ChallengeTwo() 
		{
			
		}
		
		override public function start():void
		{
			super.start();
			clip = new Challenge02();
			
			clip.box.mouseChildren = false;
			clip.box.mouseEnabled = false;
			
			
			for (var i:int = 0; i < clip.numChildren; i++)
			{
				var child:DisplayObject = clip.getChildAt(i);
				if (child is MovieClip && child.name != "box")
				{
					child.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					child.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					items.push(child);
					
				}
			}
		
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			if (currentItem)
			{
				onMouseUp(e);
				return;
			}
			
			for (var i:int = 0; i < items.length; i++)
			{
				if (MovieClip(e.currentTarget) == items[i])
				{
					items[i].startDrag();
					currentItem = items[i];
				}
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			if (!currentItem) return;
			
			currentItem.stopDrag();
			if (DisplayObject(clip.box).getRect(this).containsRect(currentItem.getRect(this)))
			{
				for (var i:int = 0; i < items.length; i++)
				{
					if (items[i] == currentItem)
					{
						items[i].removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
						items[i].removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
						items.splice(i, 1);
						currentItem = null;
						if (items.length < 1)
						{
							onComplete();
						}
						return;
					}
				}
			}
			
			currentItem = null;
		}
		
		override public function cleanup():void
		{
			super.cleanup();
			for (var i:int = 0; i < items.length; i++)
			{
				if (items[i] == currentItem)
				{
					items[i].removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					items[i].removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				}
			}
			items = null;
		
		}
		
		
		
	}

}