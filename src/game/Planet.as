package game 
{
	import flash.geom.Vector3D;
	import game.components.AtmosphereParticleEmitter;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	
	public class Planet extends GameObject
	{
		private var radius:uint = 32;
		
		public function Planet() 
		{
			addComponent(new BoundingCircle(radius));
			addComponent(new BoundingShapeRenderer(0x333333));
			//addComponent(new AtmosphereParticleEmitter(radius * 2, 0x0000ff));
		}
		
	}

}