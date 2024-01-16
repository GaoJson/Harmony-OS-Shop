import inputMethod from '@ohos.inputMethod'
import { NavBarView } from '../component/common/NavbarView'
import { JSColor } from '../tool/color_tool'
import { UIDevice } from '../tool/device_tool'
import { LogUtil } from '../tool/LogUtil'
@Entry
@Component
struct AddressEditPage {

  @State userName:string = ""
  @State phone:string = ""
  @State address:string = ""
  @State detailAddress:string = ""
  @State default:boolean = false
  cv1 = new TextInputController()
  cv2 = new TextInputController()
  cv3 = new TextInputController()

  onPageShow(){

  }

  build() {
    Column(){
      NavBarView({title:"编辑地址"})
      this.userInfo()
      this.defaultAddress()
      Text("确定").fontColor(Color.White).backgroundColor(Color.Red).textAlign(TextAlign.Center)
        .fontSize(18).borderRadius(20).height(40).width(UIDevice.screenWidth()*0.75).margin({top:20}).onClick(()=>{
        try {
          inputMethod.getController().stopInputSession((error, result) => {
            if (error !== undefined) {
              console.error('Failed to stopInputSession: ' + JSON.stringify(error));
              return;
            }
            if (result) {
              console.info('Succeeded in stopping inputSession.');
            } else {
              console.error('Failed to stopInputSession.');
            }
          });
        } catch(error) {
          console.error('Failed to stopInputSession: ' + JSON.stringify(error));
        }
        LogUtil.log(this.detailAddress)

      })

    }.backgroundColor(JSColor.bck_color).height("100%").width("100%")
  }


  @Builder
  userInfo(){
    Column(){
      Row(){
        Text("收货人").fontSize(13).fontColor(Color.Black).fontWeight(FontWeight.Bold).width("15%")
        TextInput({text:this.userName,placeholder:"请输入收货人",controller:this.cv1})
          .onChange((e)=>{
            this.userName = e
          })
          .placeholderFont({size:13}).fontSize(13).backgroundColor(0xffffff).width("80%")
      }.width("100%").height(40)
      Divider().height(0.5)
      Row(){
        Text("电话号码").fontSize(13).fontColor(Color.Black).fontWeight(FontWeight.Bold).width("15%")
        TextInput({text:this.phone,placeholder:"请输入电话号码",controller:this.cv2})
          .onChange((e)=>{
            this.phone = e
          })
          .placeholderFont({size:13}).fontSize(13).backgroundColor(0xffffff).width("80%")
      }.width("100%").height(40)
      Divider().height(0.5)
      Row(){
        Text("所在地区").fontSize(13).fontColor(Color.Black).fontWeight(FontWeight.Bold).width("15%")
        Text(this.address==""?"请选择省、市、区、街道":this.address).fontColor(this.address==""?Color.Gray:Color.Black).fontSize(13).width("75%").margin({left:15})
      }.width("100%").height(40)
      Divider().height(0.5)
      Row(){
        Text("详细地址").fontSize(13).fontColor(Color.Black).fontWeight(FontWeight.Bold).width("15%").padding({top:8})
        TextArea({text:this.detailAddress,placeholder:"请输入详细地址",controller:this.cv3})
          .onChange((e)=>{
            this.detailAddress = e
          }).placeholderFont({size:13}).fontSize(13).backgroundColor(0xffffff).width("80%").height(60)
      }.width("100%").height(70).alignItems(VerticalAlign.Top).padding({top:8})
    }.backgroundColor(Color.White)
    .margin(8)
     .padding(8)
    .borderRadius(8)
    .width(UIDevice.screenWidth()-16)

  }

  @Builder
  defaultAddress(){
    Row(){
      Column(){
        Text("设置默认地址").fontSize(13).margin({bottom:5})
        Text("提示：下单会优先使用该地址").fontSize(11).fontColor(Color.Gray)
      }.alignItems(HorizontalAlign.Start)

      Toggle({ type: ToggleType.Switch, isOn: this.default }).onChange((e)=>{
        this.default = e
      })

    }.backgroundColor(Color.White)
    .margin(8)
    .padding({left:8,right:8})
    .borderRadius(8)
    .justifyContent(FlexAlign.SpaceBetween)
    .width(UIDevice.screenWidth()-16)

  }

}