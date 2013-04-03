package components
{
	import spark.primitives.Graphic;
	
	/**
	 * Credit: http://www.purplesquirrels.com.au/2011/06/drawing-a-checker-board-pattern-quickly-with-as3/ 
	 * @author Marcus
	 * 
	 */
	public class Checker extends Graphic
	{
		public function Checker()
		{
			super();
		}
		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			graphics.clear();
			// Box colour 1
			var even:uint = 0xCCCCCC;
			
			// Box colour 2
			var odd:uint = 0x999999;
			
			// Box size
			var size:int = 10;
			
			// number of boxes horizontally
			var nH:int = unscaledWidth / size + 1;
			
			// number of boxes vertically
			var nV:int = unscaledHeight / size + 1;
			
			// vars to be used in the loops
			var clr:uint;
			var i:uint;
			var j:uint;
			
			// loop vertical
			for (i=0;i<nV;++i)
			{
				// Flip values of Even and Odd colours using Bitwise operations
				even ^= odd;
				odd  ^= even;
				even ^= odd;
				
				// loop horizontal
				for (j=0;j<nH;++j)
				{
					//bitwise modulus
					//check if column is odd or even, then set colour
					clr = j & 1 ? even : odd;
					
					// draw box with previously set colour
					graphics.beginFill(clr,1);
					graphics.drawRect(Number(j*size),Number(i*size),size,size);
					graphics.endFill();
				}
			}
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
	}
}