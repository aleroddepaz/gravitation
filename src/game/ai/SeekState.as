package game.ai 
{
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.core.Phantom;
	
	/**
	 * State for seeking the player
	 */
	public class SeekState extends GameObjectState 
	{
		private var speed:Number;
		
		public function SeekState(speed:Number)
		{
			this.speed = speed;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Gravitation.player)
			{
				gameObject.mover.velocity = getDesiredVelocity(Gravitation.player.position, speed);
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