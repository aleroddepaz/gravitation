package game.components 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class ExplodeOnDestroy extends GameObjectComponent
	{
		private var particleClass:Class;
		
		public function ExplodeOnDestroy(particleClass:Class)
		{
			this.particleClass = particleClass;
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch (message)
			{
				case "destroyed":
					explode();
			}
			return super.handleMessage(message, data, componentClass);
		}
		
		private function explode():void
		{
			var particleLayer:ParticleLayer = gameObject.objectLayer.screen.getComponentByClass(ParticleLayer) as ParticleLayer;
			if (!particleLayer) {
				trace("WARNING: ParticleLayer not found for " + gameObject.toString());
				return;
			}
			
			var angle:Number = 0;
			while (angle < Math.PI * 2) {
				angle += Math.random() * 0.1 + 0.1;
				var particle:Particle = (new particleClass() as Particle);
				var life:Number = 0.5 + (Math.random() - Math.random()) * 0.3;
				var speed:Number = 100 + (Math.random() - Math.random()) * 50;
				
				var velocity:Vector3D = new Vector3D();
				if (gameObject.mover) {
					velocity.x += gameObject.mover.velocity.x;
					velocity.y += gameObject.mover.velocity.y;
				}
				velocity.x += Math.cos(angle) * speed;
				velocity.y += Math.sin(angle) * speed;
				
				var position:Vector3D = gameObject.position.clone();
				position.x += Math.cos(angle) * speed * 0.05;
				position.y += Math.sin(angle) * speed * 0.05;
				
				particle.initialize(life, position, velocity);
				particleLayer.addParticle(particle);
			}
		}
		
	}

}