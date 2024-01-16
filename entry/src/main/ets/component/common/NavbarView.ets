
import image from '@ohos.multimedia.image';
import router from '@ohos.router';
@Component
export struct  NavBarView{

  title?:string
  showBack?:boolean = true



  build(){
    Flex({direction:FlexDirection.Row,justifyContent:FlexAlign.SpaceBetween,alignItems:ItemAlign.Center}){
      Row(){
       if (this.showBack != false){
         Image($r('app.media.ic_left_arrow')).width(10).height(18).margin({left:8}).onClick(()=>{
           router.back()
         })
       }
      }
      Text(this.title??"")
      Row(){

      }
    }
    .height(50)
    .backgroundColor(0xffffff)
    .width("100%")
  }


}


