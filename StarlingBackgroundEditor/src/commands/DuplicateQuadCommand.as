package commands {
	
	import messages.DuplicateQuadMessage;
	import models.QuadModel;
	import vo.QuadVO;

	public class DuplicateQuadCommand {
		
		[Inject]
		public var model:QuadModel;
		
		public function execute(msg:DuplicateQuadMessage):void {
			var newQuad:QuadVO = new QuadVO();
			newQuad.label = msg.quad.label;
			newQuad.imageURL = msg.quad.imageURL;
			newQuad.x = msg.quad.x;
			newQuad.y = msg.quad.y;
			newQuad.width = msg.quad.width;
			newQuad.height = msg.quad.height;
			newQuad.alphaA = msg.quad.alphaA;
			newQuad.alphaB = msg.quad.alphaB;
			newQuad.alphaC = msg.quad.alphaC;
			newQuad.alphaD = msg.quad.alphaD;
			newQuad.rotation = msg.quad.rotation;
			
			var index:int = model.quads.getItemIndex(msg.quad);
			model.quads.addItemAt(newQuad, index+1);
		}
	}
}