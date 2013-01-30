package game.components
{
	import game.Player;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class Teleport extends GameObjectComponent
	{
		private var destination:GameObject;
		
		public function Teleport(destination:GameObject)
		{
			this.destination = destination;
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int
		{
			switch (message)
			{
				case "rotatingAround": 
					return teleport(data);
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
			player.position = destination.position.clone().add(player.position.clone().subtract(this.gameObject.position));
			player.handleMessage("rotate", this.destination);
			gameObject.handleMessage("teleportSound");
			return Phantom.MESSAGE_HANDLED;
		}
		
	}
}