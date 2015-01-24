import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.utils.Input;

class MainScene extends Scene implements IMultiInputtable
{
  // #if mobile
  // private var touch_handler:TouchHandler;
  // #else
  // private var mouse_handler:MouseHandler;
  // #end

  private var input_handler:IInputHandler;

  private var left_button:Button;
  private var right_button:Button;


  public override function begin()
  {

    /*
      Create two buttons for testing
     */
    left_button = new Button();
    right_button = new Button();

    /*
      Add the buttons to this scene
      http://haxepunk.com/documentation/api/com/haxepunk/Scene.html#add
     */
    add( left_button );
    add( right_button );

    // position the buttons
    left_button.x = 150;
    left_button.y = 150;

    right_button.x = 350;
    right_button.y = 150;


    #if mobile

      #if debug
        trace("using TouchHandler");
      #end

      /*
        Setup Touch Event Handler
       */
      input_handler = new TouchHandler(this);

    #else
    
      #if debug
        trace("using MouseHandler");
      #end
      /*
        Setup Mouse Event Handler
       */
      input_handler = new MouseHandler(this);

    #end

    left_button.type = input_handler.getCollisionType();
    right_button.type = input_handler.getCollisionType();

  }

  public override function update()
  {
    input_handler.update();
    
    super.update();
  }

  public inline function handleInputDown( x: Float, y: Float, ?dragging:Entity ):Void
  {
    if( left_button.collidePoint( left_button.x, left_button.y, x, y ) ){
      left_button.activate();

      if( dragging == null )
        left_button.dragStart( x, y );
    }
    if( right_button.collidePoint( right_button.x, right_button.y, x, y ) ){
      right_button.activate();

      if( dragging == null )
        right_button.dragStart( x, y );
    }
  }

  public inline function handleInputMoving( x: Float, y:Float, ?dragging:Entity ):Void
  {
    if( dragging == left_button)
      left_button.dragMove( x, y );

    if( dragging == right_button)
      right_button.dragMove( x, y );

  }

  public inline function handleInputUp( x: Float, y: Float, ?dragging:Entity ):Void
  {
    if( left_button.collidePoint( left_button.x, left_button.y, x, y )  ){
      left_button.deactivate();
      left_button.dragEnd( x, y );
    }
    if( right_button.collidePoint( right_button.x, right_button.y, x, y )  ){
      right_button.deactivate();
      right_button.dragEnd( x, y );
    }
  }

  // input down while moving
  /*
  public inline function handleInputDrag( x: Float, y: Float ):Void
  {
    if( left_button.collidePoint( left_button.x, left_button.y, x, y ) ){
      left_button.activate();
    }
    if( right_button.collidePoint( right_button.x, right_button.y, x, y ) ){
      right_button.activate();
    }
  }

  public inline function handleInputDragging( x: Float, y: Float ):Void
  {
    if( left_button.collidePoint( left_button.x, left_button.y, x, y ) ){
      left_button.activate();
    }
    if( right_button.collidePoint( right_button.x, right_button.y, x, y ) ){
      right_button.activate();
    }
  }

  public inline function handleInputDragStop( x: Float, y: Float ):Void
  {
    if( left_button.collidePoint( left_button.x, left_button.y, x, y )  ){
      left_button.deactivate();
    }
    if( right_button.collidePoint( right_button.x, right_button.y, x, y )  ){
      right_button.deactivate();
    }
  }*/

}