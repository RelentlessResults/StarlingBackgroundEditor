package messages {
	
	public class LoadLevelMessage {
		
		private var _path:String;
		
		public function get path():String {
			return _path;
		}
		
		public function LoadLevelMessage(path:String) {
			_path = path;
		}
		
	}
}