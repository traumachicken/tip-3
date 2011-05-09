package  
{
	import com.photonstorm.flixel.FlxBitmapFont;
	import org.flixel.*;
	public class Registry
	{
		public static var stars:Starfield = new Starfield;
		public static var background:BackGround = new BackGround;
		public static var player:Player = new Player;
		public static var bullets:BulletManager = new BulletManager;
		public static var enemies:EnemyManager = new EnemyManager;
		public static var fx:Fx = new Fx;
		public static var weapons:WeaponManager = new WeaponManager;
		public static var debug:FlxText = new FlxText(0, 0, 300, "");
		
		public function Registry()
		{
			
		}
		
	}

}