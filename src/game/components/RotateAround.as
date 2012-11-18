package game.components 
{
	import game.Planet;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class RotateAround extends GameObjectComponent
	{
		public var inPlanet:Boolean = false;
		public var target:GameObject;
		
		private var rotationSpeed:Number; // > 0 = clockwise, < 0 = counterclockwise
		private var distance:Number;
		private var actualAngle:Number;
		
		public function RotateAround(rotationSpeed:Number = 1)
		{
			this.rotationSpeed = rotationSpeed;
		}
		
		override public function update(elapsedTime:Number):void
		{
			if (inPlanet)
			{
				var targetPosition:Vector3D = target.position.clone();
				this.actualAngle = (actualAngle + elapsedTime * rotationSpeed) % (Math.PI * 2);
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
					setTarget(data);
			}
			return 0;
		}
		
		private function setTarget(targetObject:Object):void
		{
			this.target = targetObject as GameObject;
			if (!this.target)
			{
				trace("WARNING: Cannot cast target object");
				return;
			}
			inPlanet = true;
			var targetPosition:Vector3D = target.position.clone();
			this.distance = Vector3D.distance(gameObject.position, targetPosition);
			var aux:Vector3D = gameObject.position.subtract(targetPosition);
			aux.normalize();
			this.actualAngle = Vector3D.angleBetween(new Vector3D(1, 0, 0), aux);
			if (gameObject.position.y > targetPosition.y)
			{
				this.actualAngle = Math.PI * 2 - this.actualAngle;
			}
		}
	}
}