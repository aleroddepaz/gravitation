package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.core.Phantom;
	
	public class PursuitState extends GameObjectState 
	{
		private var speed:Number;
		
		public function PursuitState(speed:Number)
		{
			this.speed = speed;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Gravitation.player && Gravitation.player.mover)
			{
				var futurePosition:Vector3D = Gravitation.player.position.add(Gravitation.player.mover.velocity);
				var desiredVelocity:Vector3D = futurePosition.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(speed);
				gameObject.mover.velocity = desiredVelocity;
			}
			else
			{
				stateMachine.removeState(this);
			}
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			if (message == "stopSeeking")
			{
				stateMachine.removeState(this);
				return Phantom.MESSAGE_CONSUMED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}