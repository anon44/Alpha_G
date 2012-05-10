package  
{

	public class GameAssets 
	{
		
		
		//Player Stuff
		[Embed(source = "../src/Images/player.png")] public static var player:Class;
		[Embed(source = "../src/Images/hearts.png")] public static var heartPNG:Class;
		[Embed(source = "../src/Images/blood.png")] public static var blood:Class;
		//G Stuff
		[Embed(source = "../src/Images/elevator.png")] public static var elevatorPIC:Class;
		[Embed(source = "../src/Images/elevator2.png")] public static var elevator2PIC:Class;
		
		//Moving Objects
		[Embed(source = "../src/Images/human.png")] public static var humanPNG:Class;
		[Embed(source=  "../src/Images/humanNew.png")] public static var imgHuman:Class;
		//Map Stuff
		[Embed(source = "../src/MapData/mapCSV_Group1_Background.csv", mimeType = "application/octet-stream")] public static var backCSV:Class;
		[Embed(source = "../src/MapData/mapCSV_Group1_Main.csv", mimeType = "application/octet-stream")] public static var mainCSV:Class;
		[Embed(source = "../src/MapData/mapCSV_Group1_treeMap.csv", mimeType = "application/octet-stream")] public static var treeCSV:Class;
		[Embed(source = "../src/MapData/mapCSV_Group1_humanMap.csv", mimeType = "application/octet-stream")] public static var humanCSV:Class;
		[Embed(source = "../src/MapData/mapCSV_Group1_woodMap.csv", mimeType = "application/octet-stream")] public static var woodCSV:Class;
		[Embed(source = "../src/Images/backdrop.png")] public static var skyTilesPNG:Class;
		[Embed(source = "../src/Images/tiles.png")] public static var mapTilesPNG:Class;
		
		//Other Game objects
		[Embed(source = "../src/Images/coin16x16.png")] public static var coin16x16PNG:Class;
		[Embed(source = "../src/Images/leafBits.png")] public static var leafBits:Class;
		[Embed(source = "../src/Images/barkBits.png")] public static var barkBits:Class;
		[Embed(source = "../src/Images/wood.png")] public static var woodPNG:Class;
		
		[Embed(source = "../src/Images/woodBits.png")] public static var woodBits:Class;
		[Embed(source = "../src/Images/tree1.png")] public static var treePNG:Class;
		[Embed(source = "../src/Images/suv1.png")] public static var suv1PNG:Class;
		[Embed(source = "../src/Images/wheel1.png")] public static var wheel1PNG:Class;
		[Embed(source = "../src/Images/glass1.png")] public static var glass1PNG:Class;
		
	}

}