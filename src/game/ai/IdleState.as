package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class IdleState extends GameObjectState 
	{
		private var speed:Number;
		
		public function IdleState(speed:Number)
		{
			this.speed = speed;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Gravitation.player)
			{
				if (Vector3D.distance(gameObject.position, Gravitation.player.position) < 300)
				{
					stateMachine.addState(new GotoOriginState(speed));
					stateMachine.addState(new SeekState(speed));
				}
			}
		}
		
	}

}