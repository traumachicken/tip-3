package  
{
	import adobe.utils.CustomActions;
	import com.photonstorm.flixel.FlxBitmapFont;
	import flash.utils.getTimer;
	import org.flixel.*;
	/**
	 * ...
	 * @author 
	 */
	public class WeaponManager extends FlxGroup
	{
		[Embed(source='../assets/50AE_Fire1.mp3')] protected var SndHandCannon:Class;
		[Embed(source='../assets/9mm_Single_Reload_000.mp3')] protected var SndReload:Class;
		
		public var currType:uint = 0;
		public var newType:uint;
		private var bulletDelay:int;
		private var lastFired:int;
		
		public var ammo:int;
		public var clips:int;
		public var clipSize:int;
		public var reloadDelay:int;
		public var startReload:int;
		public var isReloading:Boolean;
		
		
		public static const HANDGUN:uint = 0;
		public static const SMG:uint = 1;
		public static const AR:uint = 2;
		
		public function WeaponManager() 
		{
			bulletDelay = 475; // HANDGUN
			ammo = 12;
			clips = 7;
			clipSize = 12;
			reloadDelay = 1300;
			isReloading = false;
		}
		
		override public function update():void
		{
			//super.update();
			// リロード中
			if (isReloading)
			{
				// リロードが完了したか
				if (getTimer() > startReload + reloadDelay)
				{
					// クリップをひとつ減らし弾を回復
					clips --;
					ammo = clipSize;
					isReloading = false;
				}
			}
			
			// debug
		}
		
		public function fire():void
		{
			if (ammo <= 0 )	return;
			if (isReloading)	return;
			
			if (getTimer() > lastFired + bulletDelay)
			{
				lastFired = getTimer();
				Laser.rayWithEnemy();
				FlxG.play(SndHandCannon, 0.6);
				ammo --;
			}
		}
		
		public function reload():void
		{
			// クリップが残っていない
			if ( clips <= 0 )	return;
			// 既にリロード中
			if ( isReloading )	return;
			
			FlxG.play(SndReload, 0.6);
			isReloading = true;
			startReload = getTimer();
			
			
		}
		
		public function changeWeapon(newType:uint):void
		{
			
		}
		
	}

}