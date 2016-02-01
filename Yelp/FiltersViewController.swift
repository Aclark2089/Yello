//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Alex Clark on 1/29/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet var tableView: UITableView!
    
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        categories = yelpCategories()
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// Actions
    
    // Pressing Cancel Dismisses Controller View
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Pressing Search Button
    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var filters = [String:AnyObject]()
        var selectedCategories = [String]()
        
        for (row, isSelected) in switchStates {
            if isSelected {
            
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    
// Tableview Funcs
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
        
        cell.switchLabel.text = categories[indexPath.row]["name"]
        cell.delegate = self
        
        cell.onSwitch.on = switchStates[indexPath.row] ?? false
        
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        
        
        print("Filters view received switch event from delegate")
        
        switchStates[indexPath.row] = value
    }
    
    func yelpCategories() -> [[String:String]] {
        return [
                ["name": "Afgan", "code": "afgani"],
                ["name": "African", "code": "african"],
                ["name": "American (New)", "code": "newamerican"],
                ["name": "American (Traditional)", "code": "tradamerican"],
                ["name": "Arabian", "code": "arabian"],
                ["name": "Asian Fusion", "code": "asianfusion"],
                ["name": "Australian", "code": "australian"],
                ["name": "Bistros", "code": "bistros"],
                ["name": "Brazilian", "code": "brazilian"],
                ["name": "Breakfast & Brunch ", "code": "breakfast_brunch"],
                ["name": "Caribbean", "code": "caribbean"],
                ["name": "Chinese", "code": "Chinese"],
                ["name": "Cuban", "code": "cuban"],
                ["name": "Diners", "code": "diners"],
                ["name": "Fast Food", "code": "hotdogs"],
                ["name": "Fondue", "code": "fondue"],
                ["name": "French", "code": "french"],
                ["name": "German", "code": "german"],
                ["name": "Gluten-Free", "code": "gluten_free"],
                ["name": "Italian", "code": "italian"],
                ["name": "Japanese", "code": "japanese"],
                ["name": "Latin American", "code": "latin"],
                ["name": "Mexican", "code": "mexican"],
                ["name": "Middle Eastern", "code": "mideastern"],
                ["name": "Night Food", "code": "nightfood"],
                ["name": "Oriental", "code": "oriental"],
                ["name": "Pita", "code": "pita"],
                ["name": "Pizza", "code": "pizza"],
                ["name": "Russian", "code": "russian"],
                ["name": "Salad", "code": "salad"],
                ["name": "Sandwiches", "code": "sandwiches"],
                ["name": "Seafood", "code": "seafood"],
                ["name": "Spanish", "code": "spanish"],
                ["name": "Steakhouses", "code": "steak"],
                ["name": "Sushi", "code": "sushi"],
                ["name": "Taiwanese", "code": "taiwanese"],
                ["name": "Thai", "code": "thai"],
                ["name": "Turkish", "code": "turkish"],
                ["name": "Vegan", "code": "vegan"],
                ["name": "Vegetarian", "code": "vegetarian"],
                ["name": "Vietnamese", "code": "vietnamese"],
                ["name": "Wok", "code": "wok"],
                ["name": "Wraps", "code": "wraps"]
                ]
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
