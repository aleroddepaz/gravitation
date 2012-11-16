package game.components 
{
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	public class SceneBounds extends GameObjectComponent 
	{
		private var outOfBounds:Boolean = false;
		
		public function SceneBounds()
		{
			
		}
		
		override public function update(elapsedTime:Number):void
		{
			if (!outOfBounds && (gameObject.position.x < -10 || gameObject.position.x > 800 + 10 
			|| gameObject.position.y < -10 || gameObject.position.y > 600 + 10))
			{
				outOfBounds = true;
				trace("Very bad!");
			}
		}
	}
}