//
//  BusesTableViewCell.swift
//  Assignment6
//
//  Created by Kapil Ganesh Shanbhag on 10/05/22.
//

import UIKit

class BusesTableViewCell: UITableViewCell {
    @IBOutlet weak var travelsLabel:UILabel!
    @IBOutlet weak var buslogoImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var arrivalDateTime: UILabel!
    @IBOutlet weak var arrivalDateLabel: UILabel!
    @IBOutlet weak var departureDateTime: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        buslogoImage.image = UIImage(named: "20059")
        //buslogoImage.image?.size=CGSize(width: 100.0, height:100.0)ce
        
    }
    
}
