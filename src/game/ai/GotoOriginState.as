package game.ai 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class GotoOriginState extends State 
	{
		
		private var gameObject:GameObject;
		private var speed:Number;
		
		public function GotoOriginState(speed:Number)
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
			if (Vector3D.distance(gameObject.position, gameObject.startPosition) > 0.1)
			{
				var desiredVelocity:Vector3D = gameObject.startPosition.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(speed);
				gameObject.mover.velocity = desiredVelocity;
			}
			else
			{
				stateMachine.popState();
				stateMachine.addState(new IdleState(speed));
			}
		}
		
	}

}