import router from '@ohos.router'
import { NavBarView } from '../component/common/NavbarView'
import { JSColor } from '../tool/color_tool'

@Entry
@Component
export struct AddressPage {
  info = ["11", "2222"]

  build() {
    Column() {
      NavBarView({ title: "地址管理" })
      this.contentView()
      Text("添加新地址")
        .backgroundColor(Color.Red)
        .textAlign(TextAlign.Center)
        .fontSize(13)
        .fontColor(Color.White)
        .width("60%")
        .margin({ bottom: 5 })
        .height(30)
        .borderRadius(20)
        .onClick(()=>{
          router.pushUrl({url:"pages/AddressEditPage"})
        })

    }.backgroundColor(JSColor.bck_color).height("100%").width("100%")
  }

  @Builder
  contentView() {
    Flex() {
      Scroll() {
        Column() {
          ForEach(["111", ["222"]], (e) => {
            Column() {
              Row() {
                Column() {
                  Text("广东省 深圳市 南山区 中山南路").fontColor(Color.Gray).fontSize(12)
                  Text("南山北路腾讯大楼34楼05区").fontSize(12).margin({ top: 6, bottom: 6 })
                  Text("王思聪  130****3009").fontColor(Color.Gray).fontSize(12)
                }.alignItems(HorizontalAlign.Start)

                Image($r('app.media.icon_edit')).width(20).height(20)
              }.justifyContent(FlexAlign.SpaceBetween).width("100%").padding(10)

              Divider().color(0xefefef)
            }
          })
        }
      }
    }.layoutWeight(1).backgroundColor(Color.White).margin(12).borderRadius(10)

  }
}