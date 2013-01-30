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
		
		public function Gravitation(numLevel:int)
		{
			super(800, 600);
			camera.addComponent(new FollowObject(null));
			camera.addComponent(new CameraEase());
			switch(numLevel)
			{
				case 0:
					createFirstLevel();
					break;
				case 1:
					createSecondLevel();
					break;
				case 2:
					createThirdLevel();
					break;
				case 3:
					createFourthLevel();
					break;
				case 4:
					createFifthLevel();
					break;
			}
			camera.addComponent(new RestrictToLayer(objectLayer));
		}
		
		private function addPickup(pickupClass:Class, planet:Planet, distance:Number):void
		{
			var position:Vector3D = calculatePosition(planet.position, distance, Math.random() * Math.PI * 2);
			objectLayer.addGameObject(pickups[pickups.length] = new pickupClass(planet), position);
			Main.incrementPickups();
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
			addLayers(800, 600);
			objectLayer.addGameObject(planets[0] = new Planet(null), new Vector3D(250, 400));
			objectLayer.addGameObject(planets[1] = new Planet(null), new Vector3D(550, 200));
			addPickup(Pickup, planets[1], 60);
			addPlayer(planets[0], 60);
		}
		
		private function createSecondLevel():void
		{
			addLayers(800, 600);
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
			addLayers(1200, 1200);
			objectLayer.addGameObject(planets[0] = new Planet(null, 60, false), new Vector3D(600, 600));
			objectLayer.addGameObject(planets[1] = new Planet(planets[0]), new Vector3D(300, 300));
			objectLayer.addGameObject(planets[2] = new Planet(planets[0]), new Vector3D(900, 900));
			objectLayer.addGameObject(planets[3] = new Planet(planets[0]), new Vector3D(450, 450));
			objectLayer.addGameObject(planets[4] = new Planet(planets[0]), new Vector3D(750, 750));
			planets[3].addComponent(new Teleport(planets[2]));
			addPickup(Pickup, planets[2], 50);
			addPickup(Pickup, planets[4], 50);
			addPlayer(planets[1], 60);
		}
		
		private function createFourthLevel():void
		{
			addLayers(800, 600);
			objectLayer.addGameObject(planets[0] = new Planet(null, 50, false), new Vector3D(500, 300));
			objectLayer.addGameObject(planets[1] = new Planet(planets[0]), new Vector3D(420, 220));
			objectLayer.addGameObject(planets[2] = new Planet(planets[0]), new Vector3D(580, 220));
			objectLayer.addGameObject(planets[3] = new Planet(planets[0]), new Vector3D(420, 380));
			objectLayer.addGameObject(planets[4] = new Planet(planets[0]), new Vector3D(580, 380));
			objectLayer.addGameObject(planets[5] = new Planet(null), new Vector3D(150, 300));
			addPickup(Pickup, planets[1], 50);
			addPickup(Pickup, planets[2], 50);
			addPickup(Pickup, planets[3], 50);
			addPickup(Pickup, planets[4], 50);
			addPlayer(planets[5], 60);
		}
		
		private function createFifthLevel():void
		{
			addLayers(800, 600);
			objectLayer.addGameObject(planets[0] = new Planet(null), new Vector3D(150, 300));
			objectLayer.addGameObject(planets[1] = new Planet(null), new Vector3D(400, 300));
			objectLayer.addGameObject(planets[2] = new Planet(null), new Vector3D(650, 200));
			objectLayer.addGameObject(planets[3] = new Planet(null), new Vector3D(650, 400));
			objectLayer.addGameObject(new Enemy(30), new Vector3D(700, 300));
			addPickup(ShieldPickup, planets[1], 50);
			addPickup(Pickup, planets[2], 50);
			addPickup(Pickup, planets[3], 50);
			addPlayer(planets[0], 60);
		}
		
		private function createSixthLevel():void
		{
			addLayers(800, 600);
			objectLayer.addGameObject(planets[0] = new Planet(null), new Vector3D(150, 300));
			addPlayer(planets[0], 60);
		}
		
		private function addLayers(width:Number, height:Number):void 
		{
			addComponent(new Background(0x888888, 0xaaaaaa, 0x888888));
			addComponent(particleLayer = new ParticleLayer(width, height, particleLimit));
			addComponent(objectLayer = new TiledObjectLayer(tileSize, width / tileSize, height / tileSize, physicsExecutionCount));
			objectLayer.sprite.filters = [new BlurFilter()];
		}
		
	}
}