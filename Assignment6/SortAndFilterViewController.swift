//
//  SortAndFilterViewController.swift
//  Assignment6
//
//  Created by Kapil Ganesh Shanbhag on 09/05/22.
//

import UIKit

class SortAndFilterViewController: UIViewController {
    var delegate:FilterAndSortDelegate?
    @IBOutlet weak var applyFilterButton:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyFilterButton.addTarget(self, action: #selector(applyFilterButton1Clicked), for: .touchUpInside)
    }
    @objc func applyFilterButton1Clicked(){
        delegate?.filterApplied(Filter: "Sort");
        dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
