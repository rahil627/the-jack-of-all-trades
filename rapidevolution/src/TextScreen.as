package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import library.Rahil;
	
	public class TextScreen extends Sprite {
		
		private var stageRef:Stage;
		private var keyboard:KeyObject;
		private var ran:Boolean = false;
		private const fiveHundredMs:Timer = new Timer(500, 1);
		
		public function TextScreen(stageRef:Stage, text:String, addMother:Boolean = false/*, titleText:String = ""*/) {
			this.stageRef = stageRef;
			keyboard = new KeyObject(stageRef);
			
			var background:Sprite = new Sprite();
			background.graphics.drawRect(25, 25, stageRef.stageWidth - 50, stageRef.stageHeight - 50);
			this.addChild(background);
			
			/*
			var title:TextField = new TextField();
			title.text = (titleText)
			title.x = (stageRef.stageWidth / 2) - (title.width / 2);
			title.y = 50;
			title.textColor = 0xCCFF00;
			title.autoSize = TextFieldAutoSize.CENTER;
			this.addChild(title);
			*/
			
			var textField:TextField = new TextField();
			textField.wordWrap = true;
			textField.width = 300
			
			textField.text = (text)
			textField.x = (stageRef.stageWidth / 2) - (textField.width / 2);
			textField.y = (stageRef.stageHeight / 2) - (textField.height / 2);
			textField.textColor = 0xCCFF00;
			textField.autoSize = TextFieldAutoSize.CENTER;
			this.addChild(textField);
			
			if (addMother) {
				[Embed(source = "images/Old Woman (Front).gif")]
				var motherImage:Class;
				var mother:Bitmap = new motherImage();
				mother.x = (background.width / 2);
				mother.y = 50;
				this.addChild(mother);
			}
			
			fiveHundredMs.addEventListener(TimerEvent.TIMER_COMPLETE, addLoop, false, 0, true);
			fiveHundredMs.start();
		}
		
		//wait 500ms, then start caputuring keyboard
		private function addLoop(e:TimerEvent):void {
			removeEventListener(TimerEvent.TIMER_COMPLETE, addLoop);
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function loop(event:Event):void {
			if (!ran) {
				if (keyboard.isDown(keyboard.SPACE)) {
					ran = true;
					dispatchEvent(new Event('pressedSpaceFromTextScreen', true));
					keyboard.deconstruct();
					this.removeEventListener(Event.ENTER_FRAME, loop);
					Rahil.removeAllChildrenAndSelf(this);
				}
			}
		}
	}
}