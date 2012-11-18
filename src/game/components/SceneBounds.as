package game.components 
{
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class SceneBounds extends GameObjectComponent 
	{
		override public function update(elapsedTime:Number):void
		{
			if (gameObject.position.x < -10 || gameObject.position.x > 800 + 10 
			|| gameObject.position.y < -10 || gameObject.position.y > 600 + 10)
			{
				gameObject.reset();
			}
		}
	}
}