package game 
{
	import nl.jorisdormans.phantom2D.cameras.Camera;
	import nl.jorisdormans.phantom2D.core.Layer;
	
	public class Hud extends Layer 
	{
		
		override public function render(camera:Camera):void 
		{
			super.render(camera);
			this.sprite.graphics.lineStyle(1, 0xffffff);
			this.sprite.graphics.drawRect(10, 10, 200, 20);
			this.sprite.graphics.lineStyle(1, 0x55dd55);
			this.sprite.graphics.beginFill(0x00ff00);
			this.sprite.graphics.drawRect(12, 12, 196 * Main.getProgress(), 16);
			this.sprite.graphics.endFill();
			this.sprite.graphics.lineStyle();
		}
		
	}

}