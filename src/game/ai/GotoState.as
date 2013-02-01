package game.ai 
{
	import flash.geom.Vector3D;
	
	public class GotoState extends GameObjectState 
	{
		protected var speed:Number;
		protected var destination:Vector3D;
		
		public function GotoState(speed:Number, destination:Vector3D)
		{
			this.speed = speed;
			this.destination = destination;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Vector3D.distance(gameObject.position, destination) > 0.5)
			{
				var desiredVelocity:Vector3D = destination.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(speed);
				gameObject.mover.velocity = desiredVelocity;
			}
			else
			{
				stateMachine.removeState(this);
			}
		}
		
	}

}