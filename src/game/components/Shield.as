package game.components 
{
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class Shield extends GameObjectComponent 
	{
		private static const shieldPickupColor:uint = 0x3333ff;
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			composite.removeComponent(composite.getComponentByClass(PickupProgress));
			composite.handleMessage("setRenderStyle", { fillColor: shieldPickupColor } );
			composite.handleMessage("setExplosionColor", { color: shieldPickupColor } );
			composite.handleMessage("setParticleColor", { color: shieldPickupColor } );
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message)
			{
				case "pickupCollected":
					if(data && data.player) data.player.handleMessage("shield");
					return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}