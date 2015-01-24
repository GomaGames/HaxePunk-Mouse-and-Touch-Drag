interface IDraggable
{
  public function dragStart(x:Float,y:Float):Void;
  public function dragMove(x:Float,y:Float):Void;
  public function dragEnd(x:Float,y:Float):Void;
}