package game.components.player
{
	import flash.geom.Vector3D;
	import game.components.RotateAround;
	import game.gameobjects.Planet;
	import nl.jorisdormans.phantom2D.core.InputState;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.IInputHandler;
	
	public class PlanetSwitcher extends GameObjectComponent implements IInputHandler
	{
		private var linearSpeed:Number;
		
		public function PlanetSwitcher(linearSpeed:Number)
		{
			this.linearSpeed = linearSpeed;
		}
		
		public function handleInput(elapsedTime:Number, currentState:InputState, previousState:InputState):void
		{
			if (currentState.keySpace && !previousState.keySpace)
			{
				var component:RotateAround = gameObject.getComponentByClass(RotateAround) as RotateAround;
				var target:GameObject = component.getProperty("target") as GameObject;
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
			gameObject.handleMessage("switch");
			var newDirection:Vector3D = gameObject.position.subtract(target.position);
			var tmp:Number = newDirection.x;
			newDirection.x = newDirection.y;
			newDirection.y = tmp;
			newDirection.y *= -1;
			newDirection.normalize();
			newDirection.scaleBy(linearSpeed);
			gameObject.mover.velocity = newDirection;
		}
		
		private function selectPlanet():void
		{
			for each (var p:Planet in gameObject.objectLayer.getAllObjectsOfClass(Planet))
			{
				if (p.isCloseTo(gameObject.position))
				{
					var distance:Number = Vector3D.distance(p.position, gameObject.position);
					gameObject.mover.velocity = new Vector3D(0, 0);
					gameObject.handleMessage("rotate", { target: p, speed : linearSpeed / distance } );
					gameObject.handleMessage("enterSound");
					return;
				}
			}
		}
	}
}