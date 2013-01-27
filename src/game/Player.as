package game
{
	import flash.geom.Vector3D;
	import game.components.CheckOutOfBounds;
	import game.components.ColorParticleEmitter;
	import game.components.ExplodeOnDestroy;
	import game.components.PlanetSwitcher;
	import game.components.PlayerHealth;
	import game.components.RotateAround;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Player extends GameObject
	{
		private static const particleColor:uint = 0xffff00;
		private static const playerColor:uint = 0x3b3b3b;
		protected var checkPoint:Checkpoint;
		
		public function Player(checkPoint:Checkpoint)
		{
			this.mass = 0;
			this.checkPoint = checkPoint;
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(Player.playerColor));
			addComponent(new Mover(new Vector3D(0, 0), 0, 0));
			addComponent(new RotateAround(100));
			addComponent(new ExplodeOnDestroy(Player.particleColor));
			addComponent(new ColorParticleEmitter(Player.particleColor, 20, 0, 2, 0, 0.4, 10, 0.5));
			addComponent(new PlanetSwitcher());
			addComponent(new CheckOutOfBounds(checkPoint));
			addComponent(new PlayerHealth());
		}
		
		override public function initialize():void 
		{
			super.initialize();
			this.handleMessage("rotate", checkPoint.getRespawnPlanet());
		}
		
		override public function afterCollisionWith(other:GameObject):void
		{
			super.afterCollisionWith(other);
			if (other is Enemy)
			{
				this.handleMessage("damage", {enemy: other, checkpoint: checkPoint});
			}
			else if (!(other is Pickup))
			{
				this.checkPoint.respawnPlayer();
				this.handleMessage("destroy");
			}
		}
	}
}