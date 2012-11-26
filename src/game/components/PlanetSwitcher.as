package game.components 
{
	import game.Planet;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.InputState;
	import nl.jorisdormans.phantom2D.objects.IInputHandler;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.Mover;
	
	public class PlanetSwitcher extends GameObjectComponent implements IInputHandler
	{
		private var switchDirection:Vector3D;
		private var switchSpeed:Number = 100;
		private var component:RotateAround;
		
		override public function onAdd(composite:Composite):void
		{
			super.onAdd(composite);
			component = composite.getComponentByClass(RotateAround) as RotateAround;
		}
		
		public function handleInput(elapsedTime:Number, currentState:InputState, previousState:InputState):void
		{
			if (currentState.keySpace && !previousState.keySpace) {
				if (component.inPlanet)
				{
					component.inPlanet = false;
					gameObject.mover.velocity = calculateNewDirection(gameObject.position.subtract(component.target.position));
					trace(gameObject.mover.velocity);
				}
				else
				{
					var target:GameObject;
					for each(var p:Planet in gameObject.objectLayer.getAllObjectsOfClass(Planet))
					{
						if (p.isCloseTo(gameObject.position)) target = p;
					}
					if (target)
					{
						gameObject.mover.velocity = new Vector3D(0, 0);
						component.handleMessage("rotate", target);
					}
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
			newDirection.normalize();
			newDirection.scaleBy(switchSpeed);
			return newDirection;
		}
	}
}