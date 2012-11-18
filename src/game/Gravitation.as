package game 
{
	import flash.filters.BlurFilter;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class Gravitation extends Screen
	{
		private var particleLimit:int = 600;
		private var particleLayer:ParticleLayer;
		private var objectLayer:TiledObjectLayer;
		
		public static const playerColor:uint = 0x3B3B3B;
		public static const planetColor:uint = 0x555555;
		public static const satelliteColor:uint = 0x3B3B3B;
		public static const pickupColor:uint = 0xffffff;
		public static var respawnPlanet:Planet;
		
		public function Gravitation(width:Number, height:Number)
		{
			super(width, height);
			addComponent(new Background(0x888888, 0xaaaaaa, 0x888888));
			addComponent(particleLayer = new ParticleLayer(width, height, particleLimit));
			addComponent(objectLayer = new TiledObjectLayer(32, 25, 19, 4));
			particleLayer.sprite.filters = [new BlurFilter()];
			
			var player:Player;
			var satellite:Satellite;
			var pickups:Array = new Array(2);
			var planets:Array = new Array(4);
			
			objectLayer.addGameObject(planets[0] = new Planet(50, false), new Vector3D(400, 300));
			objectLayer.addGameObject(planets[1] = new Planet(), new Vector3D(400, 150));
			objectLayer.addGameObject(planets[2] = new Planet(), new Vector3D(460, 440));
			objectLayer.addGameObject(planets[3] = new Planet(), new Vector3D(260, 360));
			
			var myFunction:Function = function():void {
				var pickupPosition:Vector3D = planets[2].position.clone();
				pickupPosition.x -= 40;
				pickupPosition.y -= 20;
				objectLayer.addGameObject(pickups[1] = new Pickup(), pickupPosition);
				pickups[1].handleMessage("rotate", planets[2]);
			}
			
			objectLayer.addGameObject(player = new Player(), new Vector3D(350, 200));
			objectLayer.addGameObject(satellite = new Satellite(), new Vector3D(500, 500));
			objectLayer.addGameObject(pickups[0] = new Pickup(myFunction), new Vector3D(310, 410));
			
			respawnPlanet = planets[1];
			player.handleMessage("rotate", planets[1]);
			satellite.handleMessage("rotate", planets[2]);
			pickups[0].handleMessage("rotate", planets[3]);
			planets[1].handleMessage("rotate", planets[0]);
			planets[2].handleMessage("rotate", planets[0]);
			planets[3].handleMessage("rotate", planets[0]);
		}
		
	}

}