import resourceManager from '@ohos.resourceManager'
import common from '@ohos.app.ability.common'

import util from '@ohos.util'
import buffer from '@ohos.buffer'
import { JSColor } from '../../tool/color_tool'
import { UIDevice } from '../../tool/device_tool'


@CustomDialog
export struct AddressSelectDialog {
  @State selectIndex: number = 0
  @State titleList: TownModel[] = []
  addressData: selectAddressModel;
  pModel: TownModel = new TownModel()
  cModel: TownModel = new TownModel()
  aModel: TownModel = new TownModel()
  tModel: TownModel = new TownModel()
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  aboutToAppear() {
    let context = getContext(this) as common.UIAbilityContext;
    context.resourceManager.getRawFileContent("city_data.json").then((data) => {
      let str = buffer.from(data).toString()
      let list: selectAddressModel = JSON.parse(str)
      this.addressData = list
      this.selectProvince()
    })
  }

  selectProvince() {
    var tempList: TownModel[] = []
    for (let index = 0; index < this.addressData.list.length; index++) {
      var ele = new TownModel()
      ele.townName = this.addressData.list[index].provinceName
      ele.townId = this.addressData.list[index].provinceId
      tempList.push(ele)
    }
    this.titleList = tempList
  }


  build() {
    Column() {
      Row() {
        Text("取消").fontColor(Color.Gray).fontSize(13).onClick(()=>{
          this.controller.close()
        }
        )
        Text("请选择").fontColor(Color.Gray).fontSize(13)
        Text("确定").fontColor(Color.Gray).fontSize(13).onClick(()=> {
          this.confirm()
          this.controller.close()
        })
      }.justifyContent(FlexAlign.SpaceBetween).width("100%").padding(12)

      Divider().height(0.5).padding(0).color(JSColor.line_color)
      Row() {
        ForEach([this.pModel, this.cModel, this.aModel, this.tModel], (ele: TownModel, index) => {
          Text(ele.townName == "" ? "请选择" : ele.townName).padding({ left: 15 })
            .fontSize(14).fontColor(this.selectIndex == index ? Color.Red : JSColor.text33Color).onClick(() => {
               if(index == 0) {
                 if (this.pModel.townName == "") {
                   return
                 }
                 this.selectProvince()
                 this.cModel.townName = ""
                 this.aModel.townName = ""
                 this.tModel.townName = ""
                 this.selectIndex = 0
               }
            if(index == 1) {
              if (this.cModel.townName == "") {
                return
              }
              this.aModel.townName = ""
              this.tModel.townName = ""
              var list = this.addressData.list[this.pModel.index].cityList
              var tempList: TownModel[] = []
              for (let index = 0; index < list.length; index++) {
                var ele = new TownModel()
                ele.townName = list[index].cityName
                ele.townId = list[index].cityId
                tempList.push(ele)
              }
              this.titleList = tempList
              this.selectIndex = 1
            }
            if(index == 2) {
              if (this.aModel.townName == "") {
                return
              }
              this.tModel.townName = ""
              var dataList = this.addressData.list[this.pModel.index].cityList[this.cModel.index].areaList
              var tempList: TownModel[] = []
              for (let index = 0; index < dataList.length; index++) {
                var ele = new TownModel()
                ele.townName = dataList[index].areaName
                ele.townId = dataList[index].areaId
                tempList.push(ele)
              }
              this.titleList = tempList
              this.selectIndex = 2
            }

          })
        })

      }.height(35).width("100%")

      Divider().height(0.5).padding(0).color(JSColor.line_color)
      List() {
        ForEach(this.titleList, (ele: TownModel, index: number) => {
          ListItem() {
            Text(ele.townName).fontSize(12).width("100%").fontColor(JSColor.text66Color).padding({ top: 8, bottom: 8, left: 10 })
          }.width("100%").onClick(() => {
            this.selectIndexAction(index)
          })
        })

      }.layoutWeight(1).width("100%")
    }.padding(0).width("100%").height(UIDevice.screenHeight() / 2).backgroundColor(Color.White)
  }

  selectIndexAction(index: number) {
    if (this.selectIndex == 0) {
      this.pModel.townName = this.titleList[index].townName
      this.pModel.townId = this.titleList[index].townId
      this.pModel.index = index
      var list = this.addressData.list[index].cityList
      var tempList: TownModel[] = []
      for (let index = 0; index < list.length; index++) {
        var ele = new TownModel()
        ele.townName = list[index].cityName
        ele.townId = list[index].cityId
        tempList.push(ele)
      }
      this.titleList = tempList
      this.selectIndex = 1
    }
    else if (this.selectIndex == 1) {
      var dataList = this.addressData.list[this.pModel.index].cityList[index].areaList
      this.cModel.townName = this.titleList[index].townName
      this.cModel.townId = this.titleList[index].townId
      this.cModel.index = index
      var tempList: TownModel[] = []
      for (let index = 0; index < dataList.length; index++) {
        var ele = new TownModel()
        ele.townName = dataList[index].areaName
        ele.townId = dataList[index].areaId
        tempList.push(ele)
      }
      this.titleList = tempList
      this.selectIndex = 2
    } else if (this.selectIndex == 2) {
      var dataLists = this.addressData.list[this.pModel.index].cityList[this.cModel.index].areaList[index].townList
      this.aModel.townName = this.titleList[index].townName
      this.aModel.townId = this.titleList[index].townId
      this.aModel.index = index
      var tempList: TownModel[] = []
      for (let index = 0; index < dataLists.length; index++) {
        var ele = new TownModel()
        ele.townName = dataLists[index].townName
        ele.townId = dataLists[index].townId
        tempList.push(ele)
      }
      this.titleList = tempList
      this.selectIndex = 3
    } else if (this.selectIndex == 3) {
      this.tModel.townName = this.titleList[index].townName
      this.tModel.townId = this.titleList[index].townId
      this.tModel.index = index
      this.selectIndex = 4
      this.selectIndex = 3
    }


  }
}


class selectAddressModel {
  list: ProvinceModel[] = []
}

class ProvinceModel {
  provinceId: number
  provinceName: string
  cityList: CityModel[] = []
}

class CityModel {
  cityId: number
  cityName: string
  areaList: AreaModel[] = []
}

class AreaModel {
  areaId: number
  areaName: string
  townList: TownModel[] = []
}

class TownModel {
  townId: number = 0
  townName: string = ""
  index: number = 0
}

