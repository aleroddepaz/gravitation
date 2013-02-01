package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	
	/**
	 * State for waiting until the player is within the range
	 */
	public class IdleState extends GameObjectState 
	{
		private static const range:Number = 300;
		private var speed:Number;
		
		public function IdleState(speed:Number)
		{
			this.speed = speed;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Gravitation.player)
			{
				if (Vector3D.distance(gameObject.position, Gravitation.player.position) < range)
				{
					stateMachine.addState(new GotoState(speed, gameObject.startPosition));
					stateMachine.addState(new SeekState(speed));
				}
			}
		}
		
	}

}