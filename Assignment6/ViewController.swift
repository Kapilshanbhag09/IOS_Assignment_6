//
//  ViewController.swift
//  Assignment6
//
//  Created by Kapil Ganesh Shanbhag on 09/05/22.
//

import UIKit
protocol FilterAndSortDelegate{
    func filterApplied(filterString:String,busType:bc)
}
class ViewController: UIViewController,FilterAndSortDelegate {
    @IBOutlet weak var fromLabel:UILabel!
    @IBOutlet weak var toLabel:UILabel!
    @IBOutlet weak var applyFilterButton:UIButton!
    @IBOutlet weak var busesTableView:UITableView!
    var SortAndFilterVC=SortAndFilterViewController()
    
    var responseFromAPI = APIRespStruct(metaData: MetaDataStruct(dst: "", src: "", blu: ""), inv: [])
 let ViewControllerModelInstance=ViewControllerModel()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SortAndFilterVC.delegate=self
        responseFromAPI=ViewControllerModelInstance.getDataFromAPI()
        fromLabel.text="From : "+responseFromAPI.metaData.src
        toLabel.text="To : "+responseFromAPI.metaData.dst
        applyFilterButton.addTarget(self, action: #selector(applyFilterButtonClicked), for: .touchUpInside)
        
        self.busesTableView.dataSource = self
        busesTableView.register(UINib(nibName: "BusesTableViewCell", bundle: nil), forCellReuseIdentifier:"tableViewCell")
        //SortAndFilter.delegate=self
    }
    @objc func applyFilterButtonClicked(){
    present(SortAndFilterVC, animated: true)
    }
    func filterApplied(filterString:String,busType:bc){
        print("Filter applied called")
        responseFromAPI=ViewControllerModelInstance.appySortAndFilter(filterString: filterString, bustype: busType)
        //print(responseFromAPI)
        //print(ViewControllerModelInstance.appySortAndFilter(filterString: filterString, bustype: busType))
        busesTableView.reloadData()
    }


}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseFromAPI.inv.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=busesTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! BusesTableViewCell
        
        cell.travelsLabel.text = responseFromAPI.inv[indexPath.row].tvs
        cell.ratingLabel.text = "\(responseFromAPI.inv[indexPath.row].rt.totRt)"
        cell.priceLabel.text="\(responseFromAPI.inv[indexPath.row].minfr) \(responseFromAPI.inv[indexPath.row].cur)"
        var url="\(responseFromAPI.metaData.blu)/\(responseFromAPI.inv[indexPath.row].lp)"
        cell.buslogoImage.image=ViewControllerModelInstance.getImage(url: url)
        var filterString:String=""
        if(responseFromAPI.inv[indexPath.row].bc.IsAc){
            filterString = filterString+"AC "
        }
        if(responseFromAPI.inv[indexPath.row].bc.IsNonAc){
            filterString = filterString+"Non-AC "
        }
        if(responseFromAPI.inv[indexPath.row].bc.IsSeater){
            filterString = filterString+"Seater "
        }
        if(responseFromAPI.inv[indexPath.row].bc.IsSleeper){
            filterString = filterString+"Sleeper "
        }
        cell.filterLabel.text=filterString
        let arrival=responseFromAPI.inv[indexPath.row].at
        let arrivalDate=ViewControllerModelInstance.getDate(arrival: arrival)
        let arrivalTime=ViewControllerModelInstance.getTime(timeStamp: arrival)
        let departure=responseFromAPI.inv[indexPath.row].dt
        let departureDate = ViewControllerModelInstance.getDate(arrival: departure)
        let departureTime = ViewControllerModelInstance.getTime(timeStamp: departure)
        cell.arrivalDateLabel.text=arrivalDate
        cell.departureDateLabel.text=departureDate
        cell.arrivalDateTime.text=arrivalTime
        cell.departureDateTime.text=departureTime
        
        return cell
    }
    
    
}

