package game.gameobjects
{
	import flash.geom.Vector3D;
	import game.components.particles.ColorParticleEmitter;
	import game.components.particles.ExplodeOnDestroy;
	import game.components.player.*;
	import game.components.audio.SfxrSound;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Player extends GameObject
	{
		private static const particleColor:uint = 0xffff00;
		private static const color:uint = 0x3b3b3b;
		private static const radius:uint = 16;
		private static const linearSpeed:uint = 100;
		private static const enemyCollisionSound:String = "3,,0.3077,0.524,0.3466,0.0865,,0.0754,,,,,,,,0.5805,0.3995,-0.1537,1,,,,,0.5";
		private static const destroySound:String = "3,,0.2255,0.4375,0.3677,0.14,,,,,,,,,,0.51,-0.56,-0.118,0.94,,,,,0.49";
		private static const switchSound:String = "0,,0.1665,,0.1869,0.591,,0.2999,,,,,,0.1368,,,,,0.8027,,,,,0.5";
		private static const enterSound:String = "0,0.001,0.2125,0.0976,0.1472,0.5249,0.0126,0.4005,0.0794,0.0367,,0.0435,,0.1322,0.1258,0.0364,-0.0059,-0.0221,0.3,0.017,,,-0.0744,0.5";
		protected var checkPoint:Checkpoint;
		
		public function Player(checkPoint:Checkpoint)
		{
			this.mass = 0;
			this.checkPoint = checkPoint;
			addComponent(new PlayerHealth());
			addComponent(new RotateAroundLinear(linearSpeed));
			addComponent(new PlanetSwitcher());
			addComponent(new Mover(new Vector3D(0, 0), 0, 0));
			addComponent(new BoundingCircle(radius));
			addComponent(new CheckOutOfBounds(checkPoint));
			addComponent(new BoundingShapeRenderer(color));
			addComponent(new ExplodeOnDestroy(Player.particleColor));
			addComponent(new ColorParticleEmitter(Player.particleColor, 20, 2, 0, 0.4, 10, 0.5));
			addComponent(new SfxrSound("enemyCollisionSound", Player.enemyCollisionSound));
			addComponent(new SfxrSound("destroySound", Player.destroySound));
			addComponent(new SfxrSound("enterSound", Player.enterSound));
			addComponent(new SfxrSound("switchSound", Player.switchSound));
		}
		
		override public function initialize():void 
		{
			super.initialize();
			this.handleMessage("rotate", { target: checkPoint.getRespawnPlanet() } );
		}
		
		override public function afterCollisionWith(other:GameObject):void
		{
			super.afterCollisionWith(other);
			if (other is Enemy)
			{
				this.handleMessage("damage", {enemy: other, checkPoint: checkPoint});
			}
			else if (!(other is Pickup))
			{
				this.handleMessage("destroySound");
				this.checkPoint.respawnPlayer();
				this.handleMessage("destroy");
			}
		}
	}
}