package SideScroller 
{
	import org.flixel.*;
	import SideScroller.*;
	import Objects.*;
	/**
	 * Player-controlled entity
	 * Nothing for now 
	 * Recreate player for next release
	 */
	public class Player extends SideScrollerEntity
	{
		public static var _velocityX:int;
		public static var _x:int;
		public static var _y:int;
		public static var _width:int;
		public var startPosition:FlxPoint = new FlxPoint(150, 200);
		
		/**
		 * Constructor
		 */
		public function Player(X:int, Y:int)
		{
			super(startPosition.x, startPosition.y);
			loadGraphic(GameAssets.player, true, false, SideScrollerEntity.SIZE.x, SideScrollerEntity.SIZE.y);
			health = 5; //Start off with 5 health points 
			//For the elevators
			_velocityX = new int;
			_x = new int;
			_y = new int;
			_width = new int;
			
		}
		
		override protected function createAnimations():void
		{
			addAnimation("idle",[0],0,false);
			addAnimation("walk",[1,2,3,0],10,true);
			addAnimation("walk_back",[3,2,1,0],10,true);
			addAnimation("flail",[1,2,3,0],18,true);
			addAnimation("jump",[4],0,false);
		}
		
		/**
		 * Check for uaer input to control this entity 
		 */
		override protected function updateControls():void
		{
			super.updateControls();
			//check keys
			var movement:FlxPoint = new FlxPoint(); 
			//Smooth slidey walking controls
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
				acceleration.x -= drag.x;
			if(FlxG.keys.RIGHT)
				acceleration.x += drag.x;
			if(isTouching(FLOOR))
			{
				//Jump controls
				if(FlxG.keys.justPressed("SPACE"))
				{
					velocity.y = -acceleration.y*0.51;
					play("jump");
				}//Animations
				else if(velocity.x > 0)
					play("walk");
				else if(velocity.x < 0)
					play("walk_back");
				else
					play("idle");
			}
			else if(velocity.y < 0)
				play("jump");
			else
				play("flail")
			
			//Here we are stopping the player form moving off the screen
			//with a little border or margin of 4 pixels
			if (x > FlxG.worldBounds.width - 4)
				x = FlxG.worldBounds.width - 4;
			if (x < 4)
				x = 4;
			
			
			//Update the position to the elevators
			_velocityX = velocity.x;
			_x = x;
			_y = y;
			_width = width;
		}
		
		public function hit():void
		{
			if (flickering)
				return
			//FlxG.play(GameAssets.playerHit);
			flicker(1.3);
			health -= 1;
		}
		
		/**
		 * Check to see if the object is gone
		 */
		override public function kill():void
		{
			if (!alive)
				return;
			super.kill();
			//Play sound
			//play("squished");
			//FlxG.play(GameAssets.gLaugh);
			//Gibs creator
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-150,170);
			_gibs.setYSpeed(-200,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 300;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.blood, 15, 10, true, 0.5);
			FlxG.state.add(_gibs);
			
			_gibs.x = this.x + width / 2;
			_gibs.x = this.y + height / 2;
			_gibs.recycle();
			//Gibs emitted upon death
			if (_gibs != null)
			{
				_gibs.at(this);
				_gibs.start(true, 5, 0, 50);
			}
		}
		
		  /**
         * This resets values of the Frog instance.
         */
        public function restart():void
        {
			x = startPosition.x;
			y = startPosition.y;
        }
	}//End of class

}//End of namespace