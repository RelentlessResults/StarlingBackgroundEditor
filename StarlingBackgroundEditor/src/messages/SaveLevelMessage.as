package messages {
	
	public class SaveLevelMessage {
		
		public static const SAVE_AS_NEW:String = "saveAsNew";
		public static const SAVE_EXISTING:String = "saveExisting";
		
		private var _type:String;
		
		public function get type():String {
			return _type;
		}
		
		public function SaveLevelMessage(type:String) {
			_type = type;
		}
	}
}