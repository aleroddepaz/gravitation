package game.particles 
{
	import flash.display.Graphics;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.cameras.Camera;
	
	public class YellowParticle extends Particle
	{
		
		public function YellowParticle() 
		{
			
		}
		
		override public function render(graphics:Graphics, camera:Camera):void
		{
			graphics.beginFill(0xffff00);
			graphics.drawCircle(position.x - camera.left, position.y - camera.top, Math.min(5, life * 10));
			graphics.endFill();
		}
		
	}

}