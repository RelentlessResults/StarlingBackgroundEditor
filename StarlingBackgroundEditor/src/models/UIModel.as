package models {
	import events.UIModelEvent;
	
	public class UIModel {
		
		[MessageDispatcher]
		public var dispatch:Function;
		
		private var _isPanning:Boolean;
		
		public function get isPanning():Boolean {
			return _isPanning;
		}
		
		public function setIsPanning(value:Boolean):void {
			_isPanning = value;
			dispatch(new UIModelEvent(UIModelEvent.IS_PANNING_CHANGE));
		}
		
	}
}