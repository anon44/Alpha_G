package SideScroller 
{
	import flash.events.KeyboardEvent;
	import org.flixel.*;
	/**
	 * A moveable object in the game (player, people, etc)
	 * 
	 */
	public class SideScrollerEntity extends FlxSprite
	{
		/**
		 * Constants
		 */
		public static const RUNSPEED:int = 150;
		public static const SIZE:FlxPoint = new FlxPoint(14, 14); //size in pixels
		public static var _gibs:FlxEmitter;
		
		/**
		 * Constructor 
		 */
		public function SideScrollerEntity(X:int, Y:int):void 
		{
			super(X, Y);
			makeGraphic(SIZE.x, SIZE.y);//Basic box
			// movement
			maxVelocity.x = RUNSPEED;
			drag.x = maxVelocity.x * 4; // decelerate to a stop within 1/4 of a second
			velocity.x = 0;
			acceleration.y = 400;		//gravity
			solid = true;
			createAnimations();
		}
		
		/**
		 * Create the animations for this entity
		 */
		
		protected function createAnimations():void
		{
			
		}
		
		/**
		 * Update each timestep
		 */
		override public function update():void
		{
			updateHit();
			updateControls();
			updateAnimation();
			super.update();
		}
		
		protected function updateAnimations():void
		{//will fix this later
			
			
		}

		/**
		 *Check keyboard/mouse controls 
		 */
		protected function updateControls():void
		{
			acceleration.x = 0;
		}
		
		/*
		 * If the player gets hit
		 */
		public function updateHit():void
		{
			
		}
		
		/**
		 * Destory object 
		 */
		override public function destroy():void
		{
			super.destroy();
			_gibs = null;
		}
		
		/**
		 * If the player or NPC was hit and the health is less than zero play the kill animation and kill the object
		 */
		override public function kill():void
		{
			if (!alive)
				return;
			super.kill();
		}
		
		
	}

}