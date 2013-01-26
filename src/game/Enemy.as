package game 
{
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import game.components.SeekAndFlee;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Enemy extends GameObject 
	{
		private static const enemyColor:uint = 0x555555;
		
		protected var radius:uint;
		protected var seekFleeComponent:SeekAndFlee;
		
		public function Enemy(player:Player, planets:Planet, radius:uint = 32) 
		{
			this.radius = radius;
			addComponent(new BoundingCircle(radius));
			addComponent(new BoundingShapeRenderer(Enemy.enemyColor));
			addComponent(new Mover(new Vector3D()));
			addComponent(seekFleeComponent = new SeekAndFlee(player, SeekAndFlee.SEEK, 50));
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			super.afterCollisionWith(other);
			if (other is Player)
			{
				seekFleeComponent.seek = false;
				var timer:Timer = new Timer(2000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, seekAgain);
				timer.start();
			}
		}
		
		private function seekAgain(event:TimerEvent):void
		{
			seekFleeComponent.seek = true;
		}
	}
}
