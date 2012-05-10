package  Menus
{
	import org.flixel.*;
	import levels.*;
	
	/**
	 * This is the Menu State  
	 */
	public class MenuState extends FlxState
	{
			override public function create():void
		{
			FlxG.bgColor = 0xff3f3f3f;
			
			//Title
			var logo:FlxText = new FlxText(FlxG.width *0.5 -200, 40, 400, "Test Alpha");
			logo.setFormat(null, 24, 0xffffff, "center");
			add(logo);
			
			//Info
			var info:FlxText = new FlxText(FlxG.width * 0.5 -205, 80, 400, "Info: Press 'R' to reload the stage.");
			info.setFormat(null, 8, 0xffffff, "center");
			add(info);
			
			var info2:FlxText = new FlxText(FlxG.width *0.5 -205, 100, 400, "Press any key to start");
			info2.setFormat(null, 8, 0xffffff, "center");
			add(info2);
			
			var info3:FlxText = new FlxText(FlxG.width *0.5 -205, 120, 400, "Press 'i' for more information");
			info3.setFormat(null, 8, 0xffffff, "center");
			add(info3);
			
			//playbutton
			//playButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 100, "Click To Play", onPlay);
			//playButton.color = 0xffffff;
			
			//playButton.label.color = 0xff3f3f3f;
			//add(playButton);
			
			
			//Show the mouse
			//FlxG.mouse.show();
			
		}
		override public function update():void
		{
			
			
			if (FlxG.keys.any() && !FlxG.keys.I)
			{
				FlxG.fade(0xff000000, 2, onPlay);
				//FlxG.music.fadeOut(2);
			}
			else if (FlxG.keys.I)
			{
				FlxG.switchState(new Info());
			}
			
			super.update();	
			
		}
		
		protected function onPlay():void
		{
			//playButton.exists = false;
			FlxG.switchState(new PlayState());
		}
		public function MenuState() 
		{
			
		}
		
	}

}