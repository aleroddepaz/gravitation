package game.components 
{
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class PickupProgress extends GameObjectComponent 
	{
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message)
			{
				case "pickupCollected":
					var main:Main = gameObject.objectLayer.screen.game as Main;
					main.updateProgress();
					return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}