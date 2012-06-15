package Enemies
{
	import Enemies.elevatorMain;
	import org.flixel.*;
	import Enemies.*;
	import GameAssets;
	import SideScroller.*;
	
	public class Elevator2 extends elevatorMain
	{	
		/**
		 * Constructor
		 */
		public static var _x:int;
		 
		public function Elevator2(X:int, Y:int):void
		{
			super(X, Y);
			loadGraphic(GameAssets.elevatorPIC, true, true, 173, 270);
			startPoint = new FlxPoint(followObject._x, 75);
			endPoint = new FlxPoint(0, 275); //Change this back later
			down = true;
			moves = false;
			velocity.y = RUNSPEED;
			immovable = true;
			allowCollisions = FlxObject.DOWN;
			_x = new int;
			solid = true; //This seems to fix the knock down issue 
		}
		
		override protected function createAnimations():void
		{
			addAnimation("down", [0], 0, false);
			addAnimation("up", [1], 0, false);
			
		}
		
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