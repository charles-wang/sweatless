/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 Sweatless Team 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * http://code.google.com/p/sweatless/
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * @author Valério Oliveira (valck)
 * 
 */

package sweatless.text{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SmartText extends Sprite{
		private var _format : TextFormat;
		private var _field : TextField;
		private var _autosize : String = "left";
		
		public static const RESTRICT_SPECIAL_CHARS : String = ". \\' \\\" \\- ( ) ? ' , _ ! & : ;";
		public static const RESTRICT_EMAIL : String = "a-z 0-9 @ _ . \\-";
		public static const RESTRICT_NUMBER : String = "0-9";
		public static const RESTRICT_LOWERCASE : String = "a-z âãàáèéêìíõòôóùûúç";
		public static const RESTRICT_UPPERCASE : String = "A-Z ÂÃÀÁÈÉÊÌÍÕÒÔÓÙÛÚÇ";
		
		public function SmartText(p_format:TextFormat=null){
			super();
		
			_format = p_format || new TextFormat();
			_field = new TextField();
			
			_field.embedFonts = true;
			addChild(_field);
			
			update();
		}
		
		private function update():void{
			_field.setTextFormat(_format);
			
			_field.defaultTextFormat = _format;
			_field.autoSize = _autosize;
		}
		
		public function set align(p_value:String):void{
			_format.align = p_value;
			
			update();
		}
		
		public function set autoSize(p_value:String):void{
			_autosize = p_value;
			
			update();
		}
		
		public function get autoSize():String{
			return _autosize;
		}
		
		public function get length():uint{
			return _field.length;
		}
		
		public function set format(p_format:TextFormat):void{
			_format = p_format;
			
			update();
		}
		
		public function set font(p_value:String):void{
			_format.font = p_value;
			
			update();
		}
		
		public function set color(p_value:uint):void{
			_format.color = p_value;
			
			update();
		}
		
		public function set size(p_value:uint):void{
			_format.size = p_value;
			
			update();
		}
		
		public function set lineSpacing(p_value:Number):void{
			_format.leading = p_value;
			
			update();
		}
		
		public function set letterSpacing(p_value:Number):void{
			_format.letterSpacing = p_value;
			
			update();
		}
		
		public function set kerning(p_value:Number):void{
			_format.kerning = p_value;
			
			update();
		}
		
		public function set tab(p_value:int):void{
			_field.tabIndex = p_value;
		}
		
		public function get tab():int{
			return _field.tabIndex;
		}
		
		public function set alias(p_value:String):void{
			_field.antiAliasType = p_value;
		}
		
		public function set maxChars(p_value:int):void{
			_field.maxChars = p_value;
		}
		
		public function set restrict(p_value:String):void{
			_field.restrict = p_value;
		}
		
		public function set type(p_value:String):void{
			_field.type = p_value;
			p_value == "input" ? _field.selectable = _field.mouseEnabled = _field.tabEnabled = true : _field.selectable = _field.mouseEnabled = _field.tabEnabled = false;
		}
		
		public function set password(p_value:Boolean):void{
			_field.displayAsPassword = p_value;
		}
		
		public function set multiline(p_value:Boolean):void{
			_field.multiline = _field.wordWrap = p_value;
		}
		
		public function set thickness(p_value:Number):void{
			_field.thickness = p_value;
		}
		
		public function set sharpness(p_value:Number):void{
			_field.sharpness = p_value;
		}
		
		override public function set width(p_value:Number):void{
			_field.width = p_value;
		}
		
		override public function get width():Number{
			return _field.width;
		}
		
		override public function set height(p_value:Number):void{
			_field.height = p_value;
		}
		
		override public function get height():Number{
			return _field.height;
		}
		
		public function get field():TextField{
			return _field;
		}
		
		public function set text(p_text:String):void{
			_field.htmlText = p_text;

			update();
		}
		
		public function get text():String{
			return _field.text;
		}
		
		public function destroy():void{
			_format = null;
			
			removeChild(_field);
			_field = null;
		}
		
	}
}	
