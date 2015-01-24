import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;


class Button extends Entity implements IDraggable
{
  private var shape_image_off:Image;
  private var shape_image_on:Image;

  public function new()
  {
    super();

    /*
      Create a new Image graphic
      http://haxepunk.com/documentation/api/com/haxepunk/graphics/Image.html#createRect
     */
    shape_image_off = Image.createRect( 100, 100, 0xEEDD33 );
    shape_image_on  = Image.createRect( 100, 100, 0x3399FF );

    /*
      Set the Entity.graphic to the new image
      http://haxepunk.com/documentation/api/com/haxepunk/Entity.html#graphic
     */
    this.graphic = shape_image_off;

    this.setHitbox( 100, 100 );


    // this.setOrigin( Std.int(this.centerX), Std.int(this.centerY) );
    // this.setOrigin( 50, 50 );
  }

  public function activate()
  {
    this.graphic = shape_image_on;
    // this.centerGraphicInRect();
    // this.centerOrigin();
  }
  public function deactivate()
  {
    this.graphic = shape_image_off;
    // this.centerGraphicInRect();
    // this.centerOrigin();
  }

  public function dragStart(x:Float,y:Float):Void
  {
    follow_input(x,y);
  }
  public function dragMove(x:Float,y:Float):Void
  {
    follow_input(x,y);
  }
  public function dragEnd(x:Float,y:Float):Void
  {
    follow_input(x,y);
  }

  private inline function follow_input(x:Float, y:Float):Void
  {
    this.x = x - this.halfWidth;
    this.y = y - this.halfHeight;
  }

}