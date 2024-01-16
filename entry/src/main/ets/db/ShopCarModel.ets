
import { LiveEventBus } from '@ohos/liveeventbus'
import { GoodsModel } from '../model/HomeModel'
import { KEY_SHOP_CAR_CHANGE } from '../pages/Index'
import { PreferencesUtils } from '../tool/PreferencesUtils'




@Observed
export class ShopCarModel {
  id:number
  userId:number
  shopId:number
  goodsName:string
  goodsImg:string
  goodsPrice:string
  selectFlag:boolean
  count:number
}

@Observed
export class ShopCarArray extends Array<ShopCarModel>{


}

export class ShopCarUtil{
  static tableName = "ShopCarModel"

  static  saveModel(item:GoodsModel){
    var model = new ShopCarModel()
    model.goodsName = item.goodsName
    model.shopId = item.id
    model.goodsImg = item.goodsImg
    model.goodsPrice = item.goodsPrice
    model.count = 1

    PreferencesUtils.getPrefer(this.tableName).then((value)=>{
      var v = value.length == 0 ? "[]": value
      var list:ShopCarModel[] = JSON.parse(v)
      var isExist = null
      for (let i = 0; i < list.length; i++) {
        if (list[i].shopId == model.shopId) {
           list[i].count++
          isExist = true
          break
        }
      }
      if (!isExist) {
        if (list.length == 0) {
          model.id = 1
        } else  {
          model.id = list[list.length-1].id+1
        }
        list.push(model)
      }
      LiveEventBus.get(KEY_SHOP_CAR_CHANGE).post(list.length);
      PreferencesUtils.putPrefer(this.tableName,JSON.stringify(list))
    })

  }

  static getList(callBack:(key: ShopCarModel[]) => void){
    PreferencesUtils.getPrefer(this.tableName).then((value)=>{
      var v = value.length == 0 ? "[]": value
      var list:ShopCarModel[] = JSON.parse(v)
      callBack(list)
    })
  }

  static selectAll(status:boolean,callBack:() => void){
    PreferencesUtils.getPrefer(this.tableName).then((value)=>{
      var v = value.length == 0 ? "[]": value
      var list:ShopCarModel[] = JSON.parse(v)
      list.forEach((model)=>{
        model.selectFlag = status
      })
      PreferencesUtils.putPrefer(this.tableName,JSON.stringify(list)).then(()=>{
        callBack()
      })
    })

  }

  static updateModel(model:ShopCarModel,callBack:() => void){
    PreferencesUtils.getPrefer(this.tableName).then((value)=>{
      var v = value.length == 0 ? "[]": value
      var list:ShopCarModel[] = JSON.parse(v)
      for (let i = 0; i < list.length; i++) {
        if (list[i].id == model.id) {
          list[i] = model
          break
        }
      }
      PreferencesUtils.putPrefer(this.tableName,JSON.stringify(list)).then(()=>{
        callBack()
      })
    })
  }

  static deleteIds(ids:Set<number>,callBack:() => void){
    PreferencesUtils.getPrefer(this.tableName).then((value)=>{
      var v = value.length == 0 ? "[]": value
      var list:ShopCarModel[] = JSON.parse(v)
      var existList:ShopCarModel[] = []
      for (let i = 0; i < list.length; i++) {
        if (!ids.has(list[i].id)) {
          existList.push(list[i])
        }
      }
      LiveEventBus.get(KEY_SHOP_CAR_CHANGE).post(existList.length);
      PreferencesUtils.putPrefer(this.tableName,JSON.stringify(existList)).then(()=>{
        callBack()
      })
    })


  }

}