package game.components 
{
	import game.Planet;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class RotateAround extends GameObjectComponent
	{
		public var inPlanet:Boolean = false;
		public var target:Vector3D;
		
		private var rotationSpeed:Number = 1; // > 0 = clockwise, < 0 = counterclockwise
		private var distance:Number;
		private var actualAngle:Number;
		
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
			this.actualAngle = Vector3D.angleBetween(new Vector3D(1, 0, 0), aux);
			if (gameObject.position.y > target.y)
			{
				this.actualAngle = Math.PI * 2 - this.actualAngle;
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
		}
	}
}