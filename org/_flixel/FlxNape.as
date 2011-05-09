/**
 * FlxNape
 * Version 1.0
 * December 13th 2010
 * 
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel 
{
	import nape.geom.AABB;
	import nape.phys.Body;
	import nape.phys.PhysObj;
	import nape.space.UniformSleepSpace;
	import nape.util.Tools;
	import nape.geom.Vec2;
	import nape.phys.Material;
	
	public class FlxNape 
	{
		public var space:UniformSleepSpace;
		private var floor:Body;
		private var roof:Body;
		private var leftWall:Body;
		private var rightWall:Body;
		public var members:Array;
		public var halfX:int;
		public var halfY:int;
		
		public function FlxNape() 
		{
			members = new Array();
			
			halfX = FlxG.width / 2;
			halfY = FlxG.height / 2;
		}
		
		public function createBox(bx:int, by:int, bwidth:int, bheight:int, vx:int, vy:int, vw:int, bstatic:Boolean, material:Material):Body
		{
			var temp:Body = Tools.createBox(bx, by, bwidth, bheight, vx, vy, vw, bstatic, material);
				
			space.addObject(temp);
			
			Registry.canvas.addChild(temp.graphic);
			
			return temp;
		}
		
		public function createBoxFromSprite(flxObject:FlxObject, vx:Number, vy:Number, fixed:Boolean, material:Material):PhysObj
		{
			var temp:Body = Tools.createBox(flxObject.x, flxObject.y, flxObject.width, flxObject.height, vx, vy, 0, fixed, material);
			
			temp.px = flxObject.x;
			temp.py = flxObject.y;
			
			trace("cbs", temp.id);
			
			return add(temp, flxObject);
		}
		
		public function add(physObject:PhysObj, flxObject:FlxObject = null):PhysObj
		{
			if (flxObject)
			{
				trace("member add");
				members.push( { p: physObject, f: flxObject } );
				
				space.addObject(physObject);
			}
			else
			{
				space.addObject(physObject);
			}
			
			Registry.canvas.addChild(physObject.graphic);
			
			return physObject;
		}
		
		public function createUniformSleepSpace(minX:Number, minY:Number, maxX:Number, maxY:Number, cellSize:int = 20, gravityX:Number = 0, gravityY:Number = 300):UniformSleepSpace
		{
			if (space)
			{
				throw Error("space has already been constructed");
				return;
			}
			
			space = new UniformSleepSpace(new AABB(minX, minY, maxX, maxY), cellSize, new Vec2(gravityX, gravityY));
			
			return space;
		}
		
		/**
		 * Created a boundary / box around the physics world, so objects cannot leave
		 * 
		 * @param	thickness
		 * @param	floorMaterial
		 * @param	wallMaterial
		 */
		public function addWorldBox(thickness:int, floorMaterial:Material, wallMaterial:Material, addFloor:Boolean = true, addRoof:Boolean = true, addLeftWall:Boolean = true, addRightWall:Boolean = true):void
		{
			if (addFloor)
			{
				floor = Tools.createBox(halfX, FlxG.height, FlxG.width, thickness, 0, 0, 0, true, floorMaterial);
				space.addObject(floor);
				Registry.canvas.addChild(floor.graphic);
			}
			
			if (addRoof)
			{
				roof = Tools.createBox(halfX, 0, FlxG.width, thickness, 0, 0, 0, true, floorMaterial);
				space.addObject(roof);
				Registry.canvas.addChild(roof.graphic);
			}
			
			if (addLeftWall)
			{
				leftWall = Tools.createBox(0, halfY, thickness, FlxG.height, 0, 0, 0, true, wallMaterial);
				space.addObject(leftWall);
				Registry.canvas.addChild(leftWall.graphic);
			}
			
			if (addRightWall)
			{
				rightWall = Tools.createBox(FlxG.width, halfY, thickness, FlxG.height, 0, 0, 0, true, wallMaterial);
				space.addObject(rightWall);
				Registry.canvas.addChild(rightWall.graphic);
			}
			
		}
		
		public function update(deltaTimer:Number = 0.02, elastic:Number = 4, inelastic:Number = 4):void
		{
			if (space)
			{
				members.forEach(updateFlxObjects);
				
				space.step(deltaTimer, elastic, inelastic);
			}
		}
		
		private function updateFlxObjects(value:Object, index:int, array:Array):void
		{
			FlxObject(value.f).x = PhysObj(value.p).px;
			FlxObject(value.f).y = PhysObj(value.p).py;
			
			//	rotation and stuff?
			//FlxObject(value.f).y = PhysObj(value.p).py;
		}
	}

}