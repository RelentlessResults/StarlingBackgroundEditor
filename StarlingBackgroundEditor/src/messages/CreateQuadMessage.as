package messages
{
	import flash.filesystem.File;

	public class CreateQuadMessage {
		
		private var _file:File;
		
		public function get file():File {
			return _file;
		}
		
		public function CreateQuadMessage(file:File) {
			_file = file;
		}
	}
}