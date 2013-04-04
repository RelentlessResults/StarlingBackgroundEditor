package tools {
	
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	
	/**
	 * 
	 * @author Marcus Relentless Results Ltd
	 * 
	 */
	public class CompositeImageFactory {
		
		private static var _instance:CompositeImageFactory;
		
		public static function getInstance():CompositeImageFactory {
			if (!_instance)
				_instance = new CompositeImageFactory(new SingletonEnforcer());
			return _instance;
		}
		
		public function CompositeImageFactory(enforcer:SingletonEnforcer) {
			if (!enforcer)
				throw new Error("Do not instantiate CompositeImageFactory manually. Please use the static function getInstance()");
		}
		
		public function LoadCompostiteFromJSONString(json:String, atlas:TextureAtlas, sprite:Sprite):Sprite {
			var quads:Array = JSON.parse(json) as Array;
			var newImage:Image;
			for each (var quadData:Object in quads) {
				newImage = generateImage(quadData, atlas);
				sprite.addChild(newImage);
			}
			return sprite;
		}
		
		private function generateImage(data:Object, atlas:TextureAtlas):Image {
			var result:Image = new Image(atlas.getTexture(data.label));
			result.x = data.x;
			result.y = data.y;
			result.rotation = data.rotation;
			result.width = data.width;
			result.height = data.height;
			result.setVertexAlpha(0, data.alphaA);
			result.setVertexAlpha(1, data.alphaB);
			result.setVertexAlpha(2, data.alphaC);
			result.setVertexAlpha(3, data.alphaD);
			return result;
		}
		
	}
}


class SingletonEnforcer {
}