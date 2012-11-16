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
			addComponent(new Background(0x888888, 0xaaaaaa, 0x888888));
			addComponent(particleLayer = new ParticleLayer(800, 600, 500));
			addComponent(objectLayer = new TiledObjectLayer(32, 25, 19, 4));
			particleLayer.sprite.filters = [new BlurFilter()];
			
			var player:Player;
			var satellite:Satellite;
			var planet1:Planet;
			var planet2:Planet;
			
			objectLayer.addGameObject(planet2 = new Planet(), new Vector3D(250, 250));
			objectLayer.addGameObject(planet1 = new Planet(), new Vector3D(400, 400));
			objectLayer.addGameObject(new Planet(), new Vector3D(400, 150));
			objectLayer.addGameObject(new Planet(), new Vector3D(150, 400));
			
			objectLayer.addGameObject(player = new Player(), new Vector3D(450, 350));
			objectLayer.addGameObject(satellite = new Satellite(), new Vector3D(200, 200));
			
			player.rotateAroundPlanet(planet1);
			satellite.rotateAroundPlanet(planet2);
		}
		
	}

}