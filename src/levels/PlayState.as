package levels
{
	/* //TODO: Clean up code
	 *  
	 * */
	import Menus.*;
	import Objects.Tree;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import GameAssets;
	import Enemies.*;
	import Objects.*;
	import SideScroller.*;

	public class PlayState extends FlxState
	{
		/**
		 * Constants
		 */
		public var levelSize:FlxPoint; 
		public var tileSize:FlxPoint;
		public var numTiles:FlxPoint;
		public var _level:FlxTilemap;
		public var backgGroup:FlxGroup;
		public static var floorGroup:FlxGroup;
		public static var _player:Player;
		public var _trees:FlxGroup;
		public var _tree:Tree;
		public var _menu:MenuState = new MenuState;
		public var _coinEmitter:FlxEmitter;
		public var _coin:Coin = new Coin;
		
		//Humans
		public var _humans:Humans;
		
		
		//Add the Enemies
		public var _followObject:followObject;
		public var _elevators:FlxGroup;
		public var _elevator1:Elevator1
		public var _elevator2:Elevator2;
		public var _elevatorStart:FlxPoint = new FlxPoint(-75, 275);
		
		//Other objects
		public var gameState:uint;
		private var healthBar:FlxBar;
		private const LIFE_X:int = 10;
		private const LIFE_Y:int = 10;
		private var lifeSprites:Array = [];
		private var scoreText:FlxText;
		public var guiGroup:FlxGroup;
		
		//Timers
		private var _timer:Number = 0;
		private var hideGameMessageDelay:Number = 0;
		private var _counter:Number = 0;
		private var _counter2:Number = 0;
		private var _counter3:Number = 0;
		
		override public function create():void
		{
			// Activate game by setting the correct state
			gameState = GameStates.PLAYING;
			
			//Creating the level
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			if (levelSize && tileSize)
				this.numTiles = new FlxPoint(Math.floor(levelSize.x / tileSize.x), Math.floor(levelSize.y / tileSize.y));
			
			/**
			 * Create the floor of the level
			 */
			var tiles:FlxTilemap;
			backgGroup = new FlxGroup;
			floorGroup = new FlxGroup;
			
			//Backgorund 
			tiles = new FlxTilemap();
			tiles.loadMap(new GameAssets.backCSV, GameAssets.skyTilesPNG, 192, 336);
			backgGroup.add(tiles);
			
			//Floor tiles
			tiles = new FlxTilemap();
			tiles.loadMap(new GameAssets.mainCSV, GameAssets.mapTilesPNG, 16, 16, 0, 0, 1);
			tiles.setTileProperties(40, FlxObject.UP);
			tiles.follow();
			floorGroup.add(tiles);
			
			/**
			 * Create the objects
			 */
			
			 //Coins
			_coinEmitter = new FlxEmitter(0, 0, 20);
			_coinEmitter.gravity = 350;
			_coinEmitter.setRotation(0, 0);
			_coinEmitter.setXSpeed(-160, 160);
			_coinEmitter.setYSpeed( -200, -300);
			
			for (var i:int = 0; i < _coinEmitter.maxSize; i++)
			{
				_coinEmitter.add(new Coin);
			}
			
			 
			//Trees
			 _trees = new FlxGroup;
			for (var x:int = 0; x < 20; x++)
			{
				_tree = new Tree(FlxG.random() * 1200, 240);//Use this as a for loop later
				_trees.add(_tree);
				//trees.add(new Tree(FlxG.random() * 1500, 240));//This is working but without the gibs
			}
			
			/**
			 * Create the player, NPCs, and the enemies
			 */
			
			//Player
			_player = new Player(150, 200);
			
			//Humans
			_humans = new Humans;
			
			//Enemies
			_elevators = new FlxGroup();
			_elevator1 = new Elevator1(_elevatorStart.x, _elevatorStart.y);
			_elevator2 = new Elevator2(_elevatorStart.x, _elevatorStart.y);
			_followObject  = new followObject(0, -100);
			_elevators.add(_followObject);
			_elevators.add(_elevator1);
			_elevators.add(_elevator2);
			
			/**
			 * Create the health text and bar
			 */
			
			 //Create the group
			 guiGroup = new FlxGroup();
			
			 //Create the hearts display
			var healthText:FlxText = new FlxText(0, 9, 100, "Health");
			healthText.color = 0xffffffff;
			
			//Make it scroll with the player
			healthText.scrollFactor.x = 0;
			healthText.scrollFactor.y = 0;  
			guiGroup.add(healthText);
			
			
			//Create the health bar
			healthBar = new FlxBar(40, 10, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, _player, "health", 0, 5);
			
			//Make it scroll with the player
			healthBar.scrollFactor.x = 0;
			healthBar.scrollFactor.y = 0;
			guiGroup.add(healthBar);
			
			//Score
			scoreText = new FlxText(155, 9, 100, "Score: 0");
			scoreText.color = 0xffffffff;
			scoreText.scrollFactor.x = 0;
			scoreText.scrollFactor.y = 0;
			guiGroup.add(scoreText);
			//End of GUI
			
			/**
			 * Add the camera
			 */
			FlxG.worldBounds = new FlxRect(0, 0);
			FlxG.camera.setBounds(0, 0, 1200, 336, true);
			FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);
				
			/**
			 * Now add the objects to the state
			 */
			add(backgGroup);
			add(floorGroup);
			add(_trees);
			add(_player);
			add(_coinEmitter);
			add(_humans);
			add(_elevators);
			add(guiGroup);
			createLives(3); //Create the lives 
		}
		
		override public function update():void
		{
			super.update();
			FlxG.collide(_coinEmitter, floorGroup);
			FlxG.collide(floorGroup, _player);
			FlxG.collide(_humans, floorGroup);
			FlxG.overlap(_elevators, _player, playerHits);
	
			//This will pause the G's movement for at least three secs before the game starts.
			//We will need three counters to get this to work
			_counter += FlxG.elapsed;   // This first one will start everything
			_counter2 += FlxG.elapsed;  // The second one is control the first elevator
			_counter3 += FlxG.elapsed;  // The third one is control the second elevator
			_timer += FlxG.elapsed;
			//Number one will start first
			if (_counter >= 1)
			{
				_elevator1.moves = true;    //This will go up first 
			}
			
			if (_elevator1.down == true)    //Check if the elevator is down 
			{
				_elevator1.moves = false;  //Then it is time to rise
				if (_counter2 >= 4)      //After 4 seconds
				{
					_elevator1.moves = true;
					_elevator1.down = false;
					_counter2 = 0;
				}
			}
			
			if (_elevator2.down == true)//Check if the elevator is down 
			{
				_elevator2.moves = false;//Then it is time to rise
				if (_counter3 >= 4 && _elevator1.down == true) //After 4 seconds and only if the other evelator is down
				{
					_elevator2.moves = true;
					_elevator2.down = false;
					_counter3 = 0;
				}
			}
			
			//Don't know why but this onyl works down here
			FlxG.overlap(_player, _coinEmitter, collectedCoin);
			FlxG.overlap(_elevators, _humans, killHuman);
			FlxG.overlap(_elevators, _trees, hitTree);
			
			//Spawner for the objects		
			if (_timer > 5)
			{
				addHumans();
				_timer = 0;
			}
			
			//if (hideGameMessageDelay == 0)
			//{
				//FlxG.switchState(_menu);
			//}
			//else
			//{
				//hideGameMessageDelay -= FlxG.elapsed;
			//}
			
			
			//Reload the State when testing
			//TODO: Delete this later
			if (FlxG.keys.justReleased("R"))
				FlxG.resetState();

			
		}//End of Updates
		
		/**
		 * Call the private events 
		 * 
		 * */
		private function addHumans():void
		{
			var x: int = FlxG.random()*1500;
			var y: int = 255;
			_humans.addHuman(x, y);
		}
		/**
		 * When the player gets hit
		 */
		private function playerHits(_elevators:FlxObject, _player:Player):void 
		{
			if (_player.y >= _elevators.y && _elevators.moves == false)//If the player is under the step
			{
				if (!_player.flickering)
				{
					_player.hit();
					if (_player.health <= 2)
					{
						healthBar.createFilledBar(0xff005100, 0xffc90606, false);
					}
					if (_player.health <= 0)
					{
						_player.kill();
						removeLife();
						restart();
					}
				}
			}
		}//End of playerHits1
		
		//Collect Coin
		private function collectedCoin(player:FlxObject, coin:FlxObject):void
		{
			FlxG.play(GameAssets.coinGet, 2);
			coin.kill();
			FlxG.score += 1;
			scoreText.text = "Score: " + FlxG.score.toString();
		}


		
		//Kill the Tress
		private	function hitTree(elevators:FlxObject, tree:FlxObject):void
		{
			tree.kill();
			_coinEmitter.x = tree.x;
			_coinEmitter.y = tree.y;
			_coinEmitter.start(true, 0, 0, 1);
			
		}
		
		//Kill the Humans
		private function killHuman(_elevators:FlxObject, _human:FlxObject):void
		{
			_human.kill()
			_coinEmitter.x = _human.x;
			_coinEmitter.y = _human.y;
			_coinEmitter.start(true, 0, 0, 1);
		}
		
		
		//This loop will create X number of lives
		private function createLives(value:int):void
		{
			for (var i:int = 0; i < value; i++) 
			{
				addLife();
			}
		}
		
		//This will create the life sprite
		private function addLife():void
		{
			var flxLife:FlxSprite = new FlxSprite(LIFE_X * totalLives + 300, LIFE_Y, GameAssets.heartPNG)//Change this later
			add(flxLife);
			flxLife.scrollFactor.y = 0;
			flxLife.scrollFactor.x = 0;
			lifeSprites.push(flxLife);
		}
		
		//This removes the life sprite from the display and from the array
		private function removeLife():void
		{
			var id:int = totalLives - 1;
			var sprite:FlxSprite = lifeSprites[id];
			sprite.kill();
			lifeSprites.splice(id, 1);
		}
		
		//A simple getter for Total Lives based on life sprite instances in lifeSprites array
		private function get totalLives():int
		{
			return lifeSprites.length;
		}
		
		//Reset the state if the player dies
		private function restart():void
		{
			//Make sure the player still has lives to restart
			if (totalLives == 0)
			{
				FlxG.fade(0xff000000, 2, gameOver);
			}
			else //Restart the player
			{
				healthBar.createFilledBar(0xff005100, 0xff00F400, false);
				_player.health = 5;
				_player.flicker(2);
				_player.reset(150, 200);
			}
		}
		
		//This is called when the game is over 
		private function gameOver():void
		{
			FlxG.switchState(new GameOver());
		}
		
		//Destory the Objects
		public function destory():void
		{
			super.destroy();
		}
		
	}//End of Class
	
}//End of Package

