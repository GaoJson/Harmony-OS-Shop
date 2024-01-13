
import hilog from '@ohos.hilog';

export class LogUtil {

  static log(msg:any){

    hilog.info(0x0000, 'testTag', '%{public}s',"    "+JSON.stringify(msg));


  }


}