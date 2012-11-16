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
			addComponent(new Background(0x525252, 0x666666, 0x525252));
			addComponent(particleLayer = new ParticleLayer(800, 600));
			addComponent(objectLayer = new TiledObjectLayer(32, 25, 19, 4));
			particleLayer.sprite.filters = [new BlurFilter()];
			
			var player:Player;
			var initialPlanet:Planet;
			
			objectLayer.addGameObject(new Planet(), new Vector3D(150, 150));
			objectLayer.addGameObject(initialPlanet = new Planet(), new Vector3D(300, 300));
			objectLayer.addGameObject(new Planet(), new Vector3D(300, 50));
			objectLayer.addGameObject(new Planet(), new Vector3D(50, 300));
			objectLayer.addGameObject(player = new Player(), new Vector3D(250, 250));
			
			player.rotateAroundPlanet(initialPlanet);
		}
		
	}

}