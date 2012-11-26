package game
{
	import flash.geom.Vector3D;
	import game.components.AtmosphereParticleEmitter;
	import game.components.RotateAround;
	import game.components.Teleporter;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	
	public class Planet extends GameObject
	{
		protected var radius:uint;
		protected var hasAtmosphere:Boolean;
		
		public function Planet(radius:uint = 32, hasAtmosphere:Boolean = true)
		{
			super();
			this.radius = radius;
			this.hasAtmosphere = hasAtmosphere;
			addComponent(new BoundingCircle(radius));
			addComponent(new BoundingShapeRenderer(Gravitation.planetColor));
			addComponent(new Mover(new Vector3D(0, 0), 10, 2, false));
			addComponent(new RotateAround(0.05));
			if (this.hasAtmosphere) setAtmosphere();
		}
		
		protected function setAtmosphere():void
		{
			addComponent(new AtmosphereParticleEmitter(this.radius * 3, 0x555555));
		}
		
		public function isCloseTo(playerPosition:Vector3D):Boolean
		{
			return hasAtmosphere && Math.abs(Vector3D.distance(this.position, playerPosition)) < this.radius * 3;
		}
	}
}