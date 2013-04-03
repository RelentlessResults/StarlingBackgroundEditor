package events
{
	import flash.events.Event;

	public class LevelModelEvent extends Event
	{
		
		public static const SELECTED_QUAD_CHANGE:String = "selectedQuadChange";
		
		public function LevelModelEvent(type:String) {
			super(type);
		}
	}
}