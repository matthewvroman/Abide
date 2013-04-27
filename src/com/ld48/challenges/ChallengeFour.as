package com.ld48.challenges 
{
	import com.ld48.Challenge;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Matt
	 */
	public class ChallengeFour extends Challenge 
	{
		private var mouseDown:Boolean = false;
		private var _mouseDownPos:Number;
		
		public function ChallengeFour() 
		{
			
		}
		
		
		override public function start():void
		{
			super.start();
		
			clip = new Challenge04();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			mouseDown = true;
			_mouseDownPos = mouseX;
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			mouseDown = false;
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			if (!mouseDown) return;
			
			var scaleNum:Number = clip.item.scaleX;
			scaleNum += ( this.mouseX - _mouseDownPos) / 640;
			clip.item.scaleX = scaleNum;
			clip.item.scaleY = scaleNum;

			if (scaleNum < 0 || scaleNum>200) {
				onComplete();
			}
			
		}
		
		override public function cleanup():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		

	}

}