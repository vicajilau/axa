//
//  VillagersListView.swift
//  axxa-app
//
//  Created by Victor Carreras on 24/5/22.
//

import UIKit
import Kingfisher

class BrastlewarkListView: BaseTableView {
    
    let viewModel = BrastlewarkViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredVillagers: [VillagerModel] = []
    
    var city: BrastlewarkModel? {
        didSet {
            filteredVillagers = city?.Brastlewark ?? []
            tableView.reloadData()
        }
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSearchController()
        getVillagers()
        title = "Brastlewark"
    }
    
    func prepareSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search villager"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredVillagers = city!.Brastlewark.filter { (villager: VillagerModel) -> Bool in
        return villager.name.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }
    
    func getVillagers() {
        Task {
            do {
                city = try await viewModel.getVillagers()
            } catch {
                NativeAlert(view: self, title: "ERROR", body: "Something happen getting the villagers", button: AlertButton(title: "ACCEPT")).show()
                Utils.printError(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredVillagers.count
        } else {
            return city?.Brastlewark.count ?? 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VillagerCell", for: indexPath) as! VillagerCell
        
        let villager = getVillager(index: indexPath.row)
        cell.nameLabel.text = villager.name
        cell.photo.makeRounded()
        if let urlImage = URL(string: villager.thumbnail) {
            cell.photo.kf.setImage(with: urlImage, placeholder: UIImage(named: "unknown-user")) 
        } else {
            cell.photo.image = UIImage(named: "unknown-user")
        }
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let villager = getVillager(index: indexPath.row)
        let nextView = DetailView()
        let nextViewModel = DetailViewModel(villager: villager)
        nextView.viewModel = nextViewModel
        pushView(nextView: nextView)
    }
    
    func getVillager(index: Int) -> VillagerModel {
        if isFiltering {
            return filteredVillagers[index]
        } else {
            guard let villager = city?.Brastlewark[index] else {
                Utils.controlledFailure(message: "Villager not found")
            }
            return villager
        }
    }

}

extension BrastlewarkListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
