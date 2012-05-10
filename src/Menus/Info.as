package Menus
{
	import org.flixel.*;
	import levels.PlayState;
	/**
	 * ...
	 * 
	 */
	public class Info extends FlxState
	{
		override public function create():void
		{
			FlxG.bgColor = 0xff3f3f3f;
			
			//Title
			var title:FlxText = new FlxText(FlxG.width *0.5 -200, 40, 400, "Info");
			title.setFormat(null, 24, 0xffffff, "center");
			add(title);
			
			var info:FlxText = new FlxText(FlxG.width * 0.5 -75, 80, 400, "Use the arrow keys to move.");		
			
			var info2:FlxText = new FlxText(FlxG.width *0.5 -75, 100, 400, "Press any key to start the game.");
			info.setFormat(null, 8, 0xffffff, "center");
			add(info2);
		}
		
		override public function update():void
		{
			if (FlxG.keys.any())
			{
				FlxG.fade(0xff000000, 2, onPlay);
			}
			
			super.update();
		}
		
		protected function onPlay():void
		{
			FlxG.switchState(new PlayState());
		}
		
		public function Info() 
		{
			
		}
		
	}

}