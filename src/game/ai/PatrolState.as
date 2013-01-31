package game.ai 
{
	import flash.geom.Vector3D;
	import game.Gravitation;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	public class PatrolState extends State 
	{
		private var positions:Vector.<Vector3D>;
		private var speed:Number;
		private var index:int;
		
		public function PatrolState(speed:Number, positions:Vector.<Vector3D>)
		{
			this.speed = speed;
			this.index = 0;
			this.positions = positions;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (Vector3D.distance(Gravitation.player.position, gameObject.position) < 300)
			{
				stateMachine.addState(new SeekState(speed));
			}
			else if (Vector3D.distance(gameObject.position, positions[index]) > 0.1)
			{
				var desiredVelocity:Vector3D = positions[index].subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(speed);
				gameObject.mover.velocity = desiredVelocity;
			}
			else
			{
				index++;
				index %= positions.length;
			}
		}
		
	}

}