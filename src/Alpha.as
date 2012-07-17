package

{

	import org.flixel.*;
	import Menus.*;
	import levels.PlayState;

	[SWF(width="680", height="480", backgroundColor="#000000")]

	[Frame(factoryClass="Preloader")]



	public class Alpha extends FlxGame

	{

		public function Alpha()

		{

			super(340,240, PlayState, 2, 60, 60); //Change this later
			forceDebugger = true;
		}

	}

}

