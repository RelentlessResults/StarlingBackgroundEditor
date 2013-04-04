package views {
	
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	import spark.components.supportClasses.SkinnableComponent;
	
	import events.UIModelEvent;
	
	import models.QuadModel;
	import models.UIModel;
	
	import org.spicefactory.parsley.view.Configure;
	
	public class CanvasView extends SkinnableComponent {
		
		[SkinPart]
		public var canvasGroup:Group;
		
		[Inject]
		[Bindable]
		public var quadModel:QuadModel;
		
		[Inject]
		[Bindable]
		public var uiModel:UIModel;
		
		[MessageHandler(type="events.UIModelEvent",selector="isPanningChange")]
		public function handleIsPanningChange(e:UIModelEvent):void {
			this.useHandCursor = uiModel.isPanning;
			this.buttonMode = uiModel.isPanning;
		}
		
		public function CanvasView() {
			super();
			Configure.view(this).execute();
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == canvasGroup) {
				canvasGroup.addEventListener(MouseEvent.MOUSE_DOWN, handleCanvasMouseDown);
				canvasGroup.addEventListener(MouseEvent.MOUSE_UP, handleCanvasMouseUp);
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void {
			if (instance == canvasGroup) {
				canvasGroup.removeEventListener(MouseEvent.MOUSE_DOWN, handleCanvasMouseDown);
				canvasGroup.removeEventListener(MouseEvent.MOUSE_UP, handleCanvasMouseUp);
			}
			super.partRemoved(partName, instance);
		}
		
		protected function handleCanvasMouseUp(event:MouseEvent):void {
			canvasGroup.stopDrag();
		}
		
		protected function handleCanvasMouseDown(event:MouseEvent):void {
			canvasGroup.startDrag();
		}
	}
}