package messages {
	
	import vo.QuadVO;

	public class DeleteQuadMessage {
		
		private var _quad:QuadVO;
		
		public function get quad():QuadVO {
			return _quad;
		}
		
		public function DeleteQuadMessage(quad:QuadVO) {
			_quad = quad;
		}
	}
}