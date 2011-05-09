package  
{
	import org.flixel.*;

	public class Fx extends FlxGroup
	{
		private var pixels:FlxGroup;
		private var pixels_counter:int;
		//private var jet:FlxEmitter;
		
		public function Fx() 
		{
			super();
			
			pixels = new FlxGroup();
			pixels_counter = 0;
			
			//	Here we create an FlxGroup containing 40 FlxEmitters, all the same, used when the aliens are shot/explode
			for (var i:int = 0; i < 40; i++)
			{
				var tempPixel:FlxEmitter = new FlxEmitter();
				tempPixel.setSize(8, 8);
				tempPixel.gravity = 200;
				tempPixel.setXSpeed(-50, 50);
				tempPixel.setYSpeed( -30, -60);
				tempPixel.setRotation(0, 0);	// VITAL!!!
				tempPixel.makeParticles(Pixel, 10, 0, true, 0);
				tempPixel.exists = false; // これやらんとgetFirstAvailable()で取得できない exists = true なってるから
				// やってもだめemitt終わっても exists = false にしてくんね
				pixels.add(tempPixel);
				
			}
			
			//
			//	Jet thrusters for trailing behind the ship
			//jet = new FlxEmitter();
			//jet.setSize(8, 8);
			//jet.angularVelocity = 0;
			//jet.gravity = 300;
			//jet.setXSpeed(-30, 30);
			//jet.setYSpeed(80, 120);
			//jet.setRotation(0, 0);	// VITAL!!!
			//jet.createSprites(Jets, 80, 0, true, 0, 0);
			//jet.delay = 0.01;
			//jet.start(false);
			
			add(pixels);
			//add(jet);
		}
		
		override public function update():void
		{
			super.update();
			
			//	We can't use jet.at(Registry.player) because we need to offset the x/y a little to make
			//	it look like the jets are coming from the bottom middle of the ship
			//jet.x = Registry.player.x + 4;
			//jet.y = Registry.player.y + 12;
		}
		
		public function explodeBlock(ax:int, ay:int):void
		{
			var pixel:FlxEmitter = pixels.members[pixels_counter];
			
			if (pixel)
			{
				pixel.x = ax;
				pixel.y = ay;
				pixel.start(true, 1);
			}
			
			if (pixels_counter++ >= pixels.length)	pixels_counter = 0;
		}
		
	}

}