package events {
	
	import flash.events.Event;

	public class UIModelEvent extends Event {
		
		public static const IS_PANNING_CHANGE:String="isPanningChange";
		
		public function UIModelEvent(type:String) {
			super(type);
		}
	}
}
