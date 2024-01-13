
import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh'
import { ShopCarUtil } from '../../db/ShopCarModel';
import { BannerModel, CategoryModel, GoodsModel, HomeModel } from '../../model/HomeModel';
import { JSColor } from '../../tool/color_tool';
import { UIDevice } from '../../tool/device_tool';
import { createRequest, RequestMethods } from '../../tool/http/httpRequest';
import { LogUtil } from '../../tool/LogUtil';
import { Toast } from '../../tool/toast';
import { NavBarView } from '../common/NavbarView';

@Component
export struct HomePage {

  @State data: string[] = []
  private scroller: Scroller = new Scroller();
  @State categoryList: CategoryModel[] = []
  @State hotList: GoodsModel[] = []
  @State bannerList: BannerModel[] = []
  @State goodsList: GoodsModel[] = []
  page = 1;

  aboutToAppear() {
    this.loadTopData()
    this.loadMoreData()

  }

  loadTopData(): Promise<any> {
    this.loadMoreData()
    return new Promise<string>((resolve, reject) => {
      createRequest("goods/v1/main", RequestMethods.GET, {}).then((res) => {
        var model: HomeModel = res
        this.categoryList = model.tgoodsCategoryVos
        this.hotList = model.hotGoodsVo
        this.bannerList = model.topBannerVos
        resolve("")
      }).catch(() => {
        resolve("")
      });
    })
  }

  loadMoreData(): Promise<any> {
    return new Promise<string>((resolve, reject) => {
      var parma = { "pageNum": this.page.toString(), "pageSize": "4" }
      createRequest("goods/v1/good", RequestMethods.POST, parma).then((res) => {
        LogUtil.log(res)
        var list: GoodsModel[] = this.goodsList
        if (this.page == 1) {
          list = []
        }
        const datas: GoodsModel[] = res.rows
        this.goodsList = list.concat(datas)
        resolve("")
      }).catch(() => {
        resolve("")
      });
    })
  }

  build() {
    Column() {
      NavBarView({ title: "首页" })
      PullToRefresh({
        data: $data,
        mHeight: "100%",
        refreshConfigurator: new PullToRefreshConfigurator().setRefreshTextSize(12).setLoadTextSize(12),
        scroller: this.scroller,
        customList: () => {
          this.getListView()
        },
        onRefresh: () => {
          this.page = 1
          return this.loadTopData()
        },
        onLoadMore: () => {
          this.page++
          return this.loadMoreData()
        },
        customLoad: null,
        customRefresh: null,
      }).layoutWeight(1)

    }.height("100%").backgroundColor(JSColor.bck_color)
  }

  @Builder
  private getListView() {
    Scroll(this.scroller) {
      Flex({ justifyContent: FlexAlign.Start, direction: FlexDirection.Column }) {
        this.topBanner()
        this.categoryView()
        this.hotView()
        this.goodsView()
      }
    } // 必须设置列表为滑动到边缘无效果
  }

  @Builder topBanner() {
    Swiper() {
      ForEach(this.bannerList, (item: BannerModel) => {
        Image(item.coverImg)
      })
      if (this.bannerList.length == 0) {
        Text("")
      }
    }.width("100%").autoPlay(true)
  }

  @Builder categoryView() {
    Flex({ wrap: FlexWrap.Wrap }) {
      ForEach(this.categoryList, (item: CategoryModel) => {
        Column() {
          Image(item.imgUrl).width(30).height(40).padding({ top: 5, bottom: 5 })
          Text(item.cname).padding({ top: 5, bottom: 5 }).fontSize(12)
        }.width("20%")
      })
    }.backgroundColor(Color.White).margin({ top: 8 }).padding({ top: 8, bottom: 8 })
  }

  @Builder hotView() {
    Column() {
      Text("热销榜单")

      Flex() {
        ForEach(this.hotList, (item: GoodsModel) => {
          Column() {
            Image(item.goodsImg).width("80%").aspectRatio(1).padding({ top: 5, bottom: 5 })
            Text(item.goodsName).padding({ top: 5 }).fontSize(12)
              .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
            Text('¥' + item.goodsPrice)
              .fontColor(Color.Red)
              .padding({ top: 5 })
              .fontSize(12)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }.width("25%")
        })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width(UIDevice.screenWidth() - 20)
    .height(150)
    .borderRadius(10)
    .padding(8)
    .backgroundColor(Color.White)
    .margin({ left: 10, right: 10, top: 8 })
  }

  @Builder goodsView() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
      ForEach(this.goodsList, (item: GoodsModel) => {
        Column() {
          Image(item.goodsImg).width("100%").aspectRatio(1)
          Text(item.goodsName).padding({ top: 5, left: 8, right: 8 }).fontSize(12)
            .maxLines(2).textOverflow({ overflow: TextOverflow.Ellipsis })
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
        .width("49%")
        .backgroundColor(Color.White)
        .margin({ top: 10 })
        .borderRadius(8)
        .borderStyle(BorderStyle.Dashed)
        .alignItems(HorizontalAlign.Start)
      })
    }.padding({ left: 12, right: 12 })
  }




}