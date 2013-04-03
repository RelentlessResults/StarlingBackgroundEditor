package views {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.NumericStepper;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	import events.LevelModelEvent;
	
	import messages.MoveQuadDepthMessage;
	
	import models.QuadModel;
	
	import org.spicefactory.parsley.view.Configure;
	
	import vo.QuadVO;
	
	
	[SkinState("noSelection")]
	[SkinState("quadSelected")]
	
	public class QuadPropertiesView extends SkinnableComponent {
		
		[SkinPart]
		public var moveUpButton:Button;
		
		[SkinPart]
		public var moveDownButton:Button;
		
		[SkinPart]
		public var moveTopButton:Button;
		
		[SkinPart]
		public var moveBottomButton:Button;
		
		[SkinPart]
		public var xPositionSpinner:NumericStepper;
		
		[SkinPart]
		public var yPositionSpinner:NumericStepper;
		
		[SkinPart]
		public var widthSpinner:NumericStepper;
		
		[SkinPart]
		public var heightSpinner:NumericStepper;
		
		[SkinPart]
		public var rotationSpinner:NumericStepper;
		
		[SkinPart]
		public var labelTextInput:TextInput
		
		
		[Inject]
		public var levelModel:QuadModel;
		
		[MessageDispatcher]
		public var dispatch:Function;
		
		public function QuadPropertiesView() {
			super();
			Configure.view(this).execute();
		}
		
		[Bindable(event="quadChange")]
		public function get quad():QuadVO {
			return levelModel?levelModel.selectedQuad:null;
		}
		
		[MessageHandler(selector="selectedQuadChange")]
		public function handleSelectedQuadChange(e:LevelModelEvent):void {
			dispatchEvent(new Event("quadChange"));
			invalidateSkinState();
		}
		
		protected override function getCurrentSkinState():String {
			if (quad)
				return "quadSelected";
			return "noSelection";
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == moveUpButton) {
				moveUpButton.addEventListener(MouseEvent.CLICK, handleMoveUpClick);
			} else if (instance == moveDownButton) {
				moveDownButton.addEventListener(MouseEvent.CLICK, handleMoveDownClick);
			} else if (instance == moveTopButton) {
				moveTopButton.addEventListener(MouseEvent.CLICK, handleMoveTopClick);
			} else if (instance == moveBottomButton) {
				moveBottomButton.addEventListener(MouseEvent.CLICK, handleMoveBottomClick);
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void {
			if (instance == moveUpButton) {
				moveUpButton.removeEventListener(MouseEvent.CLICK, handleMoveUpClick);
			} else if (instance == moveDownButton) {
				moveDownButton.removeEventListener(MouseEvent.CLICK, handleMoveDownClick);
			} else if (instance == moveTopButton) {
				moveTopButton.removeEventListener(MouseEvent.CLICK, handleMoveTopClick);
			} else if (instance == moveBottomButton) {
				moveBottomButton.removeEventListener(MouseEvent.CLICK, handleMoveBottomClick);
			}
			super.partRemoved(partName, instance);
		}
		
		protected function handleMoveUpClick(event:MouseEvent):void {
			dispatch(new MoveQuadDepthMessage(quad, MoveQuadDepthMessage.UP_ONE));
		}
		
		protected function handleMoveDownClick(event:MouseEvent):void {
			dispatch(new MoveQuadDepthMessage(quad, MoveQuadDepthMessage.DOWN_ONE));
		}
		
		protected function handleMoveTopClick(event:MouseEvent):void {
			dispatch(new MoveQuadDepthMessage(quad, MoveQuadDepthMessage.TO_TOP));
		}
		
		protected function handleMoveBottomClick(event:MouseEvent):void {
			dispatch(new MoveQuadDepthMessage(quad, MoveQuadDepthMessage.TO_BOTTOM));
		}
		
	}
}