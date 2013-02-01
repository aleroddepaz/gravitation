package game.components.player
{
	import flash.display.Graphics;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class ShieldHealth extends GameObjectComponent
	{
		public static var numShields:uint = 0;
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int
		{
			switch (message)
			{
				case "shield": 
					incrementShield();
					break;
				case "damage": 
					receiveDamage(data);
					break;
				return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			checkRenderStyle();
		}
		
		private function incrementShield():void
		{
			numShields++;
			checkRenderStyle();
		}
		
		private function receiveDamage(data:Object):void
		{
			if (numShields > 0)
			{
				numShields--;
				checkRenderStyle();
				data.enemy.handleMessage("destroy");
			}
			else
			{
				data.checkPoint.respawnPlayer();
				gameObject.handleMessage("destroy");
			}
		}
		
		private function checkRenderStyle():void 
		{
			if (numShields == 0)
			{
				gameObject.handleMessage("setRenderStyle", { fillColor: 0x3b3b3b } );
			}
			else if (numShields > 0)
			{
				gameObject.handleMessage("setRenderStyle", { fillColor: 0x333366 + 0x22 * numShields } );
			}
		}
	}

}