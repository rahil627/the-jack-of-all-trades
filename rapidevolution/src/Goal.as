package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Goal extends Sprite {
		
		private var stageRef:Stage;
		private var ran:Boolean = false;
		private var isWrong:Boolean; //for levels with two goals
		private var isHidden:Boolean; //for jumping level 2
		
		[Embed(source = "images/Heart.gif")]
		private const rightImage:Class;
		
		[Embed(source = "images/Mani Mani.gif")]
		private const wrongImage:Class;
		
		private var bitmap:Bitmap;
		
		public function Goal(stageRef:Stage, isWrong:Boolean = false, isHidden:Boolean = false) {
			this.stageRef = stageRef;
			this.isWrong = isWrong;
			
			if (isHidden) {
				this.graphics.drawRect(0, 0, 25, 25);
				this.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
				return;
			}
			
			if (isWrong) {
				bitmap = new wrongImage();
				bitmap.width = 18.75;
				bitmap.height = 25
			}
			else {
				bitmap = new rightImage();
				bitmap.width = 25;
				bitmap.height = 18.75;
			}
			
			this.addChild(bitmap);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(event:Event):void {
			if (!this.parent)
				return;
			
 			if (this.hitTestObject(this.stageRef.getChildByName('player'))) {
				this.removeEventListener(Event.ENTER_FRAME, loop);
				var main:Main = Main.instance;
				main.generateNextPart(null, isWrong);
			}
		}
	}
}