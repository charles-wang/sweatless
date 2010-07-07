package sweatless.navigation.basics{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.describeType;
	
	import sweatless.events.Broadcaster;
	import sweatless.navigation.core.Config;
	import sweatless.utils.ValidateUtils;

	public class BasicMenu extends Sprite{
		
		public static const CHANGE : String = "change";
		
		private var type : String;
		private var buttons : Array;
		private var selected : BasicMenuButton;
		private var broadcaster : Broadcaster;
		
		public function BasicMenu(p_type:String="*"){
			type = p_type;
			
			broadcaster = Broadcaster.getInstance();
			
			buttons = new Array();
			
			for(var area : String in Config.getMenu(p_type)){
				buttons.push({area:area, label:Config.getMenu(type)[area], external:ValidateUtils.isUrl(area)});
			}
		}

		public function create():void{
			throw new Error("Please, override this method.");	
		}
		
		private function change(evt:*):void{
			var changed : BasicMenuButton = getButton(Config.currentAreaID);
			if(!changed) throw new Error("this button doesn't exists.");
			if(selected) selected.enabled();
			
			selected = changed;
			selected.disabled();
			
			dispatchEvent(new Event(BasicMenu.CHANGE));
		}
		
		private function getButton(p_area:String):BasicMenuButton{
			for(var i:uint=0; i<buttons.length; i++){
				if(BasicMenuButton(getChildAt(i)).area == p_area) return BasicMenuButton(getChildAt(i));
			}
			return null; 
		}
		
		protected final function getButtons(p_skin:Class):Array{
			var results : Array = new Array();
			if(String(describeType(p_skin)..extendsClass).search(BasicMenuButton.toString()) == -1) throw new Error("Please, extends BasicMenuButton Class");
			
			for(var i:uint=0; i<buttons.length; i++){
				var button : BasicMenuButton = new p_skin();
				
				button.area = buttons[i].area;
				button.type = type;
				button.label = buttons[i].label;
				button.external = buttons[i].external;
				
				broadcaster.hasEvent("show_"+buttons[i].area) ? broadcaster.addEventListener(broadcaster.getEvent("show_"+buttons[i].area), change) : null;
				
				results.push(button);
			}
			
			return results;
		}

		public function destroy():void{
			if(stage) parent.removeChild(this);
		}
		
		public static function toString():String{
			return "BasicMenu";
		}
	}
}