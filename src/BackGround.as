package  
{
	import flash.geom.Point;
	import flash.text.engine.FontDescription;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import com.photonstorm.flixel.FlxVelocity;
	/**
	 * ...
	 * @author 
	 */
	public class BackGround extends FlxGroup
	{
		[Embed(source = '../assets/mapCSV_Group1_Map2.csv', mimeType = 'application/octet-stream')] private var map1CSV:Class;
		[Embed(source = '../assets/tiles.png')] private var tilesPNG:Class;
		
		public var map:FlxTilemap;
		
		public function BackGround() 
		{
			super();
			
			map = new FlxTilemap();
			map.loadMap(new map1CSV, tilesPNG, 16, 16);
			//!!!!!!!!!!!!!!!!!!!!!!
			map.follow();
			add(map);
			
		}
		
		
	}

}