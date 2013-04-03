package messages {
	
	import vo.QuadVO;

	public class DuplicateQuadMessage {
		
		private var _quad:QuadVO;
		
		public function get quad():QuadVO {
			return _quad;
		}
		
		public function DuplicateQuadMessage(quad:QuadVO) {
			_quad = quad;
		}

	}
}