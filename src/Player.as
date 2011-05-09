package  
{
	import com.photonstorm.flixel.FlxPowerTools;
	import org.flixel.*;
	import com.photonstorm.flixel.FlxMath;
	import flash.utils.getTimer;
	import com.photonstorm.flixel.FlxVelocity;

	public class Player extends FlxSprite
	{
		[Embed(source = '../assets/player.png')] private var playerPNG:Class;
		
		private var bulletDelay:int = 75;
		private var lastFired:int;
		private var speed:uint = 100;
		
		
		public function Player() 
		{
			super(300, 200, playerPNG);
			
			FlxG.camera.follow(this);
			
		}
		
		override public function update():void
		{
			super.update();
			
			velocity.x = 0;
			velocity.y = 0;
			drag.x = 100;
			drag.y = 100;
				
			//	Need to adds bound checking to these (as it can probably go too far left right now)
			if (FlxG.keys.A)
			{
				velocity.x -= speed;
			}
			
			if (FlxG.keys.D)
			{
				velocity.x += speed;
			}
			
			if (FlxG.keys.W)
			{
				velocity.y -= speed;
			}
			
			if (FlxG.keys.S)
			{
				velocity.y += speed;
			}
			
			
			//	Fire!
			if (FlxG.mouse.pressed() && getTimer() > lastFired + bulletDelay)
			{
				Registry.weapons.fire();
			}
			
			if (FlxG.keys.R)
			{
				Registry.weapons.reload();
			}
			
			angle = FlxU.getAngle(getMidpoint(), FlxG.mouse.getWorldPosition());
			
		}
		
		
	}

}