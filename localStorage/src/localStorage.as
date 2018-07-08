package
{
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	
	public class localStorage extends Sprite
	{
		private var storage:SharedObject;
		public function localStorage()
		{
			storage=SharedObject.getLocal("localStorage");
			ExternalInterface.addCallback("getItem", this.getItem);
			ExternalInterface.addCallback("setItem", this.setItem);
			ExternalInterface.addCallback("clear", this.clear);
			ExternalInterface.addCallback("removeItem", this.removeItem);
		}
		private function getItem(key:String):String{
			return storage.data[key];
		}
		private function setItem(key:String,value:String):void{
			storage.data[key]=value;
			storage.flush();
		}
		private function clear():void{
			storage.clear();
		}
		private function removeItem(key:String):void{
			delete storage.data[key];
			storage.flush();
		}
	}
}