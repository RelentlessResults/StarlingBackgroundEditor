package models {
	
	import mx.collections.ArrayCollection;
	
	import events.LevelModelEvent;
	
	import vo.QuadVO;
	
	
	public class QuadModel {
		
		[MessageDispatcher]
		public var dispatch:Function;
		
		private var _quads:ArrayCollection = new ArrayCollection();
		private var _selectedQuad:QuadVO;
		
		[Bindable]
		public var canvasWidth:Number = 2048;
		
		[Bindable]
		public var canvasHeight:Number = 2048;
		
		[Bindable]
		public var zoomLevel:Number = 1;
		
		public function get quads():ArrayCollection {
			return _quads;
		}
		
		public function setSelectedQuad(value:QuadVO):void {
			_selectedQuad = value;
			dispatch(new LevelModelEvent(LevelModelEvent.SELECTED_QUAD_CHANGE));
		}
		
		public function get selectedQuad():QuadVO {
			return _selectedQuad;
		}
		
	}
}