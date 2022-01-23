package {
	import flash.display.Stage;
	public class Dog extends Enemy {
		[Embed(source = "images/Runaway Dog.gif")]
		private const image:Class;
		
		public function Dog(stageRef:Stage):void {
			super(stageRef);//calls the base constructor
			this.moveSpeed = 3.5;
			this.direction = 1;
			this.hitPoints = 99999999;
			
			bitmap = new image();
			bitmap.height = 25;
			bitmap.width = 23;
			
			this.addChild(bitmap);
		}
	}
}