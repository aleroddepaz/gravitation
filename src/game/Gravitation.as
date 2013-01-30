package game
{
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	import game.components.Teleport;
	import game.gameobjects.*;
	import nl.jorisdormans.phantom2D.cameras.CameraEase;
	import nl.jorisdormans.phantom2D.cameras.FollowObject;
	import nl.jorisdormans.phantom2D.cameras.RestrictToLayer;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class Gravitation extends Screen
	{
		private static const tileSize:int = 40;
		private static const physicsExecutionCount:int = 4;
		private static const particleLimit:int = 1000;
		
		private var particleLayer:ParticleLayer;
		private var objectLayer:TiledObjectLayer;
		private var planets:Vector.<Planet> = new Vector.<Planet>();
		private var pickups:Vector.<Pickup> = new Vector.<Pickup>();
		private var checkPoint:Checkpoint;
		
		public static var player:Player;
		
		public function Gravitation(width:Number, height:Number, numLevel:int)
		{
			super(width, height);
			addComponent(new Background(0x888888, 0xaaaaaa, 0x888888));
			addComponent(particleLayer = new ParticleLayer(width, height, particleLimit));
			addComponent(objectLayer = new TiledObjectLayer(tileSize, 20, 15, physicsExecutionCount));
			//particleLayer.sprite.filters = [new GlowFilter(0x8899dd)];
			objectLayer.sprite.filters = [new BlurFilter()];
			camera.addComponent(new FollowObject(null));
			camera.addComponent(new CameraEase());
			camera.addComponent(new RestrictToLayer(objectLayer));
			createThirdLevel();
			
		}
		
		private function addPickup(pickupClass:Class, planet:Planet, distance:Number):void
		{
			var position:Vector3D = calculatePosition(planet.position, distance, Math.random() * Math.PI * 2);
			objectLayer.addGameObject(pickups[pickups.length] = new pickupClass(planet), position);
		}
		
		private function addPlayer(planet:Planet, distance:Number):void
		{
			var position:Vector3D = calculatePosition(planet.position, distance, Math.PI / 4);
			objectLayer.addGameObject(checkPoint = new Checkpoint(planet), position);
		}
		
		private function calculatePosition(position:Vector3D, distance:Number, angle:Number):Vector3D 
		{
			var positionX:Number = position.x + distance * Math.cos(angle);
			var positionY:Number = position.y + distance * Math.sin(angle);
			return new Vector3D(positionX, positionY)
		}
		
		private function createFirstLevel():void
		{
			objectLayer.addGameObject(planets[0] = new Planet(null), new Vector3D(250, 400));
			objectLayer.addGameObject(planets[1] = new Planet(null), new Vector3D(550, 200));
			objectLayer.addGameObject(new Enemy(), new Vector3D(50, 50));
			addPickup(Pickup, planets[1], 60);
			addPlayer(planets[0], 60);
		}
		
		private function createSecondLevel():void
		{
			objectLayer.addGameObject(planets[0] = new Planet(null, 50, false), new Vector3D(400, 300));
			objectLayer.addGameObject(planets[1] = new Planet(planets[0]), new Vector3D(300, 200));
			objectLayer.addGameObject(planets[2] = new Planet(planets[0]), new Vector3D(300, 400));
			objectLayer.addGameObject(planets[3] = new Planet(planets[0]), new Vector3D(550, 300));
			addPickup(Pickup, planets[2], 60);
			addPickup(Pickup, planets[3], 60);
			addPlayer(planets[1], 60);
		}
		
		private function createThirdLevel():void
		{
			objectLayer.addGameObject(planets[0] = new Planet(null, 60, false), new Vector3D(400, 400));
			objectLayer.addGameObject(planets[1] = new Planet(planets[0]), new Vector3D(200, 200));
			objectLayer.addGameObject(planets[2] = new Planet(planets[0]), new Vector3D(600, 600));
			objectLayer.addGameObject(planets[3] = new Planet(planets[0]), new Vector3D(300, 300));
			planets[3].addComponent(new Teleport(planets[2]));
			objectLayer.addGameObject(planets[4] = new Planet(planets[0]), new Vector3D(500, 500));
			addPickup(Pickup, planets[2], 50);
			addPickup(Pickup, planets[4], 50);
			addPlayer(planets[1], 60);
		}
		
		private function createFourthLevel():void
		{
			objectLayer.addGameObject(planets[4] = new Planet(null, 50, false), new Vector3D(800, 400));
			objectLayer.addGameObject(planets[5] = new Planet(planets[4]), new Vector3D(720, 320));
			objectLayer.addGameObject(planets[6] = new Planet(planets[4]), new Vector3D(880, 320));
			objectLayer.addGameObject(planets[7] = new Planet(planets[4]), new Vector3D(720, 480));
			objectLayer.addGameObject(planets[8] = new Planet(planets[4]), new Vector3D(880, 480));
			addPickup(ShieldPickup, planets[6], 50);
			addPickup(Pickup, planets[7], 50);
		}
		
	}
}