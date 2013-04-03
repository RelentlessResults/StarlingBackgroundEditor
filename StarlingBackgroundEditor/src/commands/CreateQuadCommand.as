package commands {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import messages.CreateQuadMessage;
	
	import models.QuadModel;
	
	import vo.QuadVO;

	public class CreateQuadCommand {
		
		private var newVO:QuadVO;
		private var loader:Loader;
		
		[Inject]
		public var model:QuadModel;
		
		public var callback:Function;
		
		public function execute(msg:CreateQuadMessage):void {
			newVO = new QuadVO;
			newVO.label = msg.file.name;
			newVO.imageURL = msg.file.url;
			newVO.scaleX = 1;
			newVO.scaleY = 1;
			newVO.x = 0;
			newVO.y = 0;
			loader = new Loader()
			loader.load(new URLRequest(newVO.imageURL), new LoaderContext(false, null, null));
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageLoaded);
		}
		
		protected function handleIOError(event:IOErrorEvent):void {
			callback(event);
		}
		
		protected function handleImageLoaded(event:Event):void {
			newVO.width = loader.width;
			newVO.height = loader.height;
			model.quads.addItem(newVO);
			callback();
		}
	}
}