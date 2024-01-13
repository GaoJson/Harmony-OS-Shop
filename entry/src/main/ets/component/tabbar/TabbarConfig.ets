
class TabItemModel {
  index:number = 0;
  img:Resource = $r('app.media.ic_home_tab1_selected');
  selectImg:Resource = $r('app.media.ic_home_tab1_unchecked');
  title:string = "";
}

const TabItemList: TabItemModel[] = [
  {
    index: 0,
    img: $r('app.media.ic_home_tab1_unchecked'),
    selectImg: $r('app.media.ic_home_tab1_selected'),
    title: '首页'
  },
  {
    index: 1,
    img: $r('app.media.ic_home_tab2_unchecked'),
    selectImg: $r('app.media.ic_home_tab2_selected'),
    title: '分类'
  },
  {
    index: 2,
    img: $r('app.media.ic_home_tab3_unchecked'),
    selectImg: $r('app.media.ic_home_tab3_selected'),
    title: '购物车'
  },
  {
    index: 3,
    img: $r('app.media.ic_home_tab5_unchecked'),
    selectImg: $r('app.media.ic_home_tab5_selected'),
    title: '我的'
  }
]
export {TabItemList,TabItemModel}