package
{
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	
	public class sessionStorage extends Sprite
	{
		private var storage:SharedObject;
		public function sessionStorage()
		{
			var sessionId:String=getSessionId();
			if(sessionId==null){
				sessionId=setSessionId();
			}
			storage=SharedObject.getLocal("sessionStorage-"+sessionId);
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
		private function getSessionId():String{
			var cookies:String=ExternalInterface.call("eval","document.cookie");
			var arr:Array=cookies.match(new RegExp("(^| )JSESSIONID=([^;]+)(;|$)"));
			if(arr != null) return decodeURIComponent(arr[2]); return null;
		}
		private function setSessionId():String{
			var id:String=Math.random().toString().replace("0.","r");
			ExternalInterface.call("eval","document.cookie='JSESSIONID="+id+"; path=/'");
			return id;
		}
	}
}