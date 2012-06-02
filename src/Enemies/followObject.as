package Enemies 
{
	import org.flixel.*;
	import SideScroller.*;
	/**
	 * This is the follower object that will follow the player accross the screen 
	 * This will help the elevator follow the player better
	 * This object will be the startPoint.x
	 * 
	 */
	
	public class followObject extends FlxSprite
	{
		/**
		 * Constants
		 */
		private var myRadians:int;
		private var myDegrees:int;
		private var yChange:int;
		private var xChange:int;
		private var yMove:int;
		private var xMove:int;
		public static var _x:int;
		public static var _a:int;
		
		public function followObject(X:int , Y:int) 
		{
			super(X, Y);
			drag.x = 25; //We are adding a little drag for now
			//loadGraphic(GameAssets.humanPNG); Hide this for now
			visible = false;
		}
		
		override public function update():void
		{
			myRadians = Math.atan2(Player._y - this.y, Player._x - this.x);
			myDegrees = Math.round((myRadians*180/Math.PI))
			//this.yChange = Math.round(PlayState4._player.y - this.y);
			this.xChange = Math.round(Player._x - this.x);
			//this.yMove = Math.round(yChange / 20);
			this.xMove = Math.round(xChange / 35);
			//this.y += yMove;
			this.x += xMove;
			_x = x;
			_a = acceleration.x;
		}
	}

}