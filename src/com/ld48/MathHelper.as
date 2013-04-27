package com.ld48 
{
	import flash.geom.Point;
	import Math;
	/**
	 * ...
	 * @author Matt
	 */
	public class MathHelper 
	{
		
		public function MathHelper() 
		{
			
		}
		
		public static function AddPoints(p1:Point, p2:Point):Point
		{
			return new Point(p1.x + p2.x, p1.y + p2.y);
		}
		
		public static function SubtractPoints(p1:Point, p2:Point):Point
		{
			return new Point(p1.x - p2.x, p1.y - p2.y);
		}
		
		public static function MultiplyPoints(p1:Point, p2:Point):Point
		{
			return new Point(p1.x * p2.x, p1.y * p2.y);
		}
		
		public static function MultiplyPointByNumber(p1:Point, n:Number):Point
		{
			return new Point(p1.x * n, p1.y * n);
		}
		
		public static function DistanceTwoPoints(x1:Number, x2:Number,  y1:Number, y2:Number):Number {
			var dx:Number = x1-x2;
			var dy:Number = y1-y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
	}

}