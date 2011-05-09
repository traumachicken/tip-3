package  
{
	import org.flixel.*;

	public class Enemy extends FlxSprite
	{
		[Embed(source = '../assets/space-baddie.png')] private var enemyPNG:Class;
		
		public var _thrust:Number;
		
		public function Enemy() 
		{
			super(0, 0, enemyPNG);
			
			exists = false;
		}
		
		public function launch():void
		{
			x = 50;
			y = 250;
			
			health = 4;
			exists = true;
			
			maxAngular = 120;
			angularDrag = 400;
			drag.x = 35;
			_thrust = 0;
		}
		
		override public function kill():void
		{
			super.kill();
			Registry.fx.explodeBlock(x, y);
			FlxG.score += 20;
		}
		
		override public function update():void
		{
			var da:Number = angleTowardPlayer();
			if (da < angle)
				angularAcceleration = -angularDrag;
			else if (da > angle)
				angularAcceleration = angularDrag;
			else
				angularAcceleration = 0;
				
			_thrust = FlxU.computeVelocity(_thrust, 10, drag.x, 60);
			FlxU.rotatePoint(0, _thrust, 0, 0, angle, velocity);
			
			
			super.update();
			
		}
		
		protected function angleTowardPlayer():Number
		{
			return FlxU.getAngle(this.getMidpoint(),Registry.player.getMidpoint());
		}
		
	}

}