package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Enemy extends Sprite {
		protected var stageRef:Stage;
		protected var moveSpeed:int;
		protected var direction:int;
		protected var bitmap:Bitmap;
		protected var hitPoints:int;
		public var isDead:Boolean = false;
		private const twoSeconds:Timer = new Timer(2000, 1);
		
		public function Enemy(stageRef:Stage) {
			this.stageRef = stageRef;
			
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			twoSeconds.addEventListener(TimerEvent.TIMER_COMPLETE, die2, false, 0, true);
		}
		
		/*
		public function startLoop():void {
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		public function endLoop():void {
			this.removeEventListener(Event.ENTER_FRAME, loop, false);
		}
		*/
		private function loop(e:Event):void {
			if (!this.parent) //TODO: WTF. enemy loop runs after the level is deconstructed
				return;
			
			//if hit player, restart level
			var player:Player = this.stageRef.getChildByName('player') as Player;
			if (this.hitTestObject(player))
				player.die();
			
			//if hit turnAroundMarker marker, turn around
			var levelRef:Sprite = stageRef.getChildByName('level') as Sprite;
			var turnAroundMarkerHolder:Sprite = levelRef.getChildByName('turnAroundMarkerHolder') as Sprite; //TODO: this is just terrible
			for (var i:int = 0; i < turnAroundMarkerHolder.numChildren; i++)
				if (hitTestObject(turnAroundMarkerHolder.getChildAt(i)))
					direction *= -1;
			
			//TODO: if touching wall turn back, create a special wall block?
			
			//move
			this.x += moveSpeed * direction;
		}
		
		public function takeHit():void {
			hitPoints = hitPoints - 1;
			if (hitPoints == 0)
				die();
		}
		
		protected function die():void {
			isDead = true;
			bitmap.y += 25; //TODO: awful
			bitmap.rotation = 90;
			this.removeEventListener(Event.ENTER_FRAME, loop);
			twoSeconds.start()
		}
		
		private function die2(event:Event):void {
			twoSeconds.removeEventListener(TimerEvent.TIMER_COMPLETE, die2);
			if (parent)
				this.parent.removeChild(this);
		}
	}
}