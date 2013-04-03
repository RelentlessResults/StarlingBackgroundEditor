package commands {
	
	import messages.MoveQuadDepthMessage;
	import models.QuadModel;
	import vo.QuadVO;
	import messages.QuadOrderChangedMessage;

	public class MoveQuadDepthCommand {
		
		[Inject]
		public var levelModel:QuadModel;
		
		[MessageDispatcher]
		public var dispatch:Function;
		
		public function execute(msg:MoveQuadDepthMessage):void {
			var changesMade:Boolean = false;
			switch(msg.moveType) {
				case MoveQuadDepthMessage.UP_ONE: {
					changesMade = move(msg.quad, 1);
					break;
				}
				case MoveQuadDepthMessage.DOWN_ONE: {
					changesMade = move(msg.quad, -1);
					break;
				}
				case MoveQuadDepthMessage.TO_TOP: {
					changesMade = moveToTop(msg.quad);
					break;
				}
				case MoveQuadDepthMessage.TO_BOTTOM: {
					changesMade = moveToBottom(msg.quad);
					break;
				}
					
			}
			if (changesMade) {
				dispatch(new QuadOrderChangedMessage());
			}
		}
		
		private function move(quad:QuadVO, difference:int):Boolean {
			var index:int = levelModel.quads.getItemIndex(quad);
			if (index == -1)
				return false;
			var newIndex:int = index + difference;
			if (newIndex > levelModel.quads.length)
				return false;
			levelModel.quads.removeItemAt(index);
			levelModel.quads.addItemAt(quad, newIndex);
			return true;
		}
		
		private function moveToTop(quad:QuadVO):Boolean {
			return move(quad, levelModel.quads.length);
		}
		
		private function moveToBottom(quad:QuadVO):Boolean {
			return move(quad, -levelModel.quads.getItemIndex(quad));
		}
		
	}
}