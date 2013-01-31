package game.components.player
{
	import flash.display.Graphics;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class PlayerHealth extends GameObjectComponent
	{
		private static var numShields:uint = 0;
		
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
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			if(numShields > 0)
				composite.handleMessage("setRenderStyle", { fillColor: 0x333366 + 0x22 * numShields } );
		}
		
		private function incrementShield():int
		{
			numShields++;
			gameObject.handleMessage("setRenderStyle", { fillColor: 0x000066 + 0x22 * numShields } );
			return Phantom.MESSAGE_HANDLED;
		}
		
		private function receiveDamage(data:Object):int
		{
			if (numShields > 0)
			{
				numShields--;
				if (numShields == 0) gameObject.handleMessage("setRenderStyle", { fillColor: 0x3b3b3b } );
				data.enemy.handleMessage("destroy");
				data.enemy.handleMessage("destroySound");
			}
			else
			{
				data.checkPoint.respawnPlayer();
				gameObject.handleMessage("enemyCollisionSound");
				gameObject.handleMessage("destroy");
			}
			return Phantom.MESSAGE_HANDLED;
		}
		
	}

}