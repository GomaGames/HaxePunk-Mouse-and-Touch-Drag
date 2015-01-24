/*
  
  Scene will instantiate this, and call it's update() method

 */

import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import haxe.ds.IntMap;

typedef DraggableTouch = {
  touch : Touch,
  dragging : Entity
}

class TouchHandler implements IInputHandler
{
  
  private static inline var DRAGGABLE = "DRAGGABLE";

  // store all touches here
  private var drag_touches:IntMap<DraggableTouch>;

  private var scene:IMultiInputtable;

  public function new( scene:IMultiInputtable )
  {
    this.scene = scene;
    this.drag_touches = new IntMap<DraggableTouch>();
  }

  public function getCollisionType():String
  {
    return TouchHandler.DRAGGABLE;
  }

  public function update()
  {

    if (Input.multiTouchSupported){

      Input.touchPoints(handleTouch);

      // check for any released touches
      for(drag_touch in drag_touches){
        if(Input.touches[drag_touch.touch.id] == null){
          touchRelease(drag_touch);
        }
      }

    }else{ trace("multiTouch is not supported."); }

  }

  private inline function handleTouch( touch:Touch )
  {
    if(!drag_touches.exists(touch.id)){

      // check for any draggables to pick up
      // store any entity touched
      var dragging = scene.collidePoint( DRAGGABLE , touch.x, touch.y );

      drag_touches.set(touch.id, { touch:touch, dragging:dragging });

      scene.handleInputDown(touch.x, touch.y, dragging);
    }else{

      var draggableTouch = drag_touches.get(touch.id);
      scene.handleInputMoving(draggableTouch.touch.x, draggableTouch.touch.y, draggableTouch.dragging);

    }
  }

  private inline function touchRelease( drag_touch:DraggableTouch )
  {
    // check for any draggables to pick up
    // store any entity touched
    // var dragging = scene.collidePoint( DRAGGABLE , drag_touch.touch.x, drag_touch.touch.y );

    scene.handleInputUp(drag_touch.touch.x, drag_touch.touch.y, drag_touch.dragging);
    
    drag_touches.remove(drag_touch.touch.id);
  }

}