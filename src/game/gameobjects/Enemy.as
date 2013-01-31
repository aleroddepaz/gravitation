package game.gameobjects 
{
	import flash.geom.Vector3D;
	import game.ai.IdleState;
	import game.components.audio.SfxrSound;
	import game.components.particles.ColorParticleEmitter;
	import game.components.particles.ExplodeOnDestroy;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.ai.statemachines.StateMachine;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Enemy extends GameObject 
	{
		private static const destroySound:String = "2,,0.1264,0.0678,0.3636,0.5031,0.2,-0.1712,,,,,,0.3621,0.0504,,0.1685,-0.1253,1,,,0.0993,,0.5";
		private static const enemyColor:uint = 0xff3333;
		protected var radius:uint;
		private var state:State;
		
		public function Enemy(state:State, radius:uint = 16) 
		{
			this.mass = 0;
			this.radius = radius;
			addComponent(new BoundingCircle(radius));
			addComponent(new BoundingShapeRenderer(Enemy.enemyColor));
			addComponent(new ColorParticleEmitter(Enemy.enemyColor, 20, 2, 0, 0.4, 10, 0.5));
			addComponent(new ExplodeOnDestroy(Enemy.enemyColor));
			addComponent(new Mover(new Vector3D(0, 0)));
			addComponent(new StateMachine(state));
			addComponent(new SfxrSound("destroy", destroySound));
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			if (other is Player)
			{
				handleMessage("stopSeeking");
			}
			super.afterCollisionWith(other);
		}
		
	}
}
