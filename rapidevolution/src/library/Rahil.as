package library  {
	import flash.display.DisplayObjectContainer;
	
	public class Rahil {
		
		//public function Rahil() { //not needed?
			
		//}
		
		public static function removeAllChildren(object:DisplayObjectContainer):void { //TODO: shouldn't this be recursive?
			while (object.numChildren > 0)
				object.removeChildAt(0);
		}
		
		public static function removeAllChildrenAndSelf(object:DisplayObjectContainer):void { //TODO: shouldn't this be recursive?
			while (object.numChildren > 0)
				object.removeChildAt(0);
			object.parent.removeChild(object);
		}
		
	}
}