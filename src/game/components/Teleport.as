package game.components
{
	import game.Player;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class Teleport extends GameObjectComponent
	{
		private var other:GameObject;
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int
		{
			switch (message)
			{
				case "rotating around": 
					return teleport(data);
				case "set destination": 
					return setDestination(data);
			}
			return 0;
		}
		
		private function teleport(data:Object):int
		{
			var player:GameObject = data as Player;
			if (!player)
			{
				trace("WARNING: Cannot cast GameObject");
				return Phantom.MESSAGE_NOT_HANDLED;
			}
			player.position = other.position.clone().add(player.position.clone().subtract(this.gameObject.position));
			player.handleMessage("rotate", this.other);
			return Phantom.MESSAGE_HANDLED;
		}
		
		private function setDestination(data:Object):int
		{
			var other:GameObject = data as GameObject;
			if (!other)
			{
				trace("WARNING: Cannot cast target object");
				return Phantom.MESSAGE_NOT_HANDLED;
			}
			this.other = other;
			return Phantom.MESSAGE_HANDLED;
		}
	}
}