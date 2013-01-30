package game.components.player
{
	import flash.geom.Vector3D;
	import game.Checkpoint;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class CheckOutOfBounds extends GameObjectComponent
	{
		private var offset:Number;
		private var respawned:Boolean;
		private var checkpoint:Checkpoint;
		
		public function CheckOutOfBounds(checkpoint:Checkpoint)
		{
			this.offset = 10;
			this.respawned = false;
			this.checkpoint = checkpoint;
		}
		
		override public function generateXML():XML 
		{
			var xml:XML = super.generateXML();
			xml.@offset = offset;
			xml.@respawned = respawned;
			return xml;
		}
		
		override public function readXML(xml:XML):void 
		{
			super.readXML(xml);
			if (xml.@offset.length() > 0) respawned = xml.@offset;
			if (xml.@distance.length() > 0) respawned = xml.@respawned;
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