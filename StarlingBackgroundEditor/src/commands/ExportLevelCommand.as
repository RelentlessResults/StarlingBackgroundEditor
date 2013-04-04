package commands {
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import mx.controls.Alert;
	import models.QuadModel;
	import messages.ExportLevelMessage;
	
	public class ExportLevelCommand {
		
		[Inject]
		public var state:QuadModel;
		
		public function execute(msg:ExportLevelMessage):void {
			var json:String = serialiseState();
			copyToClipboard(json);
			Alert.show("JSON serialisation of the composite image has been copied to your clipboard");
		}
		
		private function copyToClipboard(json:String):void {
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, json);
		}
		
		private function serialiseState():String {
			//state
			var data:Array = state.quads.toArray();
			return JSON.stringify(data);
		}
		


	}
}