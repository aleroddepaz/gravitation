package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class SeekState extends State 
	{
		
		private var gameObject:GameObject;
		
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
					desiredVelocity.scaleBy(20);
					gameObject.mover.velocity = desiredVelocity;
				}
			}
		}
		
	}

}