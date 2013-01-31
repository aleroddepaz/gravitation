package game.ai 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Composite;
	
	public class GotoOriginState extends GameObjectState 
	{
		private var speed:Number;
		
		public function GotoOriginState(speed:Number)
		{
			this.speed = speed;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Vector3D.distance(gameObject.position, gameObject.startPosition) > 0.1)
			{
				var desiredVelocity:Vector3D = gameObject.startPosition.subtract(gameObject.position);
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