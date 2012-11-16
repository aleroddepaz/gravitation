package game 
{
	import game.components.PlanetSwitcher;
	import game.components.RotateAround;
	import game.components.SceneBounds;
	import game.particles.YellowParticle;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	
	public class Player extends GameObject
	{
		public function Player() 
		{
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(0x3B3B3B));
			addComponent(new RotateAround());
			
			addComponent(new ParticleEmitter(YellowParticle, 20, 0, 2, 0, 0.4, 10, 0.5));
			addComponent(new PlanetSwitcher());
			addComponent(new SceneBounds());
		}
		
		public function rotateAroundPlanet(planet:Planet):void
		{
			var component:RotateAround = getComponentByClass(RotateAround) as RotateAround;
			component.setTarget(planet);
		}
	}
}