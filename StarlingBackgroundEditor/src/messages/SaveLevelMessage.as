package messages {
	
	public class SaveLevelMessage {
		
		private var _path:String;
		
		public function get path():String {
			return _path;
		}
		public function SaveLevelMessage(path:String) {
			_path = path;
		}
	}
}