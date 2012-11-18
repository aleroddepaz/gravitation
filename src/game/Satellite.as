package game
{
	import game.components.RotateAround;
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.objects.Mover;
	
	public class Satellite extends GameObject
	{
		public function Satellite()
		{
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(Gravitation.satelliteColor));
			addComponent(new Mover(new Vector3D(0, 0), 0, 0, true));
			addComponent(new RotateAround());
		}
	}
}