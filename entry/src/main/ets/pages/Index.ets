import { CategoryPage } from '../component/tabbar/CategoryPage'
import { HomePage } from '../component/tabbar/HomePage'
import { MyPage } from '../component/tabbar/Mypage'
import { ShopCarPage } from '../component/tabbar/ShopCarPage'
import { TabItemList, TabItemModel } from '../component/tabbar/TabbarConfig'
import { JSColor } from '../tool/color_tool'

@Entry
@Component
struct Index {
  @State selectIndex: number = 0
  controller = new TabsController()

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        HomePage()
      }.tabBar(this.bottomItem(TabItemList[0]))

      TabContent() {
        CategoryPage({showIndex:this.selectIndex})
      }.tabBar(this.bottomItem(TabItemList[1]))

      TabContent() {
        ShopCarPage({showIndex:this.selectIndex})
      }.tabBar(this.bottomItem(TabItemList[2]))

      TabContent() {
        MyPage()
      }.tabBar(this.bottomItem(TabItemList[3]))
    }.onChange((index:number) =>{
      this.selectIndex = index
    })
  }

  @Builder bottomItem(item:TabItemModel){
    Column({ space: 6 }){
      if (item.index == 2){
        Stack(){
          Image(this.selectIndex==item.index?item.selectImg:item.img).width(24).height(24)
          Text(" 1 ").fontColor(Color.White).fontSize(12).margin({bottom:15,left:30}).backgroundColor(Color.Red).borderRadius(15)
        }
      }else {
        Image(this.selectIndex==item.index?item.selectImg:item.img).width(24).height(24)
      }
      Text(item.title).fontSize("10fp").fontColor(this.selectIndex==item.index?JSColor.main_color:Color.Gray)
    }
  }
}

