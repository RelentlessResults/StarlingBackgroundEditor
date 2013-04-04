package components
{
	import flash.display.Shader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import spark.primitives.Graphic;
	
	/**
	 * http://help.adobe.com/en_US/as3/dev/WSFDA04BAE-F6BC-43d9-BD9C-08D39CA22086.html 
	 * 
	 * 4 vertices and 2 triangles to simulate the gpu vertex alpha to be applied to an image
	 * 
	 * Shader from http://www.adobe.com/cfusion/exchange/index.cfm?event=extensionDetail&extid=1937522
	 * 
	 * @author Marcus
	 * 
	 */
	public class QuadAlpha extends Graphic
	{
		
		private var _alphaA:Number = 1;
		private var _alphaB:Number = 1;
		private var _alphaC:Number = 1;
		private var _alphaD:Number = 0;
		private var _displayInvalid:Boolean;
		
		private static var loader:URLLoader;
		private static var shader:Shader; 
		private static var shaderInitialised:Boolean;
		private static var _waitingInstances:Dictionary = new Dictionary();
		
		private static function init():void 
		{ 
			loader = new URLLoader(); 
			loader.dataFormat = URLLoaderDataFormat.BINARY; 
			loader.addEventListener(Event.COMPLETE, onLoadComplete); 
			loader.load(new URLRequest("triangle-gradient.pbj"));
			shaderInitialised = true;
		} 
		
		private static function onLoadComplete(event:Event):void 
		{ 
			shader = new Shader(loader.data); 
			for each (var instance:QuadAlpha in _waitingInstances) {
				instance.invalidateDisplayList();
			}
		} 
		
		public function QuadAlpha() {
			super();
			if (!shaderInitialised) {
				init();
			}
			invalidateDisplayList();
		}

		public function get alphaA():Number {
			return _alphaA;
		}

		public function set alphaA(value:Number):void {
			_alphaA = value;
			invalidateDisplayList();
		}

		public function get alphaB():Number {
			return _alphaB;
		}

		public function set alphaB(value:Number):void {
			_alphaB = value;
			invalidateDisplayList();
		}

		public function get alphaC():Number {
			return _alphaC;
		}

		public function set alphaC(value:Number):void {
			_alphaC = value;
			invalidateDisplayList();
		}

		public function get alphaD():Number {
			return _alphaD;
		}

		public function set alphaD(value:Number):void {
			_alphaD = value;
			invalidateDisplayList();
		}
		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			if (shader) {
				redrawData(unscaledWidth, unscaledHeight);
			} else {
				_waitingInstances[this] = this;
			}
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		private function redrawData(unscaledWidth:Number, unscaledHeight:Number):void {
			graphics.clear();
			drawTriangleA(unscaledWidth, unscaledHeight);
			drawTriangleB(unscaledWidth, unscaledHeight);
		}
		
		private function drawTriangleA(width:Number, height:Number):void {
			var vertices:Vector.<Number> = new Vector.<Number>();
			
			vertices.push(0);
			vertices.push(0);
			vertices.push(width);
			vertices.push(0);
			vertices.push(0);
			vertices.push(height);
			
			shader.data.pa.value = [0,0]; 
			shader.data.pb.value = [width,0]; 
			shader.data.pc.value = [0,height];
			shader.data.ca.value = [1.0,1.0,1.0, alphaA]; 
			shader.data.cb.value = [1.0,1.0,1.0, alphaB]; 
			shader.data.cc.value = [1.0,1.0,1.0, alphaC]; 
			
			graphics.beginShaderFill(shader);
			graphics.drawTriangles(vertices);
			graphics.endFill();
		}
		
		private function drawTriangleB(width:Number, height:Number):void {
			var vertices:Vector.<Number> = new Vector.<Number>();
			
			vertices.push(width);
			vertices.push(0);
			vertices.push(0);
			vertices.push(height);
			vertices.push(width);
			vertices.push(height);
			
			shader.data.pa.value = [width,0]; 
			shader.data.pb.value = [0,height];
			shader.data.pc.value = [width,height]; 
			shader.data.ca.value = [1.0,1.0,1.0, alphaB]; 
			shader.data.cb.value = [1.0,1.0,1.0, alphaC]; 
			shader.data.cc.value = [1.0,1.0,1.0, alphaD]; 
			
			graphics.beginShaderFill(shader);
			graphics.drawTriangles(vertices);
			graphics.endFill();
		}
		
	}
}