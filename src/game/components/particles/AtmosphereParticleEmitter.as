package game.components.particles
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	/**
	 * Circular particle emitter indicating the orbit range
	 */
	public class AtmosphereParticleEmitter extends GameObjectComponent
	{
		private var distance:Number;
		private var color:uint;
		
		public function AtmosphereParticleEmitter(distance:Number, color:uint)
		{
			this.distance = distance;
			this.color = color;
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message)
			{
				case "setAtmosphereColor":
					if (data.color) this.color = data.color;
					return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
		override public function update(elapsedTime:Number):void
		{
			var particleLayer:ParticleLayer = gameObject.objectLayer.screen.getComponentByClass(ParticleLayer) as ParticleLayer;
			if (!particleLayer)
			{
				return;
			}
			
			var angle:Number = 0;
			while (angle < Math.PI * 2)
			{
				angle += Math.random() * 2 + 1;
				var particle:Particle = new Particle();
				var life:Number = 0.25 + (Math.random() - Math.random()) * 0.2;
				var position:Vector3D = gameObject.position.clone();
				position.x += Math.cos(angle) * distance;
				position.y += Math.sin(angle) * distance;
				particle.initialize(life, position, new Vector3D(0, 0, 0));
				particle.color = this.color;
				particleLayer.addParticle(particle);
			}
		}
	}

}