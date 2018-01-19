//
//  SearchCityViewController.swift
//  WeatherTestApp
//
//  Created by Tomasz Idzi on 18/01/2018.
//  Copyright © 2018 Tomasz Idzi. All rights reserved.
//

import UIKit

protocol SearchCityDelegate {
    func weatherWasSelected(for city:City)
}

class SearchCityViewController: UIViewController {

    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var cityResponse: CityResponse?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredcityResponse = [City]()
    var delegate: SearchCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cities"
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.global(qos: .userInitiated).async {
            APIManager.getCities() { (response, error) in
                if let citiesResponse = response {
                    self.cityResponse = citiesResponse
                    DispatchQueue.main.async {
                        self.citiesTableView.reloadData()
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    //Bug in iOS 11.2 - RightBarButtonItem is still selected when back.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.tintAdjustmentMode = .normal
        navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
        
    //MARK: Functions
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredcityResponse = (cityResponse?.cities?.filter({( city : City) -> Bool in
            return (city.name?.lowercased().contains(searchText.lowercased()))!
        }))!
        
        citiesTableView.reloadData()
    }
}

//MARK: TableView
extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredcityResponse.count
        } else {
            if let detail = self.cityResponse?.cities {
                return detail.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let city: City
        if isFiltering() {
            city = self.filteredcityResponse[indexPath.row]
        } else {
            city = (self.cityResponse?.cities![indexPath.row])!
        }
        cell.textLabel?.text = city.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city: City
        if isFiltering() {
            city = self.filteredcityResponse[indexPath.row]
        } else {
            city = (self.cityResponse?.cities![indexPath.row])!
        }
        self.delegate?.weatherWasSelected(for: city)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension SearchCityViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
