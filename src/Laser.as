package  
{
	import com.photonstorm.flixel.FlxBitmapFont;
	import com.photonstorm.flixel.FlxPowerTools;
	import org.flixel.*;
	import com.photonstorm.flixel.FlxMath;
	/**
	 * ...
	 * @author 
	 */
	public class Laser extends FlxSprite
	{
		public static var start:FlxPoint;
		public static var end:FlxPoint;	
		public static var cross:FlxPoint;
		public static var isCross:Boolean;
		public static var rad:Number;
		public static var dist:Number;
		public static var rayX:Number;
		public static var rayY:Number;
		static public var ang:Number;
		
		public function Laser()
		{
			
		}
		
		public static function isMouseRay(range:int = 10):Boolean
		{
			start = Registry.player.getMidpoint();
			end = new FlxPoint( (FlxG.mouse.x - start.x) * range + start.x,
									(FlxG.mouse.y - start.y) * range + start.y );
			Registry.stars.drawLine(start.x, start.y, FlxG.mouse.x, FlxG.mouse.y, 0xAA00FF00);
			var tmp:FlxPoint = new FlxPoint();
			isCross = !Registry.background.map.ray(start, end, tmp, 5);
			if (isCross) {
				cross = tmp;
				Registry.stars.drawLine(start.x, start.y, cross.x, cross.y, 0xAA0000FF);
				return true;
			}else {
				cross = end;
				return false;
			}
		}
		
		
		public static function rayWithEnemy(range:int = 1000, penetrate:Boolean = false):void
		{
			// mapとのray　必ずtrue
			if (!isMouseRay(range))	return;
			
			var hit:Boolean = false;
			var p:FlxPoint = Registry.player.getMidpoint();
			var d:FlxPoint = new FlxPoint(cross.x - p.x, cross.y - p.y);
			var tmin:Number = -100000;
			var q:FlxPoint = new FlxPoint();
			var closest:Number = range;
			var closest_enemy:int = 0;
			
			for (var i:uint = 0; i < Registry.enemies.length; i++)
			{
				if (intersectRayAABB(p, d, Registry.enemies.members[i], tmin, q)) {
					if (!Registry.enemies.members[i].onScreen() || !Registry.enemies.members[i].exists) continue;
					Registry.enemies.members[i].kill();
					Registry.stars.drawLine(p.x, p.y, q.x, q.y, 0xAAFF0000);
					Registry.fx.explodeBlock(q.x, q.y);
					if (FlxU.getDistance(p, q) < closest)
					{
						closest = FlxU.getDistance(p, q);
						
					}
					hit = true;
				}
			}
			
			if(!hit) Registry.fx.explodeBlock(cross.x, cross.y);
		}
		
		/*
		 * 点Pが移動ベクトルVに沿ってAABBと衝突するか否か
		 * tmin衝突距離
		 * q衝突点
		 */
		public static function intersectRayAABB(p:FlxPoint, d:FlxPoint, AABB:FlxSprite, tmin:Number, q:FlxPoint):Boolean
		{
			tmin = 0;
			var tmax:Number = 1;
			var pv:Vector.<Number> = new Vector.<Number>();
			var dv:Vector.<Number> = new Vector.<Number>();
			var av:Vector.<Number> = new Vector.<Number>();
			var sv:Vector.<Number> = new Vector.<Number>();
			pv[0] = p.x, pv[1] = p.y;
			dv[0] = d.x, dv[1] = d.y;
			av[0] = AABB.x, av[1] = AABB.y;
			sv[0] = AABB.width, sv[1] = AABB.height;
			for (var i:uint = 0; i < 2; i++)
			{
				// 最小値以下なら平行
				if (Math.abs(dv[i]) < 0.01)
				{
					if ( pv[i] < av[i] || pv[i] > av[i] + sv[i] ) return false;
				}
				else
				{
					var odd:Number = 1 / dv[i];
					var t1:Number = ( av[i] - pv[i] ) * odd;
					var t2:Number = ( av[i] + sv[i] - pv[i] ) * odd;
					if (t1 > t2) {
						var tmp:Number = t1;
						t1 = t2;
						t2 = tmp;
					}
					if (t1 > tmin) tmin = t1;
					if (t2 < tmax) tmax = t2;
					if (tmin > tmax) return false;
				}
			}
			
			// q = p + d * tmin;
			q.x = p.x + (d.x * tmin);
			q.y = p.y + (d.y * tmin);
			
			return true;
		}
		
	}

}