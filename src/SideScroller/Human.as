package  SideScroller
{
	import org.flixel.*;
	import levels.PlayState;
	import GameAssets;
	import Enemies.elevatorMain;
	import Enemies.Elevator1;
	import Enemies.Elevator2;
	
	/**
	 * Human Entity 
	 *  Add sounds to the turnAround and Kill functions 
	 */
	
	public class Human extends SideScrollerEntity 
	{
		
		public var _health:Number;
		public var _gibs:FlxEmitter;
		public var _timer:Number;
		
		public function Human(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(GameAssets.imgHuman, true, true, 26, 25);
			_health = 1;
			solid = true;
			velocity.x = 0;
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
				if (Elevator2._x-50 <= x && facing == FlxObject.LEFT)
				{
					turnAround();
				}
				
				if (Elevator1._x-50 <= this.x && facing == FlxObject.LEFT)
				{
					turnAround();
				}
				if (Elevator1._x+50 >= x && facing == FlxObject.RIGHT)
				{
					turnAround();
				}
				
				
				
				if (Elevator2._x+50 >= x && facing == FlxObject.RIGHT)
				{
					turnAround();
				}
	
				if (velocity.x > 0 || velocity.x < -1)
					play("running");
				else 
					play("idle");
			}
						
		}
		/*private function removeSprite():void
		{
			super.update();
			
			var tx:int = int(x / 16);
			var ty:int = int(y / 16);
			
			if (facing == FlxObject.LEFT)
			{
				//	31 is the Collide Index of our Tilemap (which sadly isn't exposed in Flixel 2.5, so is hard-coded here. Not ideal I appreciate)
				if (Registry.map.getTile(tx - 1, ty) >= 31) //go to the right 
				{
					turnAround();
					return;
				}
			}
			
			else
			{
				//	31 is the Collide Index of our Tilemap (which sadly isn't exposed in Flixel 2.5, so is hard-coded here. Not ideal I appreciate)
				if (Registry.map.getTile(tx + 1, ty) >= 31 )
				{
					turnAround();
					return;
				}
			}
			
			//	Check the tiles below it
			
			if (isTouching(FlxObject.FLOOR) == false)
			{
				turnAround();
			}
		}*/
		
		private function turnAround():void
		{
			if (facing == FlxObject.LEFT)
			{
				facing = FlxObject.RIGHT;
				
				velocity.x = 50;
				
				//if (PlayState._elevator.x <= x || PlayState.__elevator2.x <= x )
				//{
					velocity.x = FlxG.random()*100;
				//}
			}
			else
			{
				facing = FlxObject.LEFT;
				
				//if (PlayState._elevator.x >= x+50 || PlayState.__elevator2.x >= x+50 )
				//{
					velocity.x = FlxG.random() * -100; 
				//}
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
			
			moves = false;
			solid = false;
			alive = false;
			play("killed");
			frame = 0;
			//Play sound
			
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