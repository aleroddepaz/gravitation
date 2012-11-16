package game.components 
{
	import game.Planet;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.InputState;
	import nl.jorisdormans.phantom2D.objects.IInputHandler;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class RotateAround extends GameObjectComponent implements IInputHandler
	{
		private var inPlanet:Boolean = false;
		private var target:Vector3D;
		private var distance:Number;
		private var actualAngle:Number;
		private var rotationSpeed:Number = 1; // > 0 = clockwise, < 0 = counterclockwise
		private var switchDirection:Vector3D;
		private var switchSpeed:Number = 1;
		
		public function RotateAround()
		{
			
		}
		
		public function setTarget(targetObject:GameObject):void
		{
			inPlanet = true;
			this.target = targetObject.position.clone();
			this.distance = Vector3D.distance(gameObject.position, target);
			var aux:Vector3D = gameObject.position.subtract(target);
			aux.normalize();
			trace(aux);
			this.actualAngle = Math.acos(new Vector3D(1, 0, 0).dotProduct(aux));
			if (gameObject.position.y > target.y)
			{
				this.actualAngle = Math.PI * 2 - this.actualAngle;
			}
			trace(actualAngle * 180 / Math.PI);
		}
		
		public function handleInput(elapsedTime:Number, currentState:InputState, previousState:InputState):void
		{
			if (currentState.keySpace && !previousState.keySpace) {
				if (inPlanet)
				{
					inPlanet = false;
					this.switchDirection = calculateNewDirection(gameObject.position.subtract(target));
				}
				else
				{
					calculateNewPlanet();
				}
			}
		}
		
		override public function update(elapsedTime:Number):void
		{
			if (inPlanet)
			{
				this.actualAngle = (actualAngle + elapsedTime) % (Math.PI * 2);
				var d:Number = distance * rotationSpeed;
				gameObject.position = new Vector3D(target.x + distance * Math.cos(actualAngle), target.y - distance * Math.sin(actualAngle));
			}
			else
			{
				gameObject.position = gameObject.position.add(this.switchDirection);
			}
		}
		
		private function calculateNewDirection(perp:Vector3D):Vector3D
		{
			var newDirection:Vector3D = perp;
			var tmp:Number = newDirection.x;
			newDirection.x = newDirection.y;
			newDirection.y = tmp;
			if (rotationSpeed > 0)
			{
				newDirection.y *= -1;
			}
			else
			{
				newDirection.x *= -1;
			}
			newDirection.normalize();
			newDirection.scaleBy(switchSpeed);
			return newDirection;
		}
		
		private function calculateNewPlanet():void
		{
			for each(var p:Planet in gameObject.objectLayer.getAllObjectsOfClass(Planet))
			{
				if (p.isCloseTo(gameObject.position))
				{
					setTarget(p);
					return;
				}
			}
			trace("Bad!");
		}
	}

}