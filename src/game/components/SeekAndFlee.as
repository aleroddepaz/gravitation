package game.components 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.core.Phantom;
	
	public class SeekAndFlee extends GameObjectComponent
	{
		public static const SEEK:Boolean = true;
		public static const FLEE:Boolean = false;
		
		public var seek:Boolean;
		protected var target:GameObject;
		protected var maxVelocity:Number;
		
		public function SeekAndFlee(target:GameObject, seek:Boolean, maxVelocity:Number = 100)
		{
			this.target = target;
			this.seek = seek;
			this.maxVelocity = maxVelocity;
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch (message)
			{
				case "target":
					var target:GameObject = data as GameObject;
					if (!target)
					{
						trace("WARNING: Cannot cast to GameObject");
						return Phantom.MESSAGE_NOT_HANDLED;
					}
					this.target = target;
					return Phantom.MESSAGE_HANDLED;
			}
			return Phantom.MESSAGE_NOT_HANDLED;
		}
		
		public override function update(elapsedTime:Number):void
		{
			if (gameObject.mover && target)
			{
				var distance:Number = Vector3D.distance(gameObject.position, target.position);
				if (distance < 1500)
				{
					var desiredVelocity:Vector3D = target.position.subtract(gameObject.position);
					desiredVelocity.normalize();
					desiredVelocity.scaleBy(maxVelocity);// / (distance * 0.01));
					if (!this.seek)
					{
						desiredVelocity.scaleBy( -1);
					}
					gameObject.mover.velocity = desiredVelocity;
				}
			}
		}
	}
}
