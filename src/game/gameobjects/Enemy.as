package game.gameobjects 
{
	import flash.geom.Vector3D;
	import game.ai.SeekState;
	import game.components.particles.ColorParticleEmitter;
	import game.components.particles.ExplodeOnDestroy;
	import nl.jorisdormans.phantom2D.ai.statemachines.StateMachine;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Enemy extends GameObject 
	{
		
		private static const enemyColor:uint = 0xff3333;
		protected var radius:uint;
		
		public function Enemy(radius:uint = 16) 
		{
			this.radius = radius;
			addComponent(new BoundingCircle(radius));
			addComponent(new BoundingShapeRenderer(Enemy.enemyColor));
			addComponent(new ColorParticleEmitter(Enemy.enemyColor, 20, 2, 0, 0.4, 10, 0.5));
			addComponent(new ExplodeOnDestroy(Enemy.enemyColor));
			addComponent(new Mover(new Vector3D()));
			addComponent(new StateMachine(new SeekState()));
		}
		
	}
}
