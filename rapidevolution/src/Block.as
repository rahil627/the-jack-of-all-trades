package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Block extends Sprite {
		public static var width:int = 25; //TODO: Does this override width/height? Is there only one width/height for all instances?
		public static var height:int = 25;
		[Embed(source='images/Block.png')]
		private const image:Class;
		
		public function Block() {
			/*
			this.graphics.lineStyle(1, 0xFFFFFF);
			this.graphics.beginFill(0x000000, 1);
			this.graphics.drawRect(0, 0, 25, 25);
			this.graphics.endFill();
			*/
			var bitmap:Bitmap = new image();
			bitmap.height = 25;
			bitmap.width = 25;
			this.addChild(bitmap);
		}
	}
}