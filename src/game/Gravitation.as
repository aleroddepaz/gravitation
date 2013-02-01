package game
{
	import flash.display.Graphics;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	import game.ai.IdleState;
	import game.ai.PatrolState;
	import game.components.player.ShieldHealth;
	import game.components.Shield;
	import game.components.Teleport;
	import game.gameobjects.*;
	import nl.jorisdormans.phantom2D.cameras.CameraEase;
	import nl.jorisdormans.phantom2D.cameras.FollowObject;
	import nl.jorisdormans.phantom2D.cameras.RestrictToLayer;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.ObjectLayer;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	
	public class Gravitation extends Screen
	{
		private var particleLayer:ParticleLayer;
		private var objectLayer:ObjectLayer;
		private var planets:Vector.<Planet> = new Vector.<Planet>();
		private var pickups:Vector.<Pickup> = new Vector.<Pickup>();
		private var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		private var checkPoint:Checkpoint;
		
		public static var player:Player;
		
		public function Gravitation(numLevel:int)
		{
			super(800, 600);
			camera.addComponent(new FollowObject(null));
			camera.addComponent(new CameraEase());
			ShieldHealth.numShields = 0;
			switch(numLevel)
			{
				case 0:
					createFirstLevel();
					break;
				case 1:
					createSecondLevel();
					break;
				case 2:
					createThirdLevel();
					break;
				case 3:
					createFourthLevel();
					break;
				case 4:
					createFifthLevel();
					break;
				case 5:
					createSixthLevel();
					break;
				case 6:
					createSeventhLevel();
					break;
				case 7:
					createEigthLevel();
					break;
				case 8:
					createNinthLevel();
					break;
				case 9:
					createTenthLevel();
					break;
			}
			camera.addComponent(new RestrictToLayer(objectLayer));
		}
		
		private function addPickup(planet:Planet, distance:Number):void
		{
			var position:Vector3D = calculatePosition(planet.position, distance, Math.random() * Math.PI * 2);
			objectLayer.addGameObject(pickups[pickups.length] = new Pickup(planet, distance), position);
			Main.incrementTotalPickups();
		}
		
		private function addShieldPickup(planet:Planet, distance:Number):void
		{
			var position:Vector3D = calculatePosition(planet.position, distance, Math.random() * Math.PI * 2);
			var pickup:Pickup = new Pickup(planet, distance);
			pickup.addComponent(new Shield());
			objectLayer.addGameObject(pickups[pickups.length] = pickup, position);
		}
		
		private function addPlayer(planet:Planet, distance:Number):void
		{
			var position:Vector3D = calculatePosition(planet.position, distance, Math.PI / 4);
			objectLayer.addGameObject(checkPoint = new Checkpoint(planet), position);
		}
		
		private function addPlanet(planet:Planet, positionX:Number, positionY:Number):void
		{
			var position:Vector3D = new Vector3D(positionX, positionY);
			objectLayer.addGameObject(planet, position);
		}
		
		private function addEnemy(enemy:Enemy, positionX:Number, positionY:Number):void
		{
			var position:Vector3D = new Vector3D(positionX, positionY);
			objectLayer.addGameObject(enemy, position);
		}
		
		private function calculatePosition(position:Vector3D, distance:Number, angle:Number):Vector3D 
		{
			var positionX:Number = position.x + distance * Math.cos(angle);
			var positionY:Number = position.y + distance * Math.sin(angle);
			return new Vector3D(positionX, positionY)
		}
		
		private function createFirstLevel():void
		{
			addLayers(800, 600);
			addPlanet(planets[0] = new Planet(null), 250, 400);
			addPlanet(planets[1] = new Planet(null), 550, 200);
			addPickup(planets[1], 70);
			addPlayer(planets[0], 60);
		}
		
		private function createSecondLevel():void
		{
			addLayers(800, 600);
			addPlanet(planets[0] = new Planet(null, 50, false), 400, 300);
			addPlanet(planets[1] = new Planet(planets[0]), 300, 200);
			addPlanet(planets[2] = new Planet(planets[0]), 300, 400);
			addPlanet(planets[3] = new Planet(planets[0]), 550, 300);
			addPickup(planets[2], 60);
			addPickup(planets[3], 60);
			addPlayer(planets[1], 60);
		}
		
		private function createThirdLevel():void
		{
			addLayers(1200, 1200);
			addPlanet(planets[0] = new Planet(null, 60, false), 600, 600);
			addPlanet(planets[1] = new Planet(planets[0]), 300, 300);
			addPlanet(planets[2] = new Planet(planets[0]), 900, 900);
			addPlanet(planets[3] = new Planet(planets[0]), 450, 450);
			addPlanet(planets[4] = new Planet(planets[0]), 750, 750);
			planets[3].addComponent(new Teleport(planets[2]));
			addPickup(planets[2], 60);
			addPickup(planets[4], 60);
			addPlayer(planets[1], 60);
		}
		
		
		private function createFourthLevel():void
		{
			addLayers(800, 600);
			addPlanet(planets[0] = new Planet(null), 200, 200);
			addPlanet(planets[1] = new Planet(null), 200, 400);
			addPlanet(planets[2] = new Planet(null), 600, 200);
			addPlanet(planets[3] = new Planet(null), 600, 400);
			addEnemy(enemies[0] = new Enemy(new IdleState(30)), 400, 300);
			addPickup(planets[1], 60);
			addPickup(planets[2], 60);
			addPickup(planets[3], 60);
			addPlayer(planets[0], 60);
		}
		
		private function createFifthLevel():void
		{
			addLayers(800, 600);
			addPlanet(planets[0] = new Planet(null), 150, 300);
			addPlanet(planets[1] = new Planet(null), 400, 300);
			addPlanet(planets[2] = new Planet(null), 650, 200);
			addPlanet(planets[3] = new Planet(null), 650, 400);
			addEnemy(enemies[0] = new Enemy(new IdleState(30)), 700, 300);
			addShieldPickup(planets[1], 60);
			addPickup(planets[2], 60);
			addPickup(planets[3], 60);
			addPlayer(planets[0], 60);
		}
		
		private function createSixthLevel():void
		{
			addLayers(800, 600);
			addPlanet(planets[0] = new Planet(null, 50, false), 500, 300);
			addPlanet(planets[1] = new Planet(planets[0]), 420, 220);
			addPlanet(planets[2] = new Planet(planets[0]), 580, 220);
			addPlanet(planets[3] = new Planet(planets[0]), 420, 380);
			addPlanet(planets[4] = new Planet(planets[0]), 580, 380);
			addPlanet(planets[5] = new Planet(null), 150, 300);
			
			addPickup(planets[1], 50);
			addPickup(planets[2], 50);
			addPickup(planets[3], 50);
			addPickup(planets[4], 50);
			
			addPlayer(planets[5], 60);
		}
		
		private function createSeventhLevel():void
		{
			addLayers(800, 600);
			addPlanet(planets[0] = new Planet(null, 90), 500, 300);
			addPlanet(planets[1] = new Planet(null), 130, 130);
			addPlanet(planets[2] = new Planet(planets[1], 16, false), 20, 100);
			addPlanet(planets[3] = new Planet(null), 130, 470);
			addPlanet(planets[4] = new Planet(planets[3], 16, false), 100, 580);
			planets[2].handleMessage("setSpeed", { speed: 1 } );
			planets[4].handleMessage("setSpeed", { speed: 1 } );
			
			addPickup(planets[0], 110);
			addPickup(planets[0], 190);
			addPickup(planets[0], 230);
			addPickup(planets[0], 270);
			addPickup(planets[1], 60);
			addShieldPickup(planets[3], 60);
			
			addEnemy(enemies[0] = new Enemy(new IdleState(40)), 130, 300);
			
			addPlayer(planets[0], 150);
		}
		
		private function createEigthLevel():void
		{
			addLayers(900, 700);
			addPlanet(planets[0] = new Planet(null), 100, 500);
			addPlanet(planets[1] = new Planet(null, 50), 375, 500);
			addPlanet(planets[2] = new Planet(null, 30, false), 375, 395);
			addPlanet(planets[3] = new Planet(null, 50), 700, 500);
			addPlanet(planets[4] = new Planet(null, 30, false), 595, 500);
			addPlanet(planets[5] = new Planet(null, 50), 700, 200);
			addPlanet(planets[6] = new Planet(null, 30, false), 700, 305);
			addPlanet(planets[7] = new Planet(null), 375, 200);
			planets[7].addComponent(new Teleport(planets[0]));
			
			addPickup(planets[1], 65);
			addPickup(planets[1], 145);
			addShieldPickup(planets[3], 65);
			addPickup(planets[3], 145);
			addPickup(planets[5], 65);
			addPickup(planets[5], 145);
			
			addEnemy(enemies[0] = new Enemy(new PatrolState(20)), 550, 400);
			enemies[0].handleMessage("addPatrolPoint", { positionX: 550, positionY: 300 } );
			enemies[0].handleMessage("addPatrolPoint", { positionX: 450, positionY: 300 } );
			enemies[0].handleMessage("addPatrolPoint", { positionX: 550, positionY: 400 } );
			
			addPlayer(planets[0], 70);
		}
		
		private function createNinthLevel():void
		{
			addLayers(800, 1100);
			addPlanet(planets[0] = new Planet(null, 50, false), 400, 300);
			addPlanet(planets[1] = new Planet(planets[0]), 300, 150);
			addPlanet(planets[2] = new Planet(planets[0]), 250, 300);
			addPlanet(planets[3] = new Planet(planets[0]), 300, 450);
			addPlanet(planets[4] = new Planet(planets[0]), 500, 150);
			addPlanet(planets[5] = new Planet(planets[0]), 500, 450);
			addPlanet(planets[6] = new Planet(planets[0]), 550, 300);
			addPlanet(planets[7] = new Planet(null, 20), 400, 650);
			addPlanet(planets[8] = new Planet(null, 40), 400, 900);
			planets[8].addComponent(new Teleport(planets[1]));
			
			addPickup(planets[2], 60);
			addShieldPickup(planets[3], 60);
			addPickup(planets[4], 60);
			addPickup(planets[5], 60);
			addShieldPickup(planets[6], 60);
			addPickup(planets[8], 60);
			addPickup(planets[8], 100);
			
			addEnemy(enemies[0] = new Enemy(new PatrolState(20)), 200, 800);
			addEnemy(enemies[1] = new Enemy(new PatrolState(20)), 600, 850);
			enemies[0].handleMessage("addPatrolPoint", { positionX: 200, positionY: 800 } );
			enemies[0].handleMessage("addPatrolPoint", { positionX: 600, positionY: 800 } );
			enemies[1].handleMessage("addPatrolPoint", { positionX: 200, positionY: 850 } );
			enemies[1].handleMessage("addPatrolPoint", { positionX: 600, positionY: 850 } );
			
			addPlayer(planets[1], 60);
		}
		
		private function createTenthLevel():void
		{
			addLayers(800, 600);
			addPlanet(planets[0] = new Planet(null, 20), 400, 300);
			addPlanet(planets[1] = new Planet(null, 20), 525, 300);
			addPlanet(planets[2] = new Planet(null, 20), 275, 300);
			addPlanet(planets[3] = new Planet(null, 20), 600, 200);
			addPlanet(planets[4] = new Planet(null, 20), 200, 200);
			addPlanet(planets[5] = new Planet(null, 20), 600, 400);
			addPlanet(planets[6] = new Planet(null, 20), 200, 400);
			
			addPlanet(planets[7] = new Planet(null), 400, 100);
			addPlanet(planets[8] = new Planet(null), 400, 500);
			addPlanet(planets[9] = new Planet(planets[7], 15, false), 400, 25);
			addPlanet(planets[10] = new Planet(planets[8], 15, false), 400, 575);
			planets[9].handleMessage("setSpeed", { speed: 1 } );
			planets[10].handleMessage("setSpeed", { speed: 1 } );
			
			addPickup(planets[1], 30);
			addPickup(planets[2], 30);
			addPickup(planets[3], 30);
			addPickup(planets[4], 30);
			addPickup(planets[5], 30);
			addPickup(planets[6], 30);
			addShieldPickup(planets[7], 45);
			addShieldPickup(planets[8], 45);
			
			addEnemy(enemies[0] = new Enemy(new PatrolState(30)), 100, 100);
			addEnemy(enemies[1] = new Enemy(new PatrolState(30)), 700, 500);
			enemies[0].handleMessage("addPatrolPoint", { positionX: 100, positionY: 500 } );
			enemies[0].handleMessage("addPatrolPoint", { positionX: 100, positionY: 100 } );
			enemies[1].handleMessage("addPatrolPoint", { positionX: 700, positionY: 100 } );
			enemies[1].handleMessage("addPatrolPoint", { positionX: 700, positionY: 500 } );
			
			addPlayer(planets[0], 40);
		}
		
		private function addLayers(width:Number, height:Number):void 
		{
			addComponent(new Background(0x888888, 0xaaaaaa, 0x888888));
			addComponent(particleLayer = new ParticleLayer(width, height, 1000));
			addComponent(objectLayer = new ObjectLayer(4, width, height));
			particleLayer.sprite.filters = [new BlurFilter()];
			objectLayer.sprite.filters = [new GlowFilter(0xffffff)];
			addComponent(new Hud());
		}
		
	}
}