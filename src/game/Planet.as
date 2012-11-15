package game 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	import nl.jorisdormans.phantom2D.objects.boundaries.CollideWithLayerEdge;
	
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	
	public class Planet extends GameObject
	{
		public function Planet() 
		{
			addComponent(new BoundingCircle(32));
			addComponent(new BoundingShapeRenderer(0x00ff00));
		}
		
	}

}