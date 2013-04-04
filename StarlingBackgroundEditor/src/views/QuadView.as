package views {
	
	import flash.events.MouseEvent;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	import models.QuadModel;
	import models.UIModel;
	
	import org.spicefactory.parsley.view.Configure;
	
	import vo.QuadVO;
	
	[SkinState("selected")]
	[SkinState("unselected")]
	public class QuadView extends SkinnableComponent {
		
		[Bindable]
		public var quad:QuadVO;
		
		public var _selected:Boolean;
		
		[Inject]
		public var levelModel:QuadModel;
		
		[Inject]
		public var uiModel:UIModel;
		
		public function QuadView() {
			super();
			Configure.view(this).execute();
		}
		
		[MessageHandler(type="events.LevelModelEvent", selector="selectedQuadChange")]
		public function handleQuadSelectionChange():void {
			if (_selected) {
				if (levelModel.selectedQuad != quad) {
					_selected = false;
					invalidateSkinState();
				}
			} else {
				if (levelModel.selectedQuad == quad) {
					_selected = true;
					invalidateSkinState();
				}
			}
		}
		
		public override function initialize():void {
			super.initialize();
			addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
		}
		
		protected function handleDown(event:MouseEvent):void {
			if (uiModel.isPanning)
				return;
			levelModel.setSelectedQuad(quad);
		}
		
		protected function handleMouseDown(event:MouseEvent):void {
			levelModel.setSelectedQuad(quad);
		}
		
		protected override function getCurrentSkinState():String {
			if (_selected)
				return "selected";
			return "unselected";
		}
	}
}