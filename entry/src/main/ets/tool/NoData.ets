

@Component
export struct NoData{
  build(){
    Column(){
      Image($r("app.media.icon_data_empty")).width("70%")
      Text("暂无数据").fontColor(Color.Gray)
    }.width("100%").height("100%").justifyContent(FlexAlign.Center)

  }
}