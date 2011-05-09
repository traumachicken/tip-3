package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	import com.photonstorm.flixel.FlxVelocity;
	import com.photonstorm.flixel.FlxMath;
	import flash.utils.getTimer;


	public class Bullet extends FlxSprite
	{
		[Embed(source = '../assets/bullet.png')] private var bulletPNG:Class;
		
		public var damage:int = 1;
		public var speed:int = 300;
		public var spawn:int = 0;
		
		public function Bullet() 
		{
			super(0, 0, bulletPNG);
			offset.x - 3;
			//	We do this so it's ready for pool allocation straight away
			exists = false;
		}

		public function fire(bx:int, by:int):void
		{
			x = bx;
			y = by;
			
			//get mosue x, y
			// x * cos()
			var r:Number = FlxVelocity.angleBetweenMouse(Registry.player);
			velocity.x = speed * Math.cos(r);
			velocity.y = speed * Math.sin(r);
						
			exists = true;
			
			spawn = getTimer();
		}
		
		override public function update():void
		{
			super.update();
			
			//	Bullet off the top of the screen?
			if (exists && y < -height)
			{
				exists = false;
			}
			
			//  Dead Timer
			if ( getTimer() >= spawn + 1000 )	{
				exists = false;
			}
		}
		
	}

}