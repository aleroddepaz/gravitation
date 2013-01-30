package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class SeekState extends State 
	{
		
		private var gameObject:GameObject;
		private var speed:Number;
		
		public function SeekState(speed:Number)
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
			if (Gravitation.player)
			{
				var desiredVelocity:Vector3D = Gravitation.player.position.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(speed);
				gameObject.mover.velocity = desiredVelocity;
			}
			else
			{
				gotoOrigin(speed);
			}
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			if (message == "gotoOrigin")
			{
				if(data.speed)
					gotoOrigin(data.speed);
				return Phantom.MESSAGE_CONSUMED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
		private function gotoOrigin(speed:Number):void 
		{
			stateMachine.popState();
			stateMachine.addState(new GotoOriginState(speed));
		}
		
	}

}