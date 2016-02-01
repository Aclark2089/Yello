//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit


class BusinessesViewController: UIViewController, UITableViewDataSource, FiltersViewControllerDelegate {

    // Outlets
    @IBOutlet var tableView: UITableView!
    
    
    // Structs
    var businesses: [Business]!
    var filteredBusinessess: [Business]!
    var isMoreDataLoading = false
    
    // Program our search bar
    lazy var navSearchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate Tableviewe
        tableView.dataSource = self
        tableView.delegate = self
        
        // Delegate Search Bar
        navSearchBar.delegate = self
        
        // Setup search bar in navigation view
        self.navigationItem.titleView = navSearchBar
        
        // Figure out height based on autolayout constraints and estimation
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinessess = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// Tableview Functions

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController   
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        var categories = filters["categories"] as? [String]
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: categories, deals: true) {
            (businesses:[Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinessess = businesses
            self.tableView.reloadData()
        }
    }

}

// Table View Extension for Business View Controller
extension BusinessesViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredBusinessess != nil {
            return filteredBusinessess!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = filteredBusinessess[indexPath.row]
        
        return cell
    }

}

// Scroll View Extension for Business View Controller
extension BusinessesViewController: UIScrollViewDelegate {
    func loadDataOnScroll() {
        self.isMoreDataLoading = false
        
        // Infinite scroll works here but doesn't have much to load inf. anyway
        // Could optionally have it keep refreshing the businessess at that particular location but would not make much sense since it would chew up requests and the businesses would not update very quickly
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if(!isMoreDataLoading){
            
            let scrollViewContentHeight = tableView.contentSize.height;
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadDataOnScroll()
                scrollView.contentOffset.y = 0
            }
            
        }
    }
}

// Search Bar Extension for Business View Controller
extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        filteredBusinessess = businesses
        self.tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(navSearchBar: UISearchBar, textDidChange searchText: String) {
        var searchBusinesses = [NSDictionary]()
        filteredBusinessess = searchText.isEmpty ? businesses:
            businesses.filter({ (business: Business) -> Bool in
                return (business.name!).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            })
        
        // Reload table
        self.tableView.reloadData()
    }
    
}
