package vo {
	
	[Bindable]
	public class QuadVO {
		
		public var label:String;
		public var imageURL:String;
		
		public var x:Number = 0;
		public var y:Number = 0;
		
		public var width:Number = 128;
		public var height:Number = 128;
		
		public var rotation:Number = 0;
		
		public var alphaA:Number = 1;
		public var alphaB:Number = 1;
		public var alphaC:Number = 1;
		public var alphaD:Number = 1;
		
		private function get rotationRadians():Number {
			return Math.PI*rotation/180.0;
		}
		
		private function get labelWithoutExtension():String {
			return label.substr(0, label.lastIndexOf("."));
		}
		
		public function toJSON(k):* {
			return {
				"label":labelWithoutExtension,
				"x":x,"y":y,
				"width":width,"height":height,
				"rotation":rotationRadians,
				"alphaA":alphaA,
				"alphaB":alphaB,
				"alphaC":alphaC,
				"alphaD":alphaD};
		}
	}
}