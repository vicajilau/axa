//
//  DetailView.swift
//  axxa-app
//
//  Created by Victor Carreras on 24/5/22.
//

import UIKit
import Kingfisher

enum KindOfDetailTable: Int, CaseIterable {
    case professions = 0
    case friends = 1
}

class DetailView: BaseView {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareTableView()
        loadUI()
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
    }
    
    func loadUI() {
       loadImage()
        nameLabel.text = viewModel?.getName()
        yearsLabel.text = viewModel?.getYears()
        weightLabel.text = viewModel?.getWeight()
        heightLabel.text = viewModel?.getHeight()
        hairColorLabel.text = viewModel?.getHairColor()
        
    }
    
    func loadImage() {
        let url = viewModel?.getImageURL()
         if let urlImage = url {
             photoView.kf.setImage(with: urlImage, placeholder: UIImage(named: "unknown-user"))
         } else {
             photoView.image = UIImage(named: "unknown-user")
         }
         photoView.makeRounded()
    }
}

extension DetailView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return KindOfDetailTable.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case KindOfDetailTable.professions.rawValue:
            return "Professions"
        case KindOfDetailTable.friends.rawValue:
            return "Friends"
        default:
            Utils.controlledFailure(message: " \(section) section is not implemented yet" )
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case KindOfDetailTable.professions.rawValue:
            return viewModel?.getProfessions().count ?? 0
        case KindOfDetailTable.friends.rawValue:
            return viewModel?.getFriends().count ?? 0
        default:
            Utils.controlledFailure(message: " \(section) section is not implemented yet" )
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as!  DetailCell
        
        switch (indexPath.section) {
        case KindOfDetailTable.professions.rawValue:
            cell.title.text = viewModel?.getProfessions()[indexPath.row]
        case KindOfDetailTable.friends.rawValue:
            cell.title.text = viewModel?.getFriends()[indexPath.row]
        default:
            Utils.controlledFailure(message: " \(indexPath.section) section is not implemented yet" )
        }

        return cell
    }
    
}
