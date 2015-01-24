import com.haxepunk.Entity;
interface IMultiInputtable
{
  public function handleInputDown( x:Float, y:Float, ?dragging:Entity ):Void;
  public function handleInputUp( x:Float, y:Float, ?dragging:Entity ):Void;
  public function handleInputMoving( x:Float, y:Float, ?dragging:Entity ):Void;
  public function collidePoint( type:String, px:Float, py:Float ):Entity;
}