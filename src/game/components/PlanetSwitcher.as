package game.components
{
	import flash.geom.Vector3D;
	import game.Planet;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.InputState;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.IInputHandler;
	
	public class PlanetSwitcher extends GameObjectComponent implements IInputHandler
	{
		private var switchDirection:Vector3D;
		private var switchSpeed:Number;
		private var component:RotateAround;
		
		override public function onAdd(composite:Composite):void
		{
			super.onAdd(composite);
			component = composite.getComponentByClass(RotateAround) as RotateAround;
			switchSpeed = component.getLinearSpeed();
		}
		
		public function handleInput(elapsedTime:Number, currentState:InputState, previousState:InputState):void
		{
			if (currentState.keySpace && !previousState.keySpace)
			{
				var target:GameObject = component.getTarget();
				if (target != null)
				{
					leavePlanet(target);
				}
				else
				{
					selectPlanet();
				}
			}
		}
		
		private function leavePlanet(target:GameObject):void
		{
			gameObject.handleMessage("switchSound");
			component.handleMessage("rotate", null);
			var newDirection:Vector3D = gameObject.position.subtract(target.position);
			var tmp:Number = newDirection.x;
			newDirection.x = newDirection.y;
			newDirection.y = tmp;
			newDirection.y *= -1;
			newDirection.normalize();
			newDirection.scaleBy(switchSpeed);
			gameObject.mover.velocity = newDirection;
		}
		
		private function selectPlanet():void
		{
			for each (var p:Planet in gameObject.objectLayer.getAllObjectsOfClass(Planet))
			{
				if (p.isCloseTo(gameObject.position))
				{
					gameObject.mover.velocity = new Vector3D(0, 0);
					gameObject.handleMessage("rotate", p);
					gameObject.handleMessage("enterSound");
					return;
				}
			}
		}
	}
}