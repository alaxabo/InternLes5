//
//  AVResultDetailPresentViewController.swift
//  TraningEx5
//
//  Created by Alaxabo on 3/14/17.
//  Copyright © 2017 Alaxabo. All rights reserved.
//

import UIKit

class AVResultDetailPresentViewController: UIViewController {
    
    @IBOutlet var avImageView:UIImageView!
    @IBOutlet var caputureDateDetailLabel: UILabel?
    @IBOutlet var avValueDetailLabel : UILabel?
    @IBOutlet var loviValueDetailLabel : UILabel?
    
    var avResultDetail: AVResult!
    func showavDetail()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
        
        
        self.caputureDateDetailLabel?.text = dateFormatter.string(from: avResultDetail.caputureDate)
        self.avValueDetailLabel?.text = "AV \(avResultDetail.avValue)"
        self.loviValueDetailLabel?.text = "色度 \(avResultDetail.loviValue)"
        avImageView.image = UIImage(named: "Image")
        
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showavDetail()
        // Do any additional setup after loading the view.
    }
}
