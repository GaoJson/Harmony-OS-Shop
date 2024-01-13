
import http from '@ohos.net.http'
import { BaseResponse } from './base_responst'
import axios from  '@ohos/axios'

export function createRequest<T = any>(path:string,method:RequestMethods,param:any):Promise<T>{

  const http = axios.create({
    baseURL:"https://api.renrenyingfa.com/api/",
    timeout:30000,
    headers:{
      "clientType":0,
      "Content-Type":ContentType.FORM_URLENCODED
    }
  })

  return new Promise((resolve,reject) =>{
    if(method == RequestMethods.GET) {
      http.get(path).then((res)=>{
        if(res.status == 200) {
          resolve(res.data.data)
        }else {

        }
      }).catch((error)=>{
        reject(error)
      })
    } else {
      http.post(path,param).then((res)=>{
        if(res.status == 200) {
          resolve(res.data.data)
        }else {

        }
      }).catch((error)=>{
        reject(error)
      })
    }




  })

}

export enum RequestMethods{
  GET = http.RequestMethod.GET,
  POST = http.RequestMethod.POST
}

export enum ContentType {
  JSON = 'application/json',
  FORM_URLENCODED = 'application/x-www-form-urlencoded',
  FORM_DATA = 'multipart/form-data'
}