package game.components
{
	import flash.geom.Vector3D;
	import game.gameobjects.Player;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class RotateAround extends GameObjectComponent
	{
		protected var target:GameObject;
		protected var rotationSpeed:Number;
		
		private var distance:Number;
		private var actualAngle:Number;
		
		public function RotateAround(speed:Number)
		{
			this.rotationSpeed = speed;
		}
		
		public function getTarget():GameObject
		{
			return target;
		}
		
		override public function update(elapsedTime:Number):void
		{
			if (target)
			{
				actualAngle = (actualAngle + elapsedTime * rotationSpeed) % (Math.PI * 2);
				var targetPosition:Vector3D = target.position.clone();
				var newX:Number = targetPosition.x + distance * Math.cos(actualAngle);
				var newY:Number = targetPosition.y - distance * Math.sin(actualAngle);
				gameObject.position = new Vector3D(newX, newY);
			}
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int
		{
			switch (message)
			{
				case "rotate":
					if (data)
					{
						setTarget(data.target);
						if(data.speed) rotationSpeed = data.speed;
					}
					break;
				case "setSpeed":
					if (data && data.speed) rotationSpeed = data.speed;
					break;
				case "switch":
					target = null;
					break;
				return Phantom.MESSAGE_HANDLED;
			}
			return Phantom.MESSAGE_NOT_HANDLED;
		}
		
		private function setTarget(target:GameObject):void
		{
			this.target = target;
			if (target == null)
			{
				return;
			}
			distance = Vector3D.distance(gameObject.position, target.position);
			actualAngle = calculateActualAngle(target.position);
			if(gameObject is Player)
			{
				gameObject.objectLayer.screen.camera.handleMessage("followObject", {followObject : target});
				target.handleMessage("rotatingAround", { player: gameObject } );
			}
		}
		
		private function calculateActualAngle(targetPosition:Vector3D):Number
		{
			var aux:Vector3D = gameObject.position.clone().subtract(targetPosition);
			aux.normalize();
			var actualAngle:Number = Vector3D.angleBetween(new Vector3D(1, 0, 0), aux);
			if (gameObject.position.y > targetPosition.y)
			{
				actualAngle = Math.PI * 2 - actualAngle;
			}
			return actualAngle;
		}
	}
}