/*
 * Add a simple animation 
 * Add sounds to the turnAround and Kill functions 
 *  
 */
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
			loadGraphic(GameAssets.elevatorPIC, false, true);
			startPoint = new FlxPoint(0, 75);
			endPoint = new FlxPoint(0, 275); //Change this back later
			down = true;
			moves = false;
			velocity.y = RUNSPEED;
			immovable = true;
			allowCollisions = FlxObject.ANY;
			_x = new int;
			solid = true; //This seems to fix the knock down issue Old code: solid = false;
		}
		
		/**
		 * Update each frame
		 */
		override public function update():void
		{
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