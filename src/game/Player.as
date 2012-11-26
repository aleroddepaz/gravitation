package game 
{
	import flash.geom.Vector3D;
	import game.components.ExplodeOnDestroy;
	import game.components.PlanetSwitcher;
	import game.components.RotateAround;
	import game.components.SceneBounds;
	import game.particles.YellowParticle;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	
	public class Player extends GameObject
	{
		private var respawnPlanet:GameObject;
		
		public function Player(respawnPlanet:GameObject)
		{
			this.respawnPlanet = respawnPlanet;
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(Gravitation.playerColor));
			addComponent(new Mover(new Vector3D(0, 0), 0, 0, true));
			addComponent(new RotateAround());
			addComponent(new ExplodeOnDestroy(YellowParticle));
			addComponent(new ParticleEmitter(YellowParticle, 20, 0, 2, 0, 0.4, 10, 0.5));
			addComponent(new PlanetSwitcher());
			addComponent(new SceneBounds());
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			super.afterCollisionWith(other);
			if (!(other is Pickup))
			{
				this.handleMessage("destroyed");
				this.reset();
			}
		}
		
		override public function reset():void
		{
			this.mover.velocity = new Vector3D(0, 0);
			this.position = respawnPlanet.position.clone();
			this.position.x -= 50;
			this.position.y -= 50;
			this.handleMessage("rotate", respawnPlanet);
		}
	}
}