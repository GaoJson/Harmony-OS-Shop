
import display from '@ohos.display'
export class UIDevice {
  static screenWidth():number{
    var width = display.getDefaultDisplaySync().width
    return px2vp(width)
  }

  static screenHeight():number{
    var height = display.getDefaultDisplaySync().height
    return px2vp(height)
  }
}