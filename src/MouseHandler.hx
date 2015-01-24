/*
  
  Scene will instantiate this, and call it's update() method

 */

import com.haxepunk.utils.Input;
import com.haxepunk.Entity;


class MouseHandler implements IInputHandler
{
  private static inline var DRAGGABLE = "DRAGGABLE";
  
  private var scene:IMultiInputtable;
  private var dragging:Entity;

  public function new( scene:IMultiInputtable )
  {
    this.scene = scene;
    this.dragging = null;
  }

  public function getCollisionType():String
  {
    return MouseHandler.DRAGGABLE;
  }

  public function update():Void
  {
    // pressed this frame?
    if( Input.mousePressed && dragging == null ){

      // store any entity clicked on
      dragging = scene.collidePoint( DRAGGABLE , Input.mouseX, Input.mouseY );

    }

    // report movement if there is an item dragging
    if( dragging != null ){
      scene.handleInputMoving( Input.mouseX, Input.mouseY, dragging );
    }

    // down every frame
    if(Input.mouseDown){
      scene.handleInputDown( Input.mouseX, Input.mouseY, dragging );

    }else if(Input.mouseReleased){
      scene.handleInputUp( Input.mouseX, Input.mouseY, dragging );
    }

    // released this frame?
    if( Input.mouseReleased && dragging != null ){
      scene.handleInputUp( Input.mouseX, Input.mouseY, dragging );
      dragging = null;
    }
  }

}
