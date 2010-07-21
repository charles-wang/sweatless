package sweatless.graphics{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import sweatless.utils.NumberUtils;
	
	internal class CommonGraphic extends Shape{
		private var matrix : Matrix = new Matrix();
		
		private var _texture : BitmapData;
		private var _repeat : Boolean;
		private var _stroke : Boolean;

		private var _strokeSize : Number = 1;
		private var _strokeAlpha : uint = 1;
		private var _strokeColor : uint = 0x000000;
		private var _strokeMode : String = "normal";
		
		private var _fillColors : Array = new Array(0xff0000, 0x0000ff);
		private var _fillAlphas : Array = new Array(1, 1);
		
		private var _gradientRatios : Array = new Array(0, 255);
		private var _gradientRotation : Number = Math.PI / 2;
		private var _gradientTx : Number = 0;
		private var _gradientTy : Number = 0;

		private var _width : Number = 0;
		private var _height : Number = 0;
		
		private var _type : String = "linear";
		private var _method : String = "pad";

		public function CommonGraphic(){
			
		}

		protected function update(p_width:Number=NaN, p_height:Number=NaN):void{
			p_width = !p_width ? width : p_width;
			p_height = !p_height ? height : p_height;
			
			graphics.clear();
			
			if(!texture){
				matrix.createGradientBox(p_width, p_height, _gradientRotation, _gradientTx, _gradientTy);
				graphics.beginGradientFill(_type, _fillColors, _fillAlphas, _gradientRatios, matrix, _method);
			}else{
				graphics.beginBitmapFill(_texture, matrix, _repeat, true);
			}
			
			_stroke ? graphics.lineStyle(_strokeSize, _strokeColor, _strokeAlpha, true, _strokeMode): null;
			
			addGraphic();
			
			graphics.endFill();
		}
		
		protected function addGraphic():void{
			
		}
		
		public function get stroke():Boolean{
			return _stroke;
		}
		
		public function set stroke(p_value:Boolean):void{
			_stroke = p_value;
			update();
		}
		
		public function get strokeMode():String{
			return _strokeMode;
		}
		
		public function set strokeMode(value:String):void{
			_strokeMode = value;
			update();
		}
		
		public function get strokeColor():uint{
			return _strokeColor;
		}
		
		public function set strokeColor(value:uint):void{
			_strokeColor = value;
			update();
		}
		
		public function get strokeAlpha():uint{
			return _strokeAlpha;
		}
		
		public function set strokeAlpha(value:uint):void{
			_strokeAlpha = value;
			update();
		}
		
		public function get strokeSize():Number{
			return _strokeSize;
		}
		
		public function set strokeSize(value:Number):void{
			_strokeSize = value;
			update();
		}

		public function set gradientRotation(p_value:Number):void{
			_gradientRotation = NumberUtils.toRadians(p_value);
			update();
		}
		
		public function get gradientRotation():Number{
			return _gradientRotation;
		}
		
		public function set gradientTX(p_value:Number):void{
			_gradientTx = p_value;
			update();
		}
		
		public function get gradientTX():Number{
			return _gradientTx;
		}
		
		public function set gradientTY(p_value:Number):void{
			_gradientTy = p_value;
			update();
		}
		
		public function get gradientTY():Number{
			return _gradientTy;
		}
		
		public function set colors(p_value:Array):void{
			if(p_value.length>2) return;
			
			p_value.length == 1 ? p_value[1] = p_value[0] : p_value = p_value;
			
			_fillColors = p_value;
			update();
		}
		
		public function get colors():Array{
			return _fillColors;
		}
		
		public function set alphas(p_value:Array):void{
			if(p_value.length>2) return;
			
			_fillAlphas = p_value;
			update();
		}
		
		public function get alphas():Array{
			return _fillAlphas;
		}
		
		public function set ratios(p_value:Array):void{
			if(p_value.length>2) return;
			
			_gradientRatios = p_value;
			update();
		}
		
		public function get ratios():Array{
			return _gradientRatios;
		}
		
		public function set repeat(p_value:Boolean):void{
			if(!texture) return;
			_repeat = p_value;
			update();
		}
		
		public function get repeat():Boolean{
			return _repeat;
		}
		
		public function set texture(p_value:BitmapData):void{
			_texture = p_value;
			update();
		}
		
		public function get texture():BitmapData{
			return _texture;
		}
		
		
		public function get type():String{
			return _type;
		}
		
		public function set type(p_value:String):void{
			_type = p_value;
			update();
		}
		
		public function get method():String{
			return _method;
		}
		
		public function set method(p_value:String):void{
			_method = p_value;
			update();
		}
		
		public override function set width(p_value:Number):void{
			_width = p_value;
			update(p_value, NaN);
		}
		
		public override function set height(p_value:Number):void{
			_height = p_value;
			update(NaN, p_value);
		}
		
		public override function get width():Number{
			return _width;
		}
		
		public override function get height():Number{
			return _height;
		}
		
		public function destroy():void{
			_fillColors = new Array(0xff0000, 0x0000ff);
			_fillAlphas = new Array(1, 1);
			_gradientRatios = new Array(0, 255);
			
			_gradientRotation = Math.PI / 2;
			_gradientTx = 0;
			_gradientTy = 0;
			
			_width = 0;
			_height = 0;
			
			_type = "linear";
			_method = "pad";

			graphics.clear();
			if(texture) texture.dispose();
		}
	}
}