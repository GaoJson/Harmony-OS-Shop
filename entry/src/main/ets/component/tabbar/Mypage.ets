
import { PullToRefresh, PullToRefreshConfigurator } from "@ohos/pulltorefresh"

import { JSColor } from '../../tool/color_tool';
import { UIDevice } from '../../tool/device_tool';
import {AddressSelectDialog } from '../common/AddressSelectDialog'
@Component
export struct MyPage {
  @State data: string[] = []
  private scroller: Scroller = new Scroller();
  @State orderList: number[] = [5, 0, 0, 0]

  build() {
    Column() {
      this.navbarView()
      Stack() {
        Column() {
          PullToRefresh({
            data: $data,
            mHeight: "100%",
            refreshConfigurator: new PullToRefreshConfigurator().setRefreshTextSize(12)
              .setLoadTextSize(12)
              .setRefreshColor('#ffffff')
              .setRefreshTextColor(Color.White),
            scroller: this.scroller,
            customList: () => {
              this.getListView()
            },
            customLoad: null,
            customRefresh: null,
          }).backgroundColor(JSColor.main_color)
        }.height("100%")
      }.height("100%")
    }.height("100%")
  }

  @Builder
  navbarView() {
    Row() {
      Image($r("app.media.icon_sever")).width(24).height(24).margin({ right: 12 })
      Image($r("app.media.icon_setting")).width(24).height(24).margin({ right: 12 })
    }
    .justifyContent(FlexAlign.End)
    .width("100%")
    .backgroundColor(JSColor.main_color)
    .height(50)
  }

  @Builder
  private getListView() {
    Column() {
      Scroll(this.scroller) {
        Flex({ justifyContent: FlexAlign.Start, direction: FlexDirection.Column }) {
          this.userInfoView()
          this.orderView()
          Image($r("app.media.ic_my_invite")).width(UIDevice.screenWidth() - 20).margin({ left: 10, top: 8, bottom: 8 })
          this.moreItemView()
        }
      }
    }.backgroundColor(JSColor.bck_color).height("100%").width("100%")
  }

  @Builder
  userInfoView() {
    Column() {
      Row() {
        Row() {
          Image("https://upload.jianshu.io/users/upload_avatars/4790772/388e473c-fe2f-40e0-9301-e357ae8f1b41.jpeg")
            .borderRadius(8)
            .height(60)
            .width(60)
            .margin({ left: 10, right: 10 })
          Column() {
            Text("用户昵称").fontColor(Color.White).fontSize(13).margin({ bottom: 5 })

            Text("1803***1231").fontColor(Color.White).fontSize(13)
          }.alignItems(HorizontalAlign.Start)
        }

        Image($r("app.media.ic_arrow_right_white")).width(24).height(24).margin({ right: 10 })
      }.height(90).width("100%").justifyContent(FlexAlign.SpaceBetween)

      Row().backgroundColor(JSColor.bck_color).height(15).width("100%").borderRadius({ topLeft: 14, topRight: 14 })
    }.backgroundColor(JSColor.main_color)

  }

  @Builder
  orderView() {
    Column() {
      Row() {
        Text("我的订单").fontSize(13).fontWeight(FontWeight.Bold)
        Row() {
          Text("全部订单").fontColor(Color.Gray).fontSize(12)
          Image($r("app.media.icon_arrow_right_gray")).height(15).width(15)
        }
      }.justifyContent(FlexAlign.SpaceBetween).width("100%").padding({ left: 8, right: 8, top: 6 })

      Row() {
        Column() {
          Stack() {
            Image($r("app.media.ic_my_order_1")).width(25).height(25).margin({ top: 8 })
            if (this.orderList[0] > 0) {
              Text(this.orderList[0].toString())
                .backgroundColor(Color.Red)
                .fontColor(Color.White)
                .fontSize(10)
                .borderRadius(10)
                .height(15)
                .padding({ left: 5, right: 5 })
                .margin({ left: 35 })
            }
          }.height(30).alignContent(Alignment.Top)

          Text("待支付").fontSize(13).fontColor(JSColor.text33Color).margin({ top: 8 })
        }.width("25%").onClick(() => {

        })

        Column() {
          Stack() {
            Image($r("app.media.ic_my_order_2")).width(25).height(25).margin({ top: 8 })
            if (this.orderList[1] > 0) {
              Text(this.orderList[1].toString())
                .backgroundColor(Color.Red)
                .fontColor(Color.White)
                .fontSize(10)
                .borderRadius(10)
                .height(15)
                .padding({ left: 5, right: 5 })
                .margin({ left: 35 })
            }
          }.height(30).alignContent(Alignment.Top)

          Text("待发货").fontSize(13).fontColor(JSColor.text33Color).margin({ top: 8 })
        }.width("25%")

        Column() {
          Stack() {
            Image($r("app.media.ic_my_order_3")).width(25).height(25).margin({ top: 8 })
            if (this.orderList[2] > 0) {
              Text(this.orderList[2].toString())
                .backgroundColor(Color.Red)
                .fontColor(Color.White)
                .fontSize(10)
                .borderRadius(10)
                .height(15)
                .padding({ left: 5, right: 5 })
                .margin({ left: 35 })
            }
          }.height(30).alignContent(Alignment.Top)

          Text("待收货").fontSize(13).fontColor(JSColor.text33Color).margin({ top: 8 })
        }.width("25%")

        Column() {
          Stack() {
            Image($r("app.media.ic_my_order_4")).width(25).height(25).margin({ top: 8 })
            if (this.orderList[3] > 0) {
              Text(this.orderList[3].toString())
                .backgroundColor(Color.Red)
                .fontColor(Color.White)
                .fontSize(10)
                .borderRadius(10)
                .height(15)
                .padding({ left: 5, right: 5 })
                .margin({ left: 35 })
            }
          }.height(30).alignContent(Alignment.Top)

          Text("待评价").fontSize(13).fontColor(JSColor.text33Color).margin({ top: 8 })
        }.width("25%")

      }.justifyContent(FlexAlign.SpaceEvenly).padding({ top: 10 })

    }
    .backgroundColor(Color.White)
    .height(100)
    .padding(5)
    .margin({ left: 12 })
    .width(UIDevice.screenWidth() - 24)
    .borderRadius(12)
  }

  private itemImg: Resource[] = [
  $r("app.media.ic_my_service_1"), $r("app.media.ic_my_service_2"),
  $r("app.media.ic_my_service_3"), $r("app.media.ic_my_service_4"),
  $r("app.media.ic_my_service_5"), $r("app.media.ic_my_service_6"),
  $r("app.media.ic_my_service_7"), $r("app.media.ic_my_service_8"),
  ]

  @Builder
  moreItemView() {
    Column() {
      Row() {
        Text("我的订单").fontSize(13).fontWeight(FontWeight.Bold)
        Row() {
          Text("全部订单").fontColor(Color.Gray).fontSize(12)
          Image($r("app.media.icon_arrow_right_gray")).height(15).width(15)
        }
      }.justifyContent(FlexAlign.SpaceBetween).width("100%").padding({ left: 8, right: 8, top: 6 })

      List() {
        ForEach(this.itemImg, (e: Resource) => {
          ListItem() {
            Column() {
              Image(e).width(25).height(25)
              Text("我的地址").fontColor(JSColor.text33Color).fontSize(12).margin({ top: 5 })
            }.onClick(() => {


            })
          }.width("100%").margin({ top: 12 })
        })
      }.lanes(4).padding({ top: 8, bottom: 8 })

    }
    .backgroundColor(Color.White)
    .padding(5)
    .margin({ left: 12 })
    .width(UIDevice.screenWidth() - 24)
    .borderRadius(12)
  }

  address: CustomDialogController = new CustomDialogController({
    builder: AddressSelectDialog(
      { cancel: this.cancel,
        confirm: this.confirm
      }),
    alignment: DialogAlignment.Bottom,
    customStyle: true,
  })

  cancel() {

  }

  confirm() {


  }
}