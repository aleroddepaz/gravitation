package game
{
	import flash.filters.BlurFilter;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.cameras.FollowObject;
	import nl.jorisdormans.phantom2D.cameras.RestrictToLayer;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class Gravitation extends Screen
	{
		private var particleLimit:int = 600;
		private var particleLayer:ParticleLayer;
		private var objectLayer:TiledObjectLayer;
		
		private var planets:Vector.<Planet> = new Vector.<Planet>();
		private var pickups:Vector.<Pickup> = new Vector.<Pickup>();
		private var satellites:Vector.<Satellite> = new Vector.<Satellite>();
		private var checkPoint:Checkpoint;
		
		public function Gravitation(width:Number, height:Number)
		{
			super(width, height);
			addComponent(new Background(0x888888, 0xaaaaaa, 0x888888));
			addComponent(particleLayer = new ParticleLayer(width, height, particleLimit));
			addComponent(objectLayer = new TiledObjectLayer(40, 30, 25, 4));
			particleLayer.sprite.filters = [new BlurFilter()];
			
			camera.addComponent(new FollowObject(null));
			camera.addComponent(new RestrictToLayer(objectLayer));
			
			objectLayer.addGameObject(planets[0] = new Planet(null, 50, false), new Vector3D(300, 300));
			objectLayer.addGameObject(planets[1] = new Planet(planets[0]), new Vector3D(200, 200));
			objectLayer.addGameObject(planets[2] = new Planet(planets[0]), new Vector3D(200, 400));
			objectLayer.addGameObject(planets[3] = new Planet(planets[0]), new Vector3D(450, 300));
			objectLayer.addGameObject(checkPoint = new Checkpoint(planets[1]), new Vector3D(150, 150));
			
		}
	}
}