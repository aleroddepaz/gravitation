package game.ai 
{
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class SeekState extends State 
	{
		private var target:GameObject;
		
		public function SeekState(target:GameObject) 
		{
			this.target = target;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			//TODO: Seek state
		}
		
	}

}