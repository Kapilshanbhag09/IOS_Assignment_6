//
//  NetworkManager.swift
//  Assignment6
//
//  Created by Kapil Ganesh Shanbhag on 11/05/22.
//

import Foundation
import UIKit
class NetworkManager{
    var viewControllerModelDelegateInstance:ViewControllerModelDelegate?
var respFromAPI=APIRespStruct(metaData: MetaDataStruct(dst: "", src: "", blu: ""), inv: [])
func getImagefromURL(link:String)->UIImage{
    let url = URL(string: link)
    let data = try? Data(contentsOf: url!)
    if let imageData = data {
        let imaged = UIImage(data: imageData)!
        return imaged
    }
    return UIImage(named: "invisible")!
}
    func getDataFromAPI()->APIRespStruct{
        let url = URL(string:  "https://api.jsonbin.io/b/6093c95293e0ce40806d8a1d")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let strdata=String(data: data, encoding: .utf8)
            do{
                let response=try JSONDecoder().decode(APIRespStruct.self, from:Data(strdata!.utf8))
                self.respFromAPI=response
                self.respFromAPI.inv[0].minfr=20
                self.respFromAPI.inv[1].minfr=15
                self.respFromAPI.inv[2].rt.totRt=4.5
                self.respFromAPI.inv[3].rt.totRt=5.0
                self.respFromAPI.inv[4].rt.totRt=2.0
                self.respFromAPI.inv[0].dt="2021-05-22 17:30:00"
                self.respFromAPI.inv[1].dt="2021-05-22 12:00:00"
                self.respFromAPI.inv[0].bc.IsAc=false
                self.respFromAPI.inv[0].bc.IsNonAc=true
                self.respFromAPI.inv[1].bc.IsSeater=false
                self.respFromAPI.inv[1].bc.IsSleeper=true
                self.respFromAPI.inv[3].bc.IsAc=false
                self.respFromAPI.inv[3].bc.IsNonAc=true
                self.respFromAPI.inv[3].bc.IsSeater=false
                self.respFromAPI.inv[3].bc.IsSleeper=true
                self.viewControllerModelDelegateInstance?.recievedRespFromAPI(resp:self.respFromAPI)
            }
            catch{
                print(error)
            }
        }
        task.resume()

        return respFromAPI
    }
}
