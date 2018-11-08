//
//  SearchTableViewController.swift
//  iTunes Search
//
//  Created by Dennis Zubkoff on 07/11/2018.
//  Copyright © 2018 Dennis Zubkoff. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController{
    
    var results: [Result] = []
    var searchController: UISearchController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.text = result.artistName
        cell.detailTextLabel?.text = result.trackName
        return cell
    }
    
    func setupSearch() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.setValue("Отмена", forKey: "_cancelButtonText")
        searchController.searchBar.placeholder = "Искать..."
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func iTunesLoad(searchText text: String) {
        let baseURL = URL(string: "https://itunes.apple.com/search")!
        let query: [String: String] = [
            "term": text,
            "country": "ru"
        ]
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let returnData = String(data: data, encoding: .utf8)
                let inputJSON = returnData?.data(using: .utf8)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let result = try JSONDecoder().decode(ResultSearch.self, from: inputJSON!)
                    self.results = result.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error as NSError {
                    print("Ошибка JSON: \(error.localizedDescription)")
                }
                
                
            }
        }
        task.resume()
       
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

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        iTunesLoad(searchText: searchController.searchBar.text!)
    }
    
    
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }

}

