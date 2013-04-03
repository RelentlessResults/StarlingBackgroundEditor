package messages {
	import vo.QuadVO;
	
	public class MoveQuadDepthMessage {
		
		public static const UP_ONE:String = "upOne";
		public static const DOWN_ONE:String = "downOne";
		
		public static const TO_TOP:String = "toTop";
		public static const TO_BOTTOM:String = "toBottom";
		
		private var _moveType:String;
		private var _quad:QuadVO;
		
		public function get quad():QuadVO {
			return _quad;
		}
		public function get moveType():String {
			return _moveType;
		}
		
		public function MoveQuadDepthMessage(quad:QuadVO, moveType:String) {
			_quad = quad;
			_moveType = moveType;
		}
	}
}