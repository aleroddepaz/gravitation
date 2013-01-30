package game.components.player
{
	import flash.geom.Vector3D;
	import game.Player;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class RotateAroundLinear extends GameObjectComponent
	{
		protected var linearSpeed:Number;
		private var target:GameObject;
		private var distance:Number;
		private var rotationSpeed:Number;
		private var actualAngle:Number;
		
		public function RotateAroundLinear(linearSpeed:Number)
		{
			this.linearSpeed = linearSpeed;
		}
		
		override public function generateXML():XML 
		{
			var xml:XML = super.generateXML();
			xml.@linearSpeed = linearSpeed;
			return xml;
		}
		
		override public function readXML(xml:XML):void 
		{
			super.readXML(xml);
			if (xml.@linearSpeed.length() > 0) linearSpeed = xml.@linearSpeed;
		}
		
		public function getLinearSpeed():Number
		{
			return linearSpeed;
		}
		
		public function getTarget():GameObject
		{
			return target;
		}
		
		override public function update(elapsedTime:Number):void
		{
			if (target)
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
					return Phantom.MESSAGE_HANDLED;
				case "clear":
					target = null;
					return Phantom.MESSAGE_HANDLED;
			}
			return Phantom.MESSAGE_NOT_HANDLED;
		}
		
		private function setTarget(targetObject:Object):void
		{
			target = targetObject as GameObject;
			if (!target)
			{
				return;
			}
			gameObject.objectLayer.screen.camera.handleMessage("followObject", {followObject : targetObject});
			distance = Vector3D.distance(gameObject.position, target.position);
			actualAngle = calculateActualAngle(target.position);
			rotationSpeed = linearSpeed / distance;
			target.handleMessage("rotatingAround", gameObject);
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