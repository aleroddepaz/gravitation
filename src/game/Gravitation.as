package game 
{
	import flash.filters.BlurFilter;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class Gravitation extends Screen
	{
		private var particleLimit:int = 600;
		private var particleLayer:ParticleLayer;
		private var objectLayer:TiledObjectLayer;
		
		private var checkPoint:Checkpoint;
		
		public static const playerColor:uint = 0x3B3B3B;
		public static const planetColor:uint = 0x555555;
		public static const satelliteColor:uint = 0x3B3B3B;
		public static const pickupColor:uint = 0xffffff;
		
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
			var enemy:Enemy;
			
			objectLayer.addGameObject(planets[0] = new Planet(50, false), new Vector3D(300, 300));
			objectLayer.addGameObject(planets[1] = new Planet(), new Vector3D(300, 150));
			objectLayer.addGameObject(planets[2] = new Planet(), new Vector3D(360, 440));
			objectLayer.addGameObject(planets[3] = new Planet(), new Vector3D(160, 360));
			
			objectLayer.addGameObject(checkPoint = new Checkpoint(planets[1]), new Vector3D(0, 0, 0));
			
			objectLayer.addGameObject(player = new Player(checkPoint), new Vector3D(250, 200));
			objectLayer.addGameObject(satellite = new Satellite(), new Vector3D(400, 500));
			objectLayer.addGameObject(pickups[0] = new Pickup(), new Vector3D(210, 410));
			objectLayer.addGameObject(pickups[1] = new Pickup(), new Vector3D(320, 420));
			
			objectLayer.addGameObject(enemy = new Enemy(player, planets), new Vector3D(50, 50));
			
			player.handleMessage("rotate", planets[1]);
			satellite.handleMessage("rotate", planets[2]);
			pickups[0].handleMessage("rotate", planets[3]);
			pickups[1].handleMessage("rotate", planets[2]);
			planets[1].handleMessage("rotate", planets[0]);
			planets[2].handleMessage("rotate", planets[0]);
			planets[3].handleMessage("rotate", planets[0]);
		}
	}
}