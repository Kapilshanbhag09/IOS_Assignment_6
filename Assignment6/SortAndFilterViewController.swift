//
//  SortAndFilterViewController.swift
//  Assignment6
//
//  Created by Kapil Ganesh Shanbhag on 09/05/22.
//

import UIKit
struct bc{
    var isAC:Bool
    var isNonAc:Bool
    var isSeater:Bool
    var isSleeper:Bool
}
class SortAndFilterViewController: UIViewController {
    var delegate:FilterAndSortDelegate?
    @IBOutlet weak var fareSwitch: UISwitch!
    @IBOutlet weak var ratingSwitch:UISwitch!
    @IBOutlet weak var departureSwitch:UISwitch!
    
    @IBOutlet weak var acSwitch:UISwitch!
    @IBOutlet weak var nonAcSwitch:UISwitch!
    @IBOutlet weak var seaterSwitch:UISwitch!
    @IBOutlet weak var sleeperSwitch:UISwitch!
    @IBOutlet weak var applyingFilter:UILabel!
    var filterString=""
    var bustype=bc(isAC: false, isNonAc: false, isSeater: false, isSleeper: false)
    
    
    
    @IBOutlet weak var applyFilterButton:UIButton!
    override func viewDidLoad() {
        applyingFilter.text=""
        super.viewDidLoad()
        setSwitches()
        
        // Do any additional setup after loading the view.
        applyFilterButton.addTarget(self, action: #selector(applyFilterButton1Clicked), for: .touchUpInside)
    }
    
    func setSwitches(){
        fareSwitch.isOn=false
        ratingSwitch.isOn=false
        departureSwitch.isOn=false
        acSwitch.isOn=false
        nonAcSwitch.isOn=false
        seaterSwitch.isOn=false
        sleeperSwitch.isOn=false
        ratingSwitch.addTarget(self, action: #selector(ratingSwitchClicked), for: .valueChanged)
        fareSwitch.addTarget(self, action: #selector(fairSwitchClicked), for: .valueChanged)
        departureSwitch.addTarget(self, action: #selector(departureSwitchClicked), for: .valueChanged)
        acSwitch.addTarget(self, action: #selector(acSwitchClicked), for: .valueChanged)
        nonAcSwitch.addTarget(self, action: #selector(nonAcSwitchClicked), for: .valueChanged)
        seaterSwitch.addTarget(self, action: #selector(seaterSwitchClicked), for: .valueChanged)
        sleeperSwitch.addTarget(self, action: #selector(sleeperSwitchClicked), for: .valueChanged)
        
    }
    @objc func applyFilterButton1Clicked(){
        applyingFilter.text="Applying Filter..."
        dismiss(animated: true)
        delegate?.filterApplied(filterString: filterString, busType: bustype);
        applyingFilter.text=""

    }
    @objc func ratingSwitchClicked(){
        departureSwitch.isOn=false
        fareSwitch.isOn=false
        if(ratingSwitch.isOn){
        filterString="Rating"
        }
        else{
            filterString=""
        }
    }
    @objc func departureSwitchClicked(){
        ratingSwitch.isOn=false
        fareSwitch.isOn=false
        if(departureSwitch.isOn){
        filterString="Departure"
        }
        else{
            filterString=""
        }
    }
    @objc func fairSwitchClicked(){
        ratingSwitch.isOn=false
        departureSwitch.isOn=false
        if(fareSwitch.isOn){
        filterString="Fair"
        }
        else{
            filterString=""
        }
    }
    @objc func acSwitchClicked(){
        bustype.isAC=acSwitch.isOn
    }
    @objc func nonAcSwitchClicked(){
        bustype.isNonAc=nonAcSwitch.isOn
    }
    @objc func seaterSwitchClicked(){
        bustype.isSeater=seaterSwitch.isOn
    }
    @objc func sleeperSwitchClicked(){
        bustype.isSleeper=sleeperSwitch.isOn
    }

}
