package game.components 
{
	import game.Planet;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.InputState;
	import nl.jorisdormans.phantom2D.objects.IInputHandler;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class PlanetSwitcher extends GameObjectComponent implements IInputHandler
	{
		private var switchDirection:Vector3D;
		private var switchSpeed:Number = 1;
		private var component:RotateAround;
		
		public function PlanetSwitcher() 
		{
			
		}
		
		override public function start():void
		{
			component = gameObject.getComponentByClass(RotateAround) as RotateAround;
		}
		
		override public function update(elapsedTime:Number):void
		{
			if (!component.inPlanet)
			{
				gameObject.position = gameObject.position.add(switchDirection);
			}
		}
		
		public function handleInput(elapsedTime:Number, currentState:InputState, previousState:InputState):void
		{
			if (currentState.keySpace && !previousState.keySpace) {
				if (component.inPlanet)
				{
					component.inPlanet = false;
					switchDirection = calculateNewDirection(gameObject.position.subtract(component.target));
				}
				else
				{
					var target:GameObject = calculateNewTarget();
					if(target) component.setTarget(target);
				}
			}
		}
		
		private function calculateNewDirection(perp:Vector3D):Vector3D
		{
			var newDirection:Vector3D = perp;
			var tmp:Number = newDirection.x;
			newDirection.x = newDirection.y;
			newDirection.y = tmp;
			
			newDirection.y *= -1;
			
			//if (rotationSpeed > 0) newDirection.y *= -1;
			//else newDirection.x *= -1;
			
			newDirection.normalize();
			newDirection.scaleBy(switchSpeed);
			return newDirection;
		}
		
		private function calculateNewTarget():GameObject
		{
			for each(var p:Planet in gameObject.objectLayer.getAllObjectsOfClass(Planet))
			{
				if (p.isCloseTo(gameObject.position)) return p;
			}
			trace("Bad!");
			return null;
		}
		
	}

}