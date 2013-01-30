package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class SeekState extends State 
	{
		
		override public function update(elapsedTime:Number):void 
		{
			this.stateMachine.
			if (gameObject.mover && Gravitation.player)
			{
				var from:Vector3D = gameObject.position;
				var to:Vector3D = Gravitation.player.position;
				var distance:Number = Vector3D.distance(from, to);
				if (distance < 1500)
				{
					var desiredVelocity:Vector3D = to.subtract(from);
					desiredVelocity.normalize();
					desiredVelocity.scaleBy(5);
					gameObject.mover.velocity = desiredVelocity;
				}
			}
		}
		
	}

}