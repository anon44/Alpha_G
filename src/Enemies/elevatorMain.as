package Enemies 
{

/**
	 * This is the main class for the elevator
	 * UPDATE: It looks like I got the new code working.
	 */
	import org.flixel.*;
	import SideScroller.*;
	
	
	public class elevatorMain extends FlxSprite
	{
		/**
		 * Constants
		 */
		public var startPoint:FlxPoint;
		public var endPoint:FlxPoint;
		public var down:Boolean;
		public static const RUNSPEED:int = 25;
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
			//_x = new int;
			
			
			solid = true; //This seems to fix the knock down issue Old code: solid = false;
		}
		
		/**
		 * Create the animations 
		 * Will add later
		 */
		
		 
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
						
						velocity.y = -155;		
						
						
						
						/*if (Player._velocityX >= 0) if(Player._x - 100 <= x) //New code that we are testing
						{
							velocity.x  = Player._velocityX; //When the player is moving faster than the elevator, the elevator will move towards the player
						}*/
							
						/*if (Player._velocityX <= -1) if(Player._x + 100 >= x) //New code that we are testing
						{
							velocity.x = Player._velocityX; //When the player is going backwards, the elevator moves back
						}*/
					}
				
					else if (y <= startPoint.y)//If the elevator has not reached the upper limit then send the elevator up
					{
						y = startPoint.y; //Reached the bottom 
						//x = Player._x + (Player._width / 2 ) - (width / 2); 
							
						velocity.y = +200; //+155 Going down
						//velocity.y = velocity.y * _curFrame *_curFrame-2 +200; //Trying something new
						
						//IF the player is with a 100 pixel of one of the elevators then attack the player head on
						/*if (Player._velocityX <= 0)*/ if(Player._x - 100 <= x || Player._x + 100 >= x) //New code that we are testing 
						{
							x = Player._x + (Player._width / 2 ) - (width / 2);
							//velocity.x = Player._velocityX;
							velocity.y = +300;
						}
						else
						{
							velocity.x = RUNSPEED;
							velocity.y = +300;
						}
						
					}//End of else if
			}//End of movement 
		 }
		 
		 /**
		  * To fix our little playstate issue
		  */
		 override public function destroy():void
		 {
			 
		 }
	}//End of Class
	
}//End of Package