package  SideScroller
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import levels.PlayState;
	import GameAssets;
	import Enemies.*;
	
	/**
	 * Human Entity 
	 *  Add sounds to the turnAround and Kill functions
	 *  Add Animations to scream and hide
	 *  Have body parts in a gib emitter 
	 *  Edit Sprites
	 */
	
	public class Human extends SideScrollerEntity 
	{
		
		public var _health:Number;
		public var _gibs:FlxEmitter;
		public var _timer:Number;
		private var myRadians:int;
		private var myDegrees:int;
		private var yChange:int;
		private var xChange:int;
		private var yMove:int;
		private var xMove:int;
		
		public function Human(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(GameAssets.imgHuman, true, true, 26, 25);
			facing = FlxObject.LEFT;
			_health = 1;
			solid = true;
			drag.x = 20; //This is here only for this stage, remove or adjust for the game
			acceleration.y = 50;
		}
		
		override protected function createAnimations():void
		{
			addAnimation("idle", [10], 0);
			addAnimation("running", [2, 3, 4, 5, 6, 7, 8, 9], 10, true);
			addAnimation("killed", [0, 1], 3, false);
		}
		override protected function updateControls():void
		{
			super.updateControls();
			if (alive)
			{	
				//New code
				this.xChange = Math.round(this.x - followObject._x);
				if (xChange < -300 || xChange > 300) //This if statment is going to tell the object to stop moving if the player is out of range
				//				-^-				-^- Adjust these values when applying to game 
				{
					this.velocity.x = 0; //Stop moving
				}
				else
				{
					this.xMove = Math.round(xChange / 200); //Start moving
					this.velocity.x += xMove;
				}
				
				if (followObject._x <= x-25 && facing == FlxObject.LEFT)
				{
					//FlxG.play(GameAssets.humanScream1, .5);
					turnAround();
				}
				else if (followObject._x>= x+25 && facing == FlxObject.RIGHT)
				{
					turnAround();
				}
	
				if (velocity.x > 0 || velocity.x < -1)
					play("running");
				else 
					play("idle");
			}
						
		}
		
		private function turnAround():void
		{
			if (facing == FlxObject.LEFT)
			{
				facing = FlxObject.RIGHT;
				this.velocity.x += xMove;
			}
			else
			{
				facing = FlxObject.LEFT;
				this.velocity.x += xMove;
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			_gibs = null;
		}
		
		override public function kill():void
		{
			if (!alive)
				return;
			alive = false;
			//moves = false; Leave this for now
			solid = false;
			play("killed");
			frame = 0;
			//Play sound 
			//FlxG.play(GameAssets.humanHit, .75);
			
			//Gibs creator
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-150,170);
			_gibs.setYSpeed(-200,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 300;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.blood, 20, 10, true, 0.5);
			FlxG.state.add(_gibs);
			
			
			_gibs.x = this.x + width / 2;
			_gibs.x = this.y + height / 2;
			_gibs.recycle();
			//Gibs emitted upon death
			if (_gibs != null)
			{
				_gibs.at(this);
				_gibs.start(true, 5, 0, 40);
			}

			//End of Gibs creator
			FlxG.elapsed += _timer;
			if (_timer >= 5)
			{
				super.kill();
			}
		}
		
	}//End of Class

}//End of Package 