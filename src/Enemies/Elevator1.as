package Enemies
{
	import Enemies.*;
	import org.flixel.*;
	import GameAssets;
	import SideScroller.*;
	
	public class Elevator1 extends elevatorMain
	{
		/**
		 * Constructor
		 */
		public static var _x:int;
		
		public function Elevator1(X:int, Y:int):void
		{
			super(X, Y);
			loadGraphic(GameAssets.elevatorPIC, true, true, 130, 240);//Size we need to make
			startPoint = new FlxPoint(followObject._x, -50);
			endPoint = new FlxPoint(0, 55); 
			down = true;
			moves = false;
			velocity.y = RUNSPEED;
			immovable = true;
			allowCollisions = FlxObject.ANY;
			_x = new int;
			solid = true; 
		}
		
		override protected function createAnimations():void
		{
			addAnimation("down", [0], 0, false);
			addAnimation("up", [1], 0, false);
		}
		/**
		 * Update each frame
		 */
		override public function update():void
		{
			if (down == true)
				play("down");
			else
				play("up");
			//For the humans
			 _x = x;
			super.updateControls();
		}
	
	/**
	 * To fix our little playstate issue
	*/
	override public function destroy():void
	 {
			 
	 }
	}//End of Class

}//End of Package