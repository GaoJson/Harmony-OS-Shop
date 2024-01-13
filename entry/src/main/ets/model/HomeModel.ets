
export class HomeModel {

  hotGoodsVo:GoodsModel[] = []
  tgoodsCategoryVos:CategoryModel[] = []
  topBannerVos:BannerModel[] = []

}

export class BannerModel{
  name:string = ''
  coverImg:string = ''
  id:number = 0
}

export class CategoryModel{
  cname:string = ''
  imgUrl:string = ''
  id:number = 0
}

export class GoodsModel {
  id:number = 0
  goodsBanner = ""
  goodsImg = ""
  goodsName = ""
  goodsPrice = ""
  goodsSn = ""
  spec = ""
}
