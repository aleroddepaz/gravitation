package game 
{
	import flash.geom.Vector3D;
	import game.components.RotateAround;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	
	import nl.jorisdormans.phantom2D.objects.boundaries.CollideWithLayerEdge;
	import nl.jorisdormans.phantom2D.objects.misc.ArrowKeyHandler;
	import nl.jorisdormans.phantom2D.objects.Mover;
	
	
	public class Player extends GameObject
	{
		private var component:RotateAround;
		
		public function Player(initialPlanet:GameObject) 
		{
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(0xff0000));
			addComponent(component = new RotateAround());
		}
		
		public function rotateAroundPlanet(planet:GameObject):void
		{
			component.setTarget(planet);
		}
		
	}

}