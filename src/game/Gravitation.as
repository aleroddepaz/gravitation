package game
{
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.cameras.CameraEase;
	import nl.jorisdormans.phantom2D.cameras.FollowObject;
	import nl.jorisdormans.phantom2D.cameras.RestrictToLayer;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class Gravitation extends Screen
	{
		private var particleLimit:int = 1000;
		private var particleLayer:ParticleLayer;
		private var objectLayer:TiledObjectLayer;
		
		private var planets:Vector.<Planet> = new Vector.<Planet>();
		private var pickups:Vector.<Pickup> = new Vector.<Pickup>();
		private var checkPoint:Checkpoint;
		
		public function Gravitation(width:Number, height:Number)
		{
			super(width, height);
			addComponent(new Background(0x888888, 0xaaaaaa, 0x888888));
			addComponent(particleLayer = new ParticleLayer(width, height, particleLimit));
			addComponent(objectLayer = new TiledObjectLayer(40, 30, 30, 4));
			particleLayer.sprite.filters = [new GlowFilter(0x8899dd)];
			objectLayer.sprite.filters = [new BlurFilter()];
			
			camera.addComponent(new FollowObject(null));
			camera.addComponent(new CameraEase());
			camera.addComponent(new RestrictToLayer(objectLayer));
			
			// Galaxy 1
			objectLayer.addGameObject(planets[0] = new Planet(null, 50, false), new Vector3D(300, 300));
			objectLayer.addGameObject(planets[1] = new Planet(planets[0]), new Vector3D(200, 200));
			objectLayer.addGameObject(planets[2] = new Planet(planets[0]), new Vector3D(200, 400));
			objectLayer.addGameObject(planets[3] = new Planet(planets[0]), new Vector3D(450, 300));
			addPickup(Pickup, planets[2], 60);
			addPickup(Pickup, planets[3], 60);
			
			// Galaxy 2
			objectLayer.addGameObject(planets[4] = new Planet(null, 50, false), new Vector3D(800, 400));
			objectLayer.addGameObject(planets[5] = new Planet(planets[4]), new Vector3D(720, 320));
			objectLayer.addGameObject(planets[6] = new Planet(planets[4]), new Vector3D(880, 320));
			objectLayer.addGameObject(planets[7] = new Planet(planets[4]), new Vector3D(720, 480));
			objectLayer.addGameObject(planets[8] = new Planet(planets[4]), new Vector3D(880, 480));
			addPickup(ShieldPickup, planets[6], 50);
			addPickup(Pickup, planets[7], 50);
			
			// Galaxy 3
			objectLayer.addGameObject(planets[9] = new Planet(null, 50, false), new Vector3D(800, 800));
			objectLayer.addGameObject(planets[10] = new Teleporter(planets[9]), new Vector3D(800, 700));
			planets[10].handleMessage("setDestination", planets[1]);
			
			objectLayer.addGameObject(checkPoint = new Checkpoint(planets[1]), new Vector3D(150, 150));
			
		}
		
		private function addPickup(pickupClass:Class, planet:Planet, distance:Number):void
		{
			var angle:Number = Math.random() * Math.PI * 2;
			var positionX:Number = planet.position.x + distance * Math.cos(angle);
			var positionY:Number = planet.position.y + distance * Math.sin(angle);
			var index:int = pickups.length;
			objectLayer.addGameObject(pickups[index] = new pickupClass(planet), new Vector3D(positionX, positionY));
		}
	}
}