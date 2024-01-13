import data_preferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

/**
 * 轻量级缓存工具类
 */
const context = getContext(this) as common.UIAbilityContext;
let promise = data_preferences.getPreferences(context, 'myStore');

export class PreferencesUtils {

  /**
   *
   * @param name 传入的key
   * @param lhz 存储字段的类型（我这里存储的是string，所以直接写死了）
   * @returns 获取数据字段
   */
  static getPrefer(name): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      promise.then((res) => {
        res.get(name, "").then((value) => {
              resolve(value.toString())
        })
      })
    })
  }

  /**
   *
   * @param name 传入的key
   * @param valuer 传入的 value
   * 传入需要储存的字段
   */
  static putPrefer(name, valuer): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      promise.then((res) => {
        res.put(name, valuer).then(()=>{
          res.flush()
          resolve(name.toString())
        })
      })
    })
  }
}