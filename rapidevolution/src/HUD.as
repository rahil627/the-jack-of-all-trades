package {
	import de.polygonal.ds.ArrayedQueue;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	//if the player contiously uses on skill, the players gains a skill point
	//if the player stops, the counter resets
	//if the player gains a skill point in another area, the least recently used skill decreases and resets the counter for that skill
	public class HUD extends HUD_design {
		private var _movingPower:int = 0; //0-3
		private var _jumpingPower:int = 0;
		private var _firingPower:int = 0;
		private var stageRef:Stage;
		private var player:Player;
		private var staticText:TextField;
		private var queue:ArrayedQueue;
		private var threeSeconds:Timer;
		private var lastJumpCounter:int;
		private var lastFireCounter:int;
		private var lastMoveCounter:int;
		
		public function HUD(stageRef:Stage) {
			this.stageRef = stageRef;
			player = stageRef.getChildByName('player') as Player;
			
			this.name = 'hud';
			this.x = 30;
			this.y = 30;
			
			queue = new ArrayedQueue(4);
			
			this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
			threeSeconds = new Timer(3000, 0);
			threeSeconds.addEventListener(TimerEvent.TIMER, checkRecentlyUsedSkills, false, 0, true);
		}
		
		//if the player has not recently used a skill, reset the counter
		private function checkRecentlyUsedSkills(e:TimerEvent):void {
			checkRecentlyMoved();
			checkRecentlyJumped();
			checkRecentlyFired();
		}
		
		private function checkRecentlyMoved():void {
			if (player.moveCounter <= lastMoveCounter)
				player.moveCounter = 0;
			lastMoveCounter = player.moveCounter;
		}
		
		private function checkRecentlyJumped():void {
			if (player.jumpCounter <= lastJumpCounter)
				player.jumpCounter = 0;
			lastJumpCounter = player.jumpCounter;
		}
		
		private function checkRecentlyFired():void {
			if (player.fireCounter <= lastFireCounter)
				player.fireCounter = 0;
			lastFireCounter = player.fireCounter;
		}
		
		private function loop(event:Event):void {
			handlePowers();
		}
		
		private function handlePowers():void { //TODO: OO programming? leave code in player class
			if (!this.parent)
				return;
				
			//movingSpeedPower
			if (player.moveCounter >= 250 && _movingPower < 1) { //had to use >= since moveCounter can skip over the number
				movingPower = 1;
				queue.enqueue('m');
			}
			else if (player.moveCounter >= 750 && _movingPower < 2) {
				movingPower = 2;
				queue.enqueue('m');
			}
			else if (player.moveCounter >= 2750 && _movingPower < 3) {
				movingPower = 3;
				queue.enqueue('m');
			}
				
			//jumpSpeedPower
			if(player.jumpCounter == 5 && _jumpingPower < 1) {
				jumpingPower = 1;
				queue.enqueue('j');
			}
			else if(player.jumpCounter == 20 && _jumpingPower < 2) {
				jumpingPower = 2;
				queue.enqueue('j');
			}
			else if(player.jumpCounter == 65 && _jumpingPower < 3) {
				jumpingPower = 3;
				queue.enqueue('j');
			}
			
			//firingSpeedPower
			if (player.fireCounter == 5 && _firingPower < 1) {
				firingPower = 1;
				queue.enqueue('f');
			}
			else if (player.fireCounter == 25 && _firingPower < 2) {
				firingPower = 2;
				queue.enqueue('f');
			}
			else if (player.fireCounter == 100 && _firingPower < 3) {
				firingPower = 3;
				queue.enqueue('f');
			}
			
			//reallocate powers
			if (_jumpingPower + _movingPower + _firingPower >= 4) {
				var character:String = queue.peek() as String;
				
				//remove the last one in the queue
				queue.dequeue();
				
				switch (character) {
					case 'j':
						jumpingPower = _jumpingPower - 1;
						player.jumpCounter = 0;
						break;
					case 'm':
						movingPower = _movingPower - 1;
						player.moveCounter = 0;
						break;
					case 'f':
						firingPower = _firingPower - 1;
						player.fireCounter = 0;
						break;
				}
			}
		}
		
		public function set movingPower(n:int):void {
			_movingPower = n;
			movingPowerText.text = String(n);
			
			switch (n) {
				case 0:
					player.moveSpeed = 2.5;
					break;
				case 1:
					player.moveSpeed = 4.5;
					break;
				case 2:
					player.moveSpeed = 7;
					break;
				case 3:
					player.moveSpeed = 21;
					break;
				default:
					trace("switch error");
			}
		}
		
		public function set jumpingPower(n:int):void {
			_jumpingPower = n;
			jumpingPowerText.text = String(n);
			
			switch (n) {
				case 0:
					player.jumpSpeedDenominator = 50;
					break;
				case 1:
					player.jumpSpeedDenominator = 75;
					break;
				case 2:
					player.jumpSpeedDenominator = 100;
					break;
				case 3:
					player.jumpSpeedDenominator = 250;
					break;
				default:
					trace("switch error");
			}
		}
		
		public function set firingPower(n:int):void {
			_firingPower = n;
			firingPowerText.text = String(n);
			
			switch (n) {
				case 0:
					player.fireRate = 500;
					break;
				case 1:
					player.fireRate = 350;
					break;
				case 2:
					player.fireRate = 200;
					break;
				case 3:
					player.fireRate = 25;
					break;
				default:
					trace("switch error");
			}
		}
	}
}