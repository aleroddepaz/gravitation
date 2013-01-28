package game.components
{
	import flash.display.Graphics;
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
			numShields++;
			gameObject.handleMessage("setRenderStyle", { fillColor: 0x3333ff } );
			return Phantom.MESSAGE_HANDLED;
		}
		
		private function receiveDamage(data:Object):int
		{
			if (numShields > 0)
			{
				numShields--;
				if (numShields == 0) gameObject.handleMessage("setRenderStyle", { fillColor: 0x3b3b3b } );
				data.other.handleMessage("destroy");
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