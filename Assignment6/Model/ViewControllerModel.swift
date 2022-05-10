//
//  ViewControllerModel.swift
//  Assignment6
//
//  Created by Kapil Ganesh Shanbhag on 09/05/22.
//

import Foundation
import UIKit


struct MetaDataStruct:Decodable{
    var dst:String
    var src:String
    var blu:String
}
struct RtStruct:Decodable{
    var totRt:Double
}
struct BcStruct:Decodable{
    var IsAc:Bool
    var IsNonAc:Bool
    var IsSeater:Bool
    var IsSleeper:Bool
}
struct InvStruct:Decodable{
    var dt:String
    var at:String
    var rt:RtStruct
    var minfr:Int
    var bc:BcStruct
    var tvs:String
    var lp:String
    var cur:String
    
}
struct APIRespStruct:Decodable{
    var metaData:MetaDataStruct
    var inv:[InvStruct]
}

class ViewControllerModel{
    func getDataFromAPI()->APIRespStruct{
        var resp=APIRespStruct(metaData: MetaDataStruct(dst: "", src: "", blu: ""), inv: [])
        let url = URL(string:  "https://api.jsonbin.io/b/6093c95293e0ce40806d8a1d")!
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let strdata=String(data: data, encoding: .utf8)
            do{
                let response=try JSONDecoder().decode(APIRespStruct.self, from:Data(strdata!.utf8))
//                print(response.metaData.dst)
//                print(response.metaData.src)
//                print(response.metaData.blu)
//                for i in 0..<response.inv.count{
//                    print("INV ARr")
//                    print(response.inv[i].dt)
//                    print(response.inv[i].at)
//                    print(response.inv[i].rt)
//                    print(response.inv[i].minfr)
//                    print(response.inv[i].bc)
//                    print(response.inv[i].tvs)
//                    print(response.inv[i].lp)
//                    print(response.inv[i].cur)
//                }
                resp=response
                
            }
            catch{
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return resp
    }
    func getDate(arrival:String)->String{
        var arrivalDate=""
        arrivalDate.append(arrival[String.Index(encodedOffset: 8)])
        arrivalDate.append(arrival[String.Index(encodedOffset: 9)])
        arrivalDate.append("-")
        arrivalDate.append(arrival[String.Index(encodedOffset: 5)])
        arrivalDate.append(arrival[String.Index(encodedOffset: 6)])
        arrivalDate.append("-")
        arrivalDate.append(arrival[String.Index(encodedOffset: 0)])
        arrivalDate.append(arrival[String.Index(encodedOffset: 1)])
        arrivalDate.append(arrival[String.Index(encodedOffset: 2)])
        arrivalDate.append(arrival[String.Index(encodedOffset: 3)])
                                   
        return arrivalDate
    }
    
    func getTime(timeStamp:String)->String{
        var time=""
        time.append(timeStamp[String.Index(encodedOffset: 11)])
        time.append(timeStamp[String.Index(encodedOffset: 12)])
        time.append(":")
        time.append(timeStamp[String.Index(encodedOffset: 14)])
        time.append(timeStamp[String.Index(encodedOffset: 15)])
        return time
    }
}
