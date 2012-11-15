package game 
{
	import flash.filters.BlurFilter;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Layer;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class Gravitation extends Screen
	{
		private var particleLayer:ParticleLayer;
		private var objectLayer:TiledObjectLayer;
		
		public function Gravitation(width:Number, height:Number) 
		{
			super(width, height);
			addComponent(new Background(0x000000, 0x003D79, 0x000000, 60));
			addComponent(particleLayer = new ParticleLayer(800, 600));
			addComponent(objectLayer = new TiledObjectLayer(32, 25, 19, 4));
			particleLayer.sprite.filters = [new BlurFilter()];
			
			var initialPlanet:Planet;
			objectLayer.addGameObject(initialPlanet = new Planet(), new Vector3D(150, 150));
			objectLayer.addGameObject(new Planet(), new Vector3D(300, 300));
			objectLayer.addGameObject(new Planet(), new Vector3D(300, 50));
			objectLayer.addGameObject(new Planet(), new Vector3D(50, 300));
			objectLayer.addGameObject(new Player(initialPlanet), new Vector3D(50, 50));
		}
		
	}

}