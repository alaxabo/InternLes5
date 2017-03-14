//
//  ViewController.swift
//  TraningEx5
//
//  Created by Alaxabo on 3/13/17.
//  Copyright © 2017 Alaxabo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var editValue = 0
    var moveValue = 0

    var avResult = [AVResult]()
    
    private func initAvResult() {
        
        let dateString = "2016.04.04 09:46"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
        let date = dateFormatter.date(from: dateString)
        
        for _ in 0 ..< 10 {
            let avResult1 = AVResult(caputureDate: date!, avValue: Float.random(min: 2, max: 3), loviValue: Int(arc4random_uniform(180) + 1))
            avResult += [avResult1]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return avResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath as IndexPath) as! AVResultTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .gray
        }
        
        // Configure the cell...
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd hh:mm"
        cell.caputureDateLabel?.text = dateFormatter.string(from: avResult[indexPath.row].caputureDate)
        
        cell.avValueLabel?.text = "AV \(avResult[indexPath.row].avValue)"
        cell.loviValueLabel?.text = "色度 \(avResult[indexPath.row].loviValue)"
        cell.avImage?.image = UIImage(named: "Image")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //Other row is selected - need to deselect it
        if (indexPath.row % 2 == 0)
        //update the checkmark for the current row
        {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        let postList = storyboard?.instantiateViewController(withIdentifier: "testPresentView") as! AVResultDetailPresentViewController
            // Send data to collectionView
            postList.avResultDetail = avResult[indexPath.row]
            // PresentViewController
        self.present(postList, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: "showAVResultDetail", sender: self)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 1
        // Return false if you do not want the specified item to be editable.
        if (editValue == 1) || (moveValue == 1){
            return true
        }
        else {
            return false}
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            avResult.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        if moveValue == 1{
            return true
        }
        else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.avResult[fromIndexPath.row]
        avResult.remove(at: fromIndexPath.row)
        avResult.insert(movedObject, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    
    
    @IBAction func editIsClicked(_ sender: UIBarButtonItem) {
        if (editValue == 1)
        {
            editValue = 0
            self.editButton.title = "Edit"
            moveButton.isEnabled = true
            
        }
        else{
            editValue = 1
            self.editButton.title = "Done"
            moveButton.isEnabled = false
        }
        
    }
    @IBAction func moveIsClicked(_ sender: UIBarButtonItem) {
        if (moveValue == 1)
        {
            moveValue = 0
            self.moveButton.title = "Move"
            editButton.isEnabled = true
            self.tableView.isEditing = false
            
        }
        else{
            moveValue = 1
            self.moveButton.title = "Done"
            editButton.isEnabled = false
            self.tableView.isEditing = true
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAVResultDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! AVResultDetailViewController
                destinationController.avResultDetail = avResult[indexPath.row]
            }
        }
    }

    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIBarButtonItem!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAvResult()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

