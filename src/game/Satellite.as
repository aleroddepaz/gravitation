package game 
{
	import game.components.RotateAround;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	public class Satellite extends GameObject 
	{
		
		public function Satellite() 
		{
			addComponent(new BoundingCircle(16));
			addComponent(new BoundingShapeRenderer(0x3B3B3B));
			addComponent(new RotateAround());
		}
		
		public function rotateAroundPlanet(planet:Planet):void
		{
			var component:RotateAround = getComponentByClass(RotateAround) as RotateAround;
			component.setTarget(planet);
		}
	}

}