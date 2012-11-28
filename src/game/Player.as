package game 
{
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import game.components.ExplodeOnDestroy;
	import game.components.PlanetSwitcher;
	import game.components.RotateAround;
	import game.components.SceneBounds;
	import game.particles.YellowParticle;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	
	public class Player extends GameObject
	{
		protected var shield:uint = 0;
		protected var checkPoint:Checkpoint;
		
		public function Player(checkPoint:Checkpoint)
		{
			this.checkPoint = checkPoint;
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(Gravitation.playerColor));
			addComponent(new Mover(new Vector3D(0, 0), 0, 0));
			addComponent(new RotateAround());
			addComponent(new ExplodeOnDestroy(YellowParticle));
			addComponent(new ParticleEmitter(YellowParticle, 20, 0, 2, 0, 0.4, 10, 0.5));
			addComponent(new PlanetSwitcher());
			addComponent(new SceneBounds());
		}
		
		override public function afterCollisionWith(other:GameObject):void
		{
			super.afterCollisionWith(other);
			if (shield > 0 && other is Enemy)
			{
				other.handleMessage("destroyed");
				shield--;
			}
			if (!(other is Pickup))
			{
				checkPoint.respawnPlayer();
				this.handleMessage("destroyed");
				this.destroyed = true;
			}
		}
	}
}