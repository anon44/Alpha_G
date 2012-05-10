package Objects 
{
	import org.flixel.*;
	import levels.PlayState;
	/**
	 * ...
	 * 
	 */
	public class coinEmitter extends FlxEmitter
	
	{
		
		public function coinEmitter(X:int, Y:int) 
		{
			super(X, Y, 5);
			gravity = 350;
			setRotation(0, 0);
			setXSpeed(0, 0);
			setYSpeed(0, 0);
		}
		
		
		override public function update():void
		{
			FlxG.collide(PlayState.floorGroup, this)
			for (var i:int = 0; i < maxSize; i++)
			{
				add(new Coin);
			}
			super.update();
		}
		
		
	}

}