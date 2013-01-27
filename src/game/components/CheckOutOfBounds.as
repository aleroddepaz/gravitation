package game.components
{
	import flash.geom.Vector3D;
	import game.Checkpoint;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class CheckOutOfBounds extends GameObjectComponent
	{
		private var checkpoint:Checkpoint;
		private var offset:Number = 10;
		private var respawned:Boolean = false;
		
		public function CheckOutOfBounds(checkpoint:Checkpoint)
		{
			this.checkpoint = checkpoint;
		}
		
		public override function update(elapsedTime:Number):void
		{
			var position:Vector3D = gameObject.position;
			var width:Number = gameObject.objectLayer.layerWidth;
			var height:Number = gameObject.objectLayer.layerHeight;
			var isOutOfBounds:Boolean = position.x < -offset || position.y < -offset || position.x > width + offset || position.y > height + offset;
			if (isOutOfBounds && !respawned)
			{
				checkpoint.respawnPlayer();
				respawned = true;
				gameObject.destroyed = true;
			}
			super.update(elapsedTime);
		}
	}

}