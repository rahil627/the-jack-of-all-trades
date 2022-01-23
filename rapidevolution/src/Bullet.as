package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Bullet extends Sprite {
		
		private var speed:int = 15;
		private var isInRightDirection:Boolean;
		private var stageRef:Stage;
		private var level:Level;
		private var enemyHolder:Sprite;
		
		public function Bullet(stageRef:Stage, x:int, y:int, isInRightDirection:Boolean) {
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawCircle(0, 0, 2.5);
			this.graphics.endFill();
			
			this.stageRef = stageRef;			
			this.x = x;
			this.y = y;
			this.isInRightDirection = isInRightDirection;
			
			level = stageRef.getChildByName('level') as Level;
			enemyHolder = level.getChildByName('enemyHolder') as Sprite;
			
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function loop(event:Event):void {
			if (!parent || !level)
				return;
			
			if (isInRightDirection)
				this.x += speed;
			else
				this.x -= speed;
				
			if (x < 0 || x > 500)
				deconstruct();
			
			//if hitting enemy, enemy takes hit and bullet deconstructs
			var enemy:Enemy;
			for (var i:int = 0; i < enemyHolder.numChildren; i++) {
				enemy = enemyHolder.getChildAt(i) as Enemy;
				if (hitTestObject(enemy) && !enemy.isDead)	{
					enemy.takeHit();
					deconstruct();
				}
			}
		}
		
		private function deconstruct():void {
			removeEventListener(Event.ENTER_FRAME, loop);
			if (stageRef.contains(this))
					stageRef.removeChild(this);
		}
	}
}