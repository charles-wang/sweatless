package sweatless.navigation.core{
	import flash.utils.Dictionary;
	
	import sweatless.layout.Layers;
	import sweatless.navigation.basics.BasicLoading;
	import sweatless.ui.LoaderBar;
	
	public final class Config{
		
		private static var file : XML;
		private static var actualArea : String;
		private static var initialized : Boolean;
		private static var parameters : Dictionary = new Dictionary();
		private static var loadings : Dictionary = new Dictionary();
		
		public static function get started():Boolean{
			return initialized;
		}

		public static function set started(p_value:Boolean):void{
			initialized = p_value;
		}

		public static function set source(p_file:XML):void{
			file = p_file;
		}
		
		public static function get source():XML{
			return file;
		}

		public static function get currentAreaID():String{
			return actualArea;
		}
		
		public static function set currentAreaID(p_area:String):void{
			actualArea = p_area;
		}
		
		public static function get firstArea():String{
			return String(source..areas.@first);
		}
		
		public static function get crossdomain():String{
			return String(source..crossdomain.@file);
		}
		
		public static function getFlashVars(p_name:String):Object{
			return parameters[p_name];
		}
		
		public static function setFlashVars(p_name:String, p_value:Object):void{
			parameters[p_name] = p_value;
		}
		
		public static function getService(p_id:String):String{
			return String(source..services.service.(@id==p_id).@url);
		}
		
		public static function getTracking(p_id:String):String{
			return String(source..trackings.tracking.(@id==p_id).@url);
		}
		
		public static function get layers():XMLList{
			return source..layer;
		}
		
		public static function get areas():XMLList{
			return source..area;
		}
		
		public static function getInArea(p_id:String, p_attribute:String):String{
			return String(areas.(@id==p_id)[p_attribute]);
		}
		
		public static function getAreaAdditionals(p_id:String, p_attribute:String):String{
			return String(areas.(@id==p_id).additionals[p_attribute]);
		}
		
		public static function getAreaDependencies(p_id:String, p_type:String):Dictionary{
			var dependencies : Dictionary = new Dictionary();
			var i : uint = 0;
			
			switch(p_type){
				case "image":
					for(i=0; i<areas.(@id==p_id).dependencies..image.length(); i++){
						dependencies[String(areas.(@id==p_id).dependencies..image[i].@id)] = String(areas.(@id==p_id).dependencies..image[i].@url);
					}
				break;
				
				case "video":
					for(i=0; i<areas.(@id==p_id).dependencies..video.length(); i++){
						dependencies[String(areas.(@id==p_id).dependencies..video[i].@id)] = String(areas.(@id==p_id).dependencies..video[i].@url);
					}
				break;
				
				case "audio":
					for(i=0; i<areas.(@id==p_id).dependencies..audio.length(); i++){
						dependencies[String(areas.(@id==p_id).dependencies..audio[i].@id)] = String(areas.(@id==p_id).dependencies..audio[i].@url);
					}
				break;
				
				case "other":
					for(i=0; i<areas.(@id==p_id).dependencies..other.length(); i++){
						dependencies[String(areas.(@id==p_id).dependencies..other[i].@id)] = String(areas.(@id==p_id).dependencies..other[i].@url);
					}
				break;
			}
			
			return dependencies;
		}

		public static function getLoading(p_id:String):BasicLoading{
			return loadings[p_id];
		}

		public static function addLoading(p_loading:Class, p_id:String):void{
			!Layers.exists("loading") ? Layers.add("loading") : null;
			loadings[p_id] = Layers.get("loading").addChild(new p_loading());
		}

		public static function hasDeeplink(p_deeplink:String):Boolean{
			for(var key : String in getAllDeeplinks()){
				if(p_deeplink == getAllDeeplinks()[key]) return true;
			}
			
			return false;
		}
		
		public static function getDeeplinkByArea(p_area:String):String{
			for(var key : String in getAllDeeplinks()){
				if(p_area == key) return getAllDeeplinks()[key];
			}
			
			return getAreaAdditionals(firstArea, "@deeplink");
		}
		
		public static function getAreaByDeeplink(p_deeplink:String):String{
			for(var key : String in getAllDeeplinks()){
				if(p_deeplink == getAllDeeplinks()[key]) return key;
			}
			
			return firstArea;
		}
		
		public static function getAllDeeplinks():Dictionary{
			var deeplinks : Dictionary = new Dictionary();
			
			for(var i:uint=0; i<areas.length(); i++){
				deeplinks[String(areas[i].@id)] = String("/" + getAreaAdditionals(String(areas[i].@id), "@deeplink"));
			}
			
			return deeplinks;
		}
		
		public static function getMenu(p_type:String="*"):Dictionary{
			var all : Boolean = p_type == "*" ? true : false;
			var buttons : Dictionary = new Dictionary();
			
			//trace(attributes[String(source..button[a].@*[b].name())], source..button[a].@*[b])
			
			for(var a:uint=0; a<uint(all ? source..button.length() : source..buttons.(@type==p_type).button.length()); a++){
				var attributes : Object = new Object();
				for(var b:uint=0; b<uint(all ? source..button[a].@*.length() : source..buttons.(@type==p_type).button[a].@*.length()); b++){
					all ? attributes[String(source..button[a].@*[b].name())] = source..button[a].@*[b] : attributes[String(source..buttons.(@type==p_type)..button[a].@*[b].name())] = source..buttons.(@type==p_type)..button[a].@*[b];
				}
			
				all ? buttons[String(source..button[a].@area)] = attributes : buttons[String(source..buttons.(@type==p_type)..button[a].@area)] = attributes;
			}
			
			/*for(var i:uint=0; i<uint(all ? source..button.length() : source..buttons.(@type==p_type).button.length()); i++){
				all ? String(source..button[i].@external) ? buttons[String(source..button[i].@external)] = String(source..button[i].@label) : buttons[String(source..button[i].@area)] = String(source..button[i].@label) : String(source..buttons.(@type==p_type)..button[i].@external) ? buttons[String(source..buttons.(@type==p_type)..button[i].@external)] = String(source..buttons.(@type==p_type)..button[i].@label) : buttons[String(source..buttons.(@type==p_type)..button[i].@area)] = String(source..buttons.(@type==p_type)..button[i].@label);
			}*/
			
			return buttons;
		}
	}
}
