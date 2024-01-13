
import image from '@ohos.multimedia.image';
@Component
export struct  NavBarView{

  title?:string



  leftClick?: (key: number) => void = () => {};



  rightTextClick?: () => string = () => {
    return ""
  };


  build(){
    Flex({direction:FlexDirection.Row,justifyContent:FlexAlign.SpaceBetween,alignItems:ItemAlign.Center}){
      Row(){
       if (this.leftClick.name.length){
         Image($r('app.media.ic_left_arrow')).width(10).height(18).margin({left:8}).onClick(()=>{
           this.leftClick(0)
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


