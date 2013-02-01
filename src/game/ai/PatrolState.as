package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.core.Phantom;
	
	/**
	 * State for patrolling among a group of positions
	 */
	public class PatrolState extends GameObjectState
	{
		private var positions:Vector.<Vector3D> = new Vector.<Vector3D>();
		private var speed:Number;
		private var index:int;
		
		public function PatrolState(speed:Number)
		{
			this.speed = speed;
			this.index = 0;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Gravitation.player != null && Gravitation.player.mover && Vector3D.distance(Gravitation.player.position, gameObject.position) < 200)
			{
				stateMachine.addState(new GotoState(speed * 2, positions[index]));
				stateMachine.addState(new PursuitState(speed * 4));
				incrementIndex();
			}
			else if (Vector3D.distance(gameObject.position, positions[index]) > 0.5)
			{
				gameObject.mover.velocity = getDesiredVelocity(positions[index], speed);
			}
			else
			{
				incrementIndex();
			}
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch (message)
			{
				case "addPatrolPoint":
					if(data && data.positionX && data.positionY)
						positions.push(new Vector3D(data.positionX, data.positionY));
					return Phantom.MESSAGE_CONSUMED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
		private function incrementIndex():void 
		{
			index++;
			index %= positions.length;
		}
		
	}

}