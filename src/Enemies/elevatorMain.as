package Enemies 
{

/**
	 * This is the main class for the elevator
	 * UPDATE: It looks like I got the new code working.
	 * Add sounds to the turnAround and Kill functions 
	 *  Other Things:
	 *   Add kick functions
	 * 
	 */
	import org.flixel.*;
	import SideScroller.*;
	import levels.PlayState;
	import org.flixel.plugin.photonstorm.*;

	public class elevatorMain extends FlxSprite
	{
		/**
		 * Constants
		 */
		public var startPoint:FlxPoint;
		public var endPoint:FlxPoint;
		public var down:Boolean;
		public static const RUNSPEED:int = 25;
		public var xMove:int;
		public var xChange:int;
		//public static var _x:int;
		
		/**
		 * Constructor
		 */
		public function elevatorMain(X:int, Y:int):void
		{
			super(X, Y)
			startPoint = new FlxPoint();
			endPoint = new FlxPoint();
			moves = false;
			velocity.y = RUNSPEED;
			immovable = true;
			allowCollisions = FlxObject.ANY;
			solid = true; 
		}
		/**
		 * Create the animations 
		 */
		protected function createAnimations():void
		{
 
		} 
		//This is for to create the turn around animation for the step
		// This should work with the code
		private function turnAround():void
		{
			if (facing == FlxObject.LEFT)
			{
				facing = FlxObject.RIGHT;
			}
			else
			{
				facing = FlxObject.LEFT;
			}
		}
		 /**
		  * Update each time step
		  */
		 override public function update():void
		 {
			 super.update();
			 updateControls();
		 }
		 /**
		  * The basic movement of the elevators 
		  */
		 protected function updateControls():void
		 {
			if(moves) //If move is true then move
			{
					//Going up
					if(y >= endPoint.y)
					{   
						y = endPoint.y;
						
						down = true;
						
						FlxG.shake(.005, .1); // Shake the level
						//FlxG.play(GameAssets.stompBoom);
						velocity.y = -155;		
					}
				
					else if (y <= startPoint.y)//If the elevator has not reached the upper limit then send the elevator up
					{
						//To test if the player is to the right or the left of the g
						if (followObject._x > x-40 && facing == FlxObject.LEFT)
						{
							turnAround();
						}
						if (followObject._x < x+40 && facing == FlxObject.RIGHT)
						{
							turnAround();
						}
						x = followObject._x; //Follow the follow object
						y = startPoint.y; //Reached the bottom 
						
						velocity.y = +200;
						
						down = false;
						
						if (followObject._a == 0) //To detect if the player is near the step
						{
							//velocity.x = RUNSPEED; Leave this out for now
							velocity.y = +300; //Hard stomp
							//Sound here
							
						}
					}//End of else if
			}//End of movement 
			 
		 }//End of update
		 
		 /**
		  * To fix our little playstate issue
		  */
		 override public function destroy():void
		 {
			 
		 }
		
	}//End of Class
	
}//End of Package