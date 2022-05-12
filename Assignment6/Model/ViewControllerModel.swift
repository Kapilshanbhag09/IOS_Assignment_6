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
protocol ViewControllerModelDelegate{
    func recievedRespFromAPI(resp:APIRespStruct)
}

class ViewControllerModel:ViewControllerModelDelegate{

    var viewControllerDelegate:FilterAndSortDelegate?
    var respFromAPI=APIRespStruct(metaData: MetaDataStruct(dst: "", src: "", blu: ""), inv: [])
    var filteredRespFromAPI=APIRespStruct(metaData: MetaDataStruct(dst: "", src: "", blu: ""), inv: [])
    var NetworkManagerInstance=NetworkManager()
    
    
    
    // MARK: GETDATAFROMAPI() func
    // Called to get data from API. This calls the network manager getDataFromAPI function
    func getDataFromAPI()->APIRespStruct{
        NetworkManagerInstance.viewControllerModelDelegateInstance=self
       respFromAPI=NetworkManagerInstance.getDataFromAPI()
        return respFromAPI
    }
    
    // MARK: RECIEVEDRESPFROMAPI() func
    // Called once the Network Manager loads data from API
    func recievedRespFromAPI(resp: APIRespStruct) {
        print("Delegate in View")
        respFromAPI=resp
        self.viewControllerDelegate?.recievedResponse(responseFromAPI: self.respFromAPI)
    }
    
    // MARK: APPLYSORTANDFILTER() func
    // Called when applying filter and sort
    func appySortAndFilter(filterString:String,bustype:bc)->APIRespStruct{
        var tempFilteredResp=APIRespStruct(metaData: MetaDataStruct(dst: "", src: "", blu: ""), inv: [])
        tempFilteredResp.metaData.dst=respFromAPI.metaData.dst
        tempFilteredResp.metaData.src=respFromAPI.metaData.src
        tempFilteredResp.metaData.blu=respFromAPI.metaData.blu
        if(filterString=="Rating"){
            var ratingarray:[Double]=[]
            
            for i in respFromAPI.inv{
                let temp=i.rt.totRt
                var flag=0
                for j in ratingarray{
                    if(temp==j){
                        flag=1
                        break;
                    }
                }
                if(flag==0){
                ratingarray.append(i.rt.totRt)
                }
            }
            ratingarray.sort()
            let reversedRatingArray:[Double]=Array(ratingarray.reversed())
            ratingarray=reversedRatingArray
            for j in 0..<ratingarray.count{
                for i in respFromAPI.inv{
                if(ratingarray[j]==i.rt.totRt){
                    tempFilteredResp.inv.append(i)
                }
                }
            }
            filteredRespFromAPI=tempFilteredResp
            applyFilter(bustype: bustype)
            return filteredRespFromAPI
            
        }
        else if(filterString=="Departure"){
            var departureArray:[String]=[]
            for i in respFromAPI.inv{
                let temp=i.dt
                var flag=0
                for j in departureArray{
                    if(temp==j){
                        flag=1
                        break;
                    }
                }
                if(flag==0){
                departureArray.append(i.dt)
                }
            }
            departureArray.sort()
            for j in 0..<departureArray.count{
                for i in respFromAPI.inv{
                    if(departureArray[j]==i.dt){
                        tempFilteredResp.inv.append(i)
                    }
                }
            }
            filteredRespFromAPI=tempFilteredResp
            applyFilter(bustype: bustype)
            return filteredRespFromAPI
            
            
        }
        else if(filterString=="Fair"){
            var fairArray:[Int]=[]
            for i in respFromAPI.inv{
                let temp=i.minfr
                var flag=0
                for j in fairArray{
                    if(temp==j){
                        flag=1
                        break;
                    }
                }
                if(flag==0){
                fairArray.append(i.minfr)
                }
            }
            fairArray.sort()
            for j in 0..<fairArray.count{
                for i in respFromAPI.inv{
                    if(fairArray[j]==i.minfr){
                        tempFilteredResp.inv.append(i)
                    }
                }
            }
            filteredRespFromAPI=tempFilteredResp
            applyFilter(bustype: bustype)
            return filteredRespFromAPI
            
            
        }
        else{
            filteredRespFromAPI=respFromAPI
            applyFilter(bustype: bustype)
            return filteredRespFromAPI
        }
        return respFromAPI
    }
    
    
    //MARK: APPLYFILTER() func
    //Called to apply only filter
    func applyFilter(bustype:bc){
        var tempFilteredResp=APIRespStruct(metaData: MetaDataStruct(dst: "", src: "", blu: ""), inv: [])
        tempFilteredResp.metaData.dst=respFromAPI.metaData.dst
        tempFilteredResp.metaData.src=respFromAPI.metaData.src
        tempFilteredResp.metaData.blu=respFromAPI.metaData.blu
        for i in filteredRespFromAPI.inv{
            var flag=0
            if(bustype.isAC){
                if(i.bc.IsAc==false){
                    flag=1;
                }
            }
            if(bustype.isNonAc){
                if(i.bc.IsNonAc==false){
                    flag=1;
                }
            }
            if(bustype.isSleeper){
                if(i.bc.IsSleeper==false){
                    flag=1;
                }
            }
            if(bustype.isSeater){
                if(i.bc.IsSeater==false){
                    flag=1;
                }
            }
            if(flag==0){
                tempFilteredResp.inv.append(i)
            }
        }
        filteredRespFromAPI=tempFilteredResp
    }
    
    
    
    
    
    
    //MARK: GETDATE() func
    func getDate(arrival:String)->String{
        var arrivalDate=""
        arrivalDate.append(arrival[String.Index(utf16Offset: 8,in: arrival)])
        arrivalDate.append(arrival[String.Index(utf16Offset: 9,in: arrival)])
        arrivalDate.append("-")
        arrivalDate.append(arrival[String.Index(utf16Offset: 5,in: arrival)])
        arrivalDate.append(arrival[String.Index(utf16Offset: 6,in: arrival)])
        arrivalDate.append("-")
        arrivalDate.append(arrival[String.Index(utf16Offset: 0,in: arrival)])
        arrivalDate.append(arrival[String.Index(utf16Offset: 1,in: arrival)])
        arrivalDate.append(arrival[String.Index(utf16Offset: 2,in: arrival)])
        arrivalDate.append(arrival[String.Index(utf16Offset: 3,in: arrival)])
                                   
        return arrivalDate
    }
    //MARK: GETTIME() func
    func getTime(timeStamp:String)->String{
        var time=""
        time.append(timeStamp[String.Index(utf16Offset: 11,in: timeStamp)])
        time.append(timeStamp[String.Index(utf16Offset: 12,in: timeStamp)])
        time.append(":")
        time.append(timeStamp[String.Index(utf16Offset: 14,in: timeStamp)])
        time.append(timeStamp[String.Index(utf16Offset: 15,in: timeStamp)])
        return time
    }
    
    func getImage(url:String)->UIImage{
        NetworkManagerInstance.getImagefromURL(link: url)
    }
}
