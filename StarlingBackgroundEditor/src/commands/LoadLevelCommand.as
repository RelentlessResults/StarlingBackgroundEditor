package commands {
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import messages.LoadLevelMessage;
	
	import models.QuadModel;
	import models.SaveModel;
	
	import vo.QuadVO;

	public class LoadLevelCommand {
		
		[Inject]
		public var state:QuadModel;

		[Inject]
		public var model:SaveModel;
		
		public var callback:Function;
		
		private var f:File;
		
		public function execute(msg:LoadLevelMessage):void {
			f = File.desktopDirectory;
			f.browseForOpen("Select save file", [new FileFilter("XML", "*.xml")]);
			f.addEventListener(Event.SELECT, handleFileSelected);
		}
		
		protected function handleFileSelected(event:Event):void {
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			var xmlString:String = fs.readUTFBytes(fs.bytesAvailable);
			initialiseState();
			writeState(XML(xmlString));
			model.file = f;
			callback();
		}
		
		private function initialiseState():void {
			state.quads.removeAll();
		}
		
		private function writeState(xml:XML):void {
			state.canvasWidth = xml.settings.@canvasWidth;
			state.canvasHeight = xml.settings.@canvasHeight;
			var quad:QuadVO;
			for each (var quadData:XML in xml.nodes.quad) {
				quad = createQuad(quadData);
				state.quads.addItem(quad);
			}
		}
		
		private function createQuad(data:XML):QuadVO {
			var result:QuadVO = new QuadVO();
			result.label = data.@label;
			result.imageURL = data.@imageURL;
			result.x = data.@x;
			result.y = data.@y;
			result.width = data.@width;
			result.height = data.@height;
			result.rotation = data.@rotation;
			result.alphaA = data.@alphaA;
			result.alphaB = data.@alphaB;
			result.alphaC = data.@alphaC;
			result.alphaD = data.@alphaD;
			return result;
		}
	}
}