package game
{
	import flash.geom.Vector3D;
	import game.components.CheckOutOfBounds;
	import game.components.ExplodeOnDestroy;
	import game.components.PlanetSwitcher;
	import game.components.RotateAround;
	import game.particles.YellowParticle;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	
	public class Player extends GameObject
	{
		private static const playerColor:uint = 0x3B3B3B;
		
		protected var shield:uint = 0;
		protected var checkPoint:Checkpoint;
		
		public function Player(checkPoint:Checkpoint)
		{
			this.mass = 0;
			this.checkPoint = checkPoint;
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(Player.playerColor));
			addComponent(new Mover(new Vector3D(0, 0), 0, 0));
			addComponent(new RotateAround(100));
			addComponent(new ExplodeOnDestroy(YellowParticle));
			addComponent(new ParticleEmitter(YellowParticle, 20, 0, 2, 0, 0.4, 10, 0.5));
			addComponent(new PlanetSwitcher());
			addComponent(new CheckOutOfBounds(checkPoint));
		}
		
		override public function initialize():void 
		{
			super.initialize();
			handleMessage("rotate", checkPoint.getRespawnPlanet());
		}
		
		override public function afterCollisionWith(other:GameObject):void
		{
			super.afterCollisionWith(other);
			if (shield > 0 && other is Enemy)
			{
				other.handleMessage("destroyed");
				shield--;
			}
			else if (!(other is Pickup || other is Player))
			{
				checkPoint.respawnPlayer();
				handleMessage("destroyed");
				destroyed = true;
			}
		}
	}
}