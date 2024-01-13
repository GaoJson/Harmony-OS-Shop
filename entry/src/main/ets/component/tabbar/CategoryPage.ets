
import { ShopCarUtil } from '../../db/ShopCarModel'
import { CategoryModel, GoodsModel, HomeModel } from '../../model/HomeModel'
import { JSColor } from '../../tool/color_tool'
import { createRequest, RequestMethods } from '../../tool/http/httpRequest'
import { NoData } from '../../tool/NoData'
import { Toast } from '../../tool/toast'
import { NavBarView } from '../common/NavbarView'

@Component
export struct CategoryPage {
  @Prop @Watch("onShow") showIndex: number
  @State leftList: CategoryModel[] = []
  @State leftIndex: number = 0
  @State goodsList: GoodsModel[] = []

  onShow() {
    if (this.showIndex == 1) {

    }
  }

  aboutToAppear() {
    this.loadLeftMenu()
  }

  loadLeftMenu() {
    createRequest("goods/v1/main", RequestMethods.GET, {}).then((res) => {
      var model: HomeModel = res
      this.leftList = model.tgoodsCategoryVos
      this.loadRightData(this.leftList[0].id)
    }).catch(() => {

    });
  }

  loadRightData(id: number) {
    var params = {}
    params['pageNum'] = "1";
    params['pageSize'] = "10";
    params['goodsCid'] = id.toString();

    createRequest("goods/v1/good", RequestMethods.POST, params).then((res) => {
      const data: GoodsModel[] = res.rows
      this.goodsList = data
    }).catch(() => {

    });

  }

  build() {
    Column() {
      NavBarView({ title: "分类" })
      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignContent: FlexAlign.Start }) {
        this.leftView()
        this.rightView()
      }.backgroundColor(JSColor.bck_color)
    }

  }

  @Builder leftView() {
    Scroll() {
      Column() {
        ForEach(this.leftList, (item: CategoryModel, index) => {
          Text(item.cname)
            .fontSize(14)
            .width("100%")
            .height(35)
            .backgroundColor(index == this.leftIndex ? JSColor.bck_color : Color.White)
            .margin({ top: 1 })
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.leftIndex = index
              this.loadRightData(item.id)
            })
        })
      }.height("100%")
    }.height("100%").width("20%")
  }

  @Builder rightView() {
    Flex(){
      Scroll() {
        Flex({ direction: FlexDirection.Column }) {
          if (this.goodsList.length == 0){
            NoData()
          }
          ForEach(this.goodsList, (item: GoodsModel, index) => {
            Row() {
              Image(item.goodsImg).height(80).aspectRatio(1).margin({ left: 5 })
              Column() {
                Text(item.goodsName)
                  .padding({ right: 5 })
                  .fontSize(13)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(2)
                Row(){
                  Text('¥' + item.goodsPrice)
                    .fontColor(Color.Red)
                    .padding({ top: 8, bottom: 10, left: 8 })
                    .fontSize(14)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Image($r("app.media.icon_add_shop_car")).width(20).height(20).margin({right:10}).onClick(()=>{
                    ShopCarUtil.saveModel(item)
                    Toast.show("添加成功")
                  })
                }.justifyContent(FlexAlign.SpaceBetween).width("100%")

              }
              .layoutWeight(1)
              .height("100%")
              .margin({ left: 5 })
              .padding({ top: 8 })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(HorizontalAlign.Start)
            }.backgroundColor(Color.White).height(90).width("100%").margin({ top: 3 })
          })
        }
      }.padding({ left: 8, right: 8})

    }.width("80%").height("100%").padding({bottom:56})
  }
}