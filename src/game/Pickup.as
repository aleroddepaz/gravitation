package game 
{
	import flash.geom.Vector3D;
	import game.components.ExplodeOnDestroy;
	import game.components.RotateAround;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	
	public class Pickup extends GameObject 
	{
		private var collideFunction:Function;
		
		public function Pickup(collideFunction:Function = null) 
		{
			this.collideFunction = collideFunction;
			this.mass = 0;
			addComponent(new BoundingCircle(8));
			addComponent(new BoundingShapeRenderer(Gravitation.pickupColor));
			addComponent(new Mover(new Vector3D(0, 0), 0, 0, true));
			addComponent(new ParticleEmitter(Particle, 8, 0, 1, 0, 0.4, 5, 0.5));
			addComponent(new RotateAround(0.5));
			addComponent(new ExplodeOnDestroy(Particle));
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			if (other is Player)
			{
				this.handleMessage("destroyed");
				if (this.collideFunction != null)
				{
					this.collideFunction.call();
				}
				this.destroyed = true;
			}
		}
	}
}