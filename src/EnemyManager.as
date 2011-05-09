package  
{
	import org.flixel.*;
	import flash.utils.getTimer;

	public class EnemyManager extends FlxGroup
	{
		private var lastReleased:int;
		private var releaseRate:int = 1000;
		
		public function EnemyManager() 
		{
			super();
			
			for (var i:int = 0; i < 100; i++)
			{
				add(new Enemy);
			}
		}
		
		public function release():void
		{
			var enemy:Enemy = Enemy(getFirstAvailable());
			
			
			if (enemy)
			{
				enemy.launch();
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (getTimer() > lastReleased + releaseRate)
			{
				lastReleased = getTimer();
				
				release();
			}
		}
		
		public function bulletHitEnemy(enemy:FlxObject):void
		{
			//bullet.kill();
			
			enemy.hurt(1);
			
			//Registry.fx.explodeBlock(enemy.x, enemy.y);
			
			FlxG.score += 1;
		}
		
	}

}