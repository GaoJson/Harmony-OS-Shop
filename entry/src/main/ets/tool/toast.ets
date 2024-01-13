
import promptAction from '@ohos.promptAction'
import display from '@ohos.display'


export class Toast {
  static show(msg:string){
    var height = display.getDefaultDisplaySync().height
    promptAction.showToast({message:msg,bottom:px2vp(height)/2})
  }
}
