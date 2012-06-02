package SideScroller 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class Humans extends FlxGroup
	{
		
		public function Humans() 
		{
			super();
		}
		
		public function addHuman(x:int, y:int):void
		{
			var tempHuman:Human = new Human(x, y);
			
			add(tempHuman);
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}