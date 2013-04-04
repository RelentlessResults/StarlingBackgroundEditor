package commands {
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import messages.SaveLevelMessage;
	
	import models.QuadModel;
	import models.SaveModel;
	
	import vo.QuadVO;
	
	public class SaveLevelCommand {
		
		
		[Inject]
		public var model:SaveModel;
		
		[Inject]
		public var state:QuadModel;
		
		public var callback:Function;
		
		public function execute(msg:SaveLevelMessage):void {
			if ((msg.type == SaveLevelMessage.SAVE_EXISTING) && (model.file)) {
				saveToFile(model.file);
			} else {
				saveAsNew();
			}
		}
		
		public function saveAsNew():void {
			var f:File = File.desktopDirectory;
			f.addEventListener(Event.COMPLETE, handleSaveComplete);
			f.save(serialiseState(), "untitled.xml");
		}
		
		private function saveToFile(f:File):void {
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.WRITE);
			fs.writeUTFBytes(serialiseState());
			fs.close();
		}
		
		protected function handleSaveComplete(event:Event):void {
			model.file = event.target as File;
			callback();
		}
		
		private function serialiseState():XML {
			var result:XML = new XML(<composite/>);
			//state
			result.appendChild(serialiseTopLevel());
			//nodes
			var nodes:XML = new XML(<nodes/>);
			for each (var quad:QuadVO in state.quads) {
				nodes.appendChild(serialiseQuad(quad));
			}
			result.appendChild(nodes);
			return result;
		}
		
		private function serialiseTopLevel():Object {
			var result:XML = new XML(<settings/>);
			result.@canvasWidth = state.canvasWidth;
			result.@canvasHeight = state.canvasHeight;
			return result;
		}
		
		private function serialiseQuad(quad:QuadVO):XML {
			var result:XML = new XML(<quad/>);
			result.@label = quad.label;
			result.@imageURL = quad.imageURL;
			result.@x = quad.x;
			result.@y = quad.y;
			result.@width = quad.width;
			result.@height = quad.height;
			result.@rotation = quad.rotation;
			result.@alphaA = quad.alphaA;
			result.@alphaB = quad.alphaB;
			result.@alphaC = quad.alphaC;
			result.@alphaD = quad.alphaD;
			return result;
		}
		
	}
}