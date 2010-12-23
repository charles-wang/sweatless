/**
 * Licensed under the MIT License and Creative Commons 3.0 BY-SA
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
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * THE WORK (AS DEFINED BELOW) IS PROVIDED UNDER THE TERMS OF THIS CREATIVE COMMONS PUBLIC 
 * LICENSE ("CCPL" OR "LICENSE"). THE WORK IS PROTECTED BY COPYRIGHT AND/OR OTHER APPLICABLE LAW. 
 * ANY USE OF THE WORK OTHER THAN AS AUTHORIZED UNDER THIS LICENSE OR COPYRIGHT LAW IS 
 * PROHIBITED.
 * BY EXERCISING ANY RIGHTS TO THE WORK PROVIDED HERE, YOU ACCEPT AND AGREE TO BE BOUND BY THE 
 * TERMS OF THIS LICENSE. TO THE EXTENT THIS LICENSE MAY BE CONSIDERED TO BE A CONTRACT, THE 
 * LICENSOR GRANTS YOU THE RIGHTS CONTAINED HERE IN CONSIDERATION OF YOUR ACCEPTANCE OF SUCH 
 * TERMS AND CONDITIONS.
 * 
 * http://creativecommons.org/licenses/by-sa/3.0/legalcode
 * 
 * http://code.google.com/p/sweatless/
 * 
 * @author Valério Oliveira (valck)
 * 
 */

package sweatless.text{
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import sweatless.utils.StringUtils;

	public class CSSFormat{
		public static function getClass(p_sheet:String, p_target:String):Object{
			var sheet : StyleSheet = new StyleSheet();
			sheet.parseCSS(p_sheet);
			
			return sheet.getStyle(p_target);
		}
		
		public static function toTextFormat(p_sheet:String, p_target:String):TextFormat{
			var sheet : StyleSheet = new StyleSheet();
			sheet.parseCSS(p_sheet);
			
			return sheet.transform(forceParser(sheet.getStyle(p_target)));
		}
		
		public static function toTextFormatGroup(p_sheet:String):Dictionary{
			var sheet : StyleSheet = new StyleSheet();
			sheet.parseCSS(p_sheet);
			
			var results : Dictionary = new Dictionary(true);
			
			for(var i:uint=0; i<sheet.styleNames.length; i++){
				var style : Object = forceParser(sheet.getStyle(sheet.styleNames[i]));
				results[sheet.styleNames[i]] = sheet.transform(style);
			}
			
			return results;
		}
		
		private static function forceParser(p_style:Object):Object{
			for (var property : String in p_style){
				property == "fontFamily" ? p_style[property] = clean(p_style[property], "\"", "") : null;
				property == "bold" ? p_style[property] = StringUtils.toBoolean(p_style[property]) : null;
				property == "italic" ? p_style[property] = StringUtils.toBoolean(p_style[property]) : null;
				property == "bullet" ? p_style[property] = StringUtils.toBoolean(p_style[property]) : null;
				property == "kerning" ? p_style[property] = StringUtils.toBoolean(p_style[property]) : null;
				property == "underline" ? p_style[property] = StringUtils.toBoolean(p_style[property]) : null;
			}
			
			return p_style;
		}
		
		private static function clean(p_str:String, p_search:String, p_replace:String):String{
			return StringUtils.replace(p_str, p_search, p_replace); 
		}
	}
}