package game 
{
	import flash.geom.Vector3D;
	import game.components.AtmosphereParticleEmitter;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	
	public class Planet extends GameObject
	{
		private var radius:uint = 32;
		
		public function Planet() 
		{
			addComponent(new BoundingCircle(radius));
			addComponent(new BoundingShapeRenderer(0x555555));
			addComponent(new AtmosphereParticleEmitter(this.radius * 3, 0x555555));
		}
		
		public function isCloseTo(playerPosition:Vector3D):Boolean
		{
			return Math.abs(Vector3D.distance(this.position, playerPosition)) < this.radius * 3;
		}
		
	}

}