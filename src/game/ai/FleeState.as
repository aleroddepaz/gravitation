package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class FleeState extends State 
	{
		
		private var gameObject:GameObject;
		private var speed:Number;
		
		public function FleeState(speed:Number)
		{
			this.speed = speed;
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			this.gameObject = this.stateMachine.parent as GameObject;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (gameObject.mover && Gravitation.player)
			{
				var from:Vector3D = gameObject.position;
				var to:Vector3D = Gravitation.player.position;
				var distance:Number = Vector3D.distance(from, to);
				if (distance < 1500)
				{
					var desiredVelocity:Vector3D = to.subtract(from);
					desiredVelocity.normalize();
					desiredVelocity.scaleBy(-speed);
					gameObject.mover.velocity = desiredVelocity;
				}
			}
		}
		
	}

}