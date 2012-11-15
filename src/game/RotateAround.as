package game 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.core.Component;
	
	public class RotateAround extends Component 
	{
		
		var target:Vector3D;
		var distance:Number;
		var actualAngle:Number;
		var direction:uint; // 1 = clockwise, -1 = counterclockwise
		
		public function RotateAround(targetObject:GameObject) 
		{
			var p:GameObject = parent as GameObject;
			this.target = targetObject.position.clone();
			this.distance = Vector3D.distance(p.position, target);
			this.actualAngle = Vector3D.angleBetween(p.position.subtract(target), new Vector3D(0, 1));
		}
		
		override public function update(elapsedTime:Number):void
		{
			this.actualAngle = (actualAngle + elapsedTime) % (2 * Math.PI);
			var p:GameObject = parent as GameObject;
			p.position = new Vector3D(target.x + distance * Math.cos(actualAngle), target.y + distance * Math.sin(actualAngle));
		}
		
	}

}