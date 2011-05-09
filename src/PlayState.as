package  
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	import org.flixel.*;
	import com.photonstorm.flixel.FlxVelocity;
	import com.photonstorm.flixel.FlxMath;

	public class PlayState extends FlxState
	{
		[Embed(source = '../assets/mushroom.png')] private var MousePng:Class;
		
		public function PlayState() 
		{
			super();
		}
		
		override public function create():void
		{			
			super.create();
			
			add(Registry.stars);
			add(Registry.background);
			add(Registry.enemies);
			add(Registry.bullets);
			add(Registry.player);
			add(Registry.fx);
			add(Registry.weapons);
			add(Registry.debug);
			Registry.debug.scrollFactor = new FlxPoint();
			
			FlxG.mouse.show(MousePng);
			
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(Registry.player, Registry.background);
			FlxG.collide(Registry.bullets, Registry.background);
			FlxG.collide(Registry.enemies, Registry.background);
			
			Registry.debug.text = "";
			Registry.debug.text += Registry.weapons.ammo + "/" + Registry.weapons.clipSize + " " + Registry.weapons.clips;
			Registry.debug.text += (Registry.weapons.isReloading)? "Reloading...":"";
			Registry.debug.text += " " + int(FlxU.getAngle(Registry.player.getMidpoint(), FlxG.mouse.getWorldPosition()));
			if( Laser.end ) Registry.debug.text += " " + int(FlxU.getAngle(Registry.player.getMidpoint(), Laser.end));
			
			
		}
	}
}