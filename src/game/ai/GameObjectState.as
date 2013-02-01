package game.ai 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	/**
	 * Base class for all states with the gameObject property
	 */
	public class GameObjectState extends State
	{
		protected var gameObject:GameObject;
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			this.gameObject = this.stateMachine.parent as GameObject;
		}
		
		/**
		 * Auxiliary function to calculate the necessary velocity for going to the destination position
		 */
		protected function getDesiredVelocity(destination:Vector3D, speed:Number):Vector3D
		{
			var desiredVelocity:Vector3D = destination.subtract(gameObject.position);
			desiredVelocity.normalize();
			desiredVelocity.scaleBy(speed);
			return desiredVelocity;
		}
	}
}