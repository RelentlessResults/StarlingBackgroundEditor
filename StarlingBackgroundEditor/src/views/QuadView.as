package views {
	
	import flash.events.MouseEvent;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	import models.QuadModel;
	
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
			addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		protected function handleClick(event:MouseEvent):void {
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