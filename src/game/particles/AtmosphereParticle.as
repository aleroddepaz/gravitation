package game.particles 
{
	import flash.display.Graphics;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.cameras.Camera;
	
	public class AtmosphereParticle extends Particle 
	{
		
		
		public function AtmosphereParticle() 
		{
			
		}
		
		override public function render(graphics:Graphics, camera:Camera):void
		{
			graphics.lineStyle(1, 0x0000ff, 0.8);
			graphics.drawCircle(position.x - camera.left, position.y - camera.top, Math.min(5, life * 10));
		}
		
	}

}