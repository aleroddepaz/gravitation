package game.components
{
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class PlayerHealth extends GameObjectComponent
	{
		private var numShields:uint = 0;
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int
		{
			switch (message)
			{
				case "shield": 
					return incrementShield();
				case "damage": 
					return receiveDamage(data);
			}
			return super.handleMessage(message, data, componentClass);
		}
		
		private function incrementShield():int
		{
			if (numShields == 0)
			{
				gameObject.addComponent(new AtmosphereParticleEmitter(40, 0x3333ff));
			}
			numShields++;
			return Phantom.MESSAGE_HANDLED;
		}
		
		private function receiveDamage(data:Object):int
		{
			if (numShields > 0)
			{
				numShields--;
				data.other.handleMessage("destroy");
				if (numShields == 0)
				{
					var component:AtmosphereParticleEmitter = gameObject.getComponentByClass(AtmosphereParticleEmitter) as AtmosphereParticleEmitter;
					gameObject.removeComponent(component);
				}
			}
			else
			{
				data.checkPoint.respawnPlayer();
				gameObject.handleMessage("destroy");
			}
			return Phantom.MESSAGE_HANDLED;
		}
	
	}

}