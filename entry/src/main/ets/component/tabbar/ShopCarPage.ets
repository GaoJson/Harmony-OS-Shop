
import { ShopCarArray, ShopCarModel, ShopCarUtil } from '../../db/ShopCarModel'
import { JSColor } from '../../tool/color_tool'
import { NoData } from '../../tool/NoData'



@Component
export struct ShopCarPage {
  @Prop @Watch("onShow") showIndex: number
  @State navRightEdit: number = 0
  @State goodsList:ShopCarArray = []

  @State goodsPrice:string = "0.0"

  @State selectAll:boolean = false

  onShow() {
    if (this.showIndex == 2) {
      this.loadList()
    }
  }

  loadList(){
    ShopCarUtil.getList((list) => {
      this.goodsList = list
      this.countAllPrice()
    })
  }

  build() {
    Column() {
      this.navbarView()
      this.contentView()
      this.bottomView()
    }.height("100%").backgroundColor(JSColor.bck_color)
  }

  @Builder
  navbarView() {
    Row() {
      Text("购物车").layoutWeight(1).textAlign(TextAlign.Center)
      Text(this.navRightEdit == 0 ? "编辑" : "完成")
        .fontColor(Color.Gray)
        .fontSize(14)
        .padding({ right: 20 })
        .onClick(() => {
          if (this.navRightEdit == 0) {
            this.navRightEdit = 1
          } else {
            this.navRightEdit = 0
          }
        })
    }
    .width("100%")
    .backgroundColor(Color.White)
    .height(50)
  }

  @Builder
  contentView() {
    Flex(){
      Scroll() {
        if (this.goodsList.length == 0){
          NoData()
        }
        Column(){
          ForEach(this.goodsList, (item: ShopCarModel) => {
            Row() {
              Checkbox().select(item.selectFlag).onChange((el) => {
                item.selectFlag = el
                this.saveShopCarModel(item)
              })
              Image(item.goodsImg).height(80).aspectRatio(1).margin({ left: 5 })
              Column() {
                Text(item.goodsName)
                  .padding({ right: 5 })
                  .fontSize(13)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(2)
                Row() {
                  Text('¥' + item.goodsPrice)
                    .fontSize(15)
                    .padding({ right: 8, bottom: 8 })
                    .fontColor(Color.Red)
                  Row() {
                    Text("-")
                      .onClick(()=>{
                        item.count -= 1
                        if (item.count <= 0) {
                          item.count = 1
                        }
                        this.saveShopCarModel(item)
                      })
                      .border({ radius: 2, color: Color.Gray, width: 1, }).width(20).textAlign(TextAlign.Center)
                    TextInput({text:item.count.toString()})
                      .type(InputType.Number)
                      .fontColor(Color.Black)
                      .fontSize(12)
                      .textAlign(TextAlign.Center)
                      .border({ radius: 1, color: Color.Gray })
                      .width(30)
                      .height(20)
                      .padding(0)
                      .onChange((value)=>{


                      })
                    Text("+")
                      .onClick(()=>{
                        item.count += 1
                        this.saveShopCarModel(item)
                      })
                      .border({ radius: 2, color: Color.Gray, width: 1, }).width(20).textAlign(TextAlign.Center)
                  }.padding({right:8,bottom:5})
                }.justifyContent(FlexAlign.SpaceBetween).width("100%")
              }
              .layoutWeight(1)
              .height("100%")
              .margin({ left: 5 })
              .padding({ top: 8 })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(HorizontalAlign.Start)
            }.backgroundColor(Color.White).height(90).width("100%").margin({ top: 3 })
          }
          )
        }
      }.width("100%")
    }.layoutWeight(1).padding({ bottom: 1 })
  }

  @Builder
  bottomView() {
    Row() {
      Row() {
        Checkbox().select(this.selectAll).onChange((e) => {
          this.selectAll = e
          ShopCarUtil.selectAll(e,()=>{
            this.loadList()
          })
        })
        Text("全选").fontColor(Color.Gray)
      }

      if (this.navRightEdit == 0) {
        Row() {
          Row() {
            Text("总价:").fontColor(Color.Gray).fontSize(12)
            Text("¥").fontColor(Color.Red).fontSize(12)
            Text(this.goodsPrice).fontColor(Color.Red).fontSize(15)
          }.height("100%").padding({ bottom: 8 }).alignItems(VerticalAlign.Bottom)

          Button("去下单").backgroundColor(Color.Red).height(30)

        }.layoutWeight(1).justifyContent(FlexAlign.SpaceBetween).margin({ left: 10, right: 10 })
      } else {
        Row() {
          Text()
          Button("删除").backgroundColor(Color.Red).height(30).onClick(()=>[
          this.deleteShopCar()
          ])
        }.layoutWeight(1).justifyContent(FlexAlign.SpaceBetween).margin({ left: 10, right: 10 })
      }
    }
    .width("100%")
    .backgroundColor(Color.White)
    .height(40)
    .margin({ bottom: 1 })
  }

  saveShopCarModel(model: ShopCarModel) {
    ShopCarUtil.updateModel(model,()=>{
      this.loadList()
    })
  }

  deleteShopCar(){
    var list:Set<number> = new Set()
    this.goodsList.forEach((model)=>{
      if (model.selectFlag==true) {
        list.add(model.id)
      }
    })
    ShopCarUtil.deleteIds(list,()=>{
      this.loadList()
    })
  }

  countAllPrice(){
    var price = 0.0
    this.goodsList.forEach((model)=>{
      if (model.selectFlag) {
        price += model.count * parseFloat(model.goodsPrice)
      }
    })
    this.goodsPrice = price.toFixed(2)
  }


}