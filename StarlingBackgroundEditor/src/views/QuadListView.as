package views {
	
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import spark.components.Button;
	import spark.components.List;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	import messages.CreateQuadMessage;
	import messages.DeleteQuadMessage;
	import messages.DuplicateQuadMessage;
	
	import models.QuadModel;
	
	import org.spicefactory.parsley.view.Configure;
	
	import vo.QuadVO;
	
	public class QuadListView extends SkinnableComponent {
		
		[SkinPart]
		public var list:List;
		
		[SkinPart]
		public var addQuadButton:Button;
		
		[SkinPart]
		public var deleteQuadButton:Button;
		
		[SkinPart]
		public var duplicateQuadButton:Button;
		
		[MessageDispatcher]
		public var dispatch:Function;
		
		[Bindable]
		[Inject]
		public var quadModel:QuadModel;
		
		public function QuadListView() {
			super();
			Configure.view(this).execute();
		}
		
		[MessageHandler(type="events.LevelModelEvent", selector="selectedQuadChange")]
		public function handleModelSelectedQuadChange():void {
			if (!list)
				return;
			list.selectedItem = quadModel.selectedQuad;
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == list) {
				list.addEventListener(IndexChangeEvent.CHANGE, handleIndexChange);
			} else if (instance == addQuadButton) {
				addQuadButton.addEventListener(MouseEvent.CLICK, handleAddQuadClick);
			} else if (instance == deleteQuadButton) {
				deleteQuadButton.addEventListener(MouseEvent.CLICK, handleDeleteQuadClick);
			} else if (instance == duplicateQuadButton) {
				duplicateQuadButton.addEventListener(MouseEvent.CLICK, handleDuplicateQuadClick);
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void {
			if (instance == list) {
				list.removeEventListener(IndexChangeEvent.CHANGE, handleIndexChange);
			} else if (instance == addQuadButton) {
				addQuadButton.removeEventListener(MouseEvent.CLICK, handleAddQuadClick);
			} else if (instance == deleteQuadButton) {
				deleteQuadButton.removeEventListener(MouseEvent.CLICK, handleDeleteQuadClick);
			} else if (instance == duplicateQuadButton) {
				duplicateQuadButton.addEventListener(MouseEvent.CLICK, handleDuplicateQuadClick);
			}
			super.partRemoved(partName, instance);
		}
		
		protected function handleDuplicateQuadClick(event:MouseEvent):void {
			dispatch(new DuplicateQuadMessage(list.selectedItem as QuadVO));
		}
		
		protected function handleDeleteQuadClick(event:MouseEvent):void {
			dispatch( new DeleteQuadMessage(list.selectedItem as QuadVO) );
		}
		
		protected function handleAddQuadClick(event:MouseEvent):void {
			var f:File = File.desktopDirectory;
			var filter:FileFilter = new FileFilter("Images", "*.png");
			f.addEventListener(FileListEvent.SELECT_MULTIPLE, handleFilesSelected);
			f.browseForOpenMultiple("Select your images", [filter] );
		}
		
		protected function handleFilesSelected(event:FileListEvent):void {
			var files:Array = event.files;
			for each (var file:File in files) {
				dispatch(new CreateQuadMessage(file as File));
			}
		}
		
		protected function handleIndexChange(event:IndexChangeEvent):void {
			quadModel.setSelectedQuad(list.selectedItem as QuadVO); 
		}
	}
}