package commands {
	import messages.DeleteQuadMessage;
	
	import models.QuadModel;

	public class DeleteQuadCommand {
		
		[Inject]
		public var model:QuadModel;
		
		public function execute(msg:DeleteQuadMessage):void {
			model.quads.removeItemAt(model.quads.getItemIndex(msg.quad));
		}
	}
}