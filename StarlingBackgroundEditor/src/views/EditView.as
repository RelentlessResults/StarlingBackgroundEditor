package views
{
	import spark.components.supportClasses.SkinnableComponent;
	
	import org.spicefactory.parsley.view.Configure;
	
	public class EditView extends SkinnableComponent
	{
		
		[SkinPart]
		public var objectList:QuadListView;
		
		
		
		public function EditView() {
			super();
			Configure.view(this).execute();
		}
	}
}