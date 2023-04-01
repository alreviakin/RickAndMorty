//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 22.03.2023.
//

import UIKit
import SnapKit
import Alamofire

protocol MainViewContollerDelegate: AnyObject {
    func update(characters: [Result], images: [Data], gender: String?, status: String?)
}

class MainViewController: UIViewController {
    private var collection: UICollectionView!
    private var charactersData: [Result] = []
    private var characterImageData: [Data] = []
    private var gender: String? = nil
    private var status: String? = nil
    private lazy var searchControler: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Enter name"
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        
        return search
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addConstraint()
        DataManger.shared.getData { [weak self] (characters, images) in
            guard let self = self else {return}
            self.charactersData = characters
            self.characterImageData = images
            self.collection.reloadData()
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchControler
        title = "Characters"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.3"),
            style: .done,
            target: self,
            action: #selector(filterButton(sender:))
        )
        definesPresentationContext = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width * 0.4, height: view.bounds.height * 0.25)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        layout.scrollDirection = .vertical
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(CharacterCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collection)
    }
    
    private func addConstraint() {
        collection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
        let character = charactersData[indexPath.row]
        let name = character.name ?? "Name"
        let type = character.species ?? "Type"
        let status = Status(rawValue: character.status?.lowercased() ?? "unknown")!
        let image = UIImage(data: characterImageData[indexPath.row]) ?? UIImage(named: "bg")!
        
        cell.configure(character: CellCharacter(image: image, name: name, type: type, status: status))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CharacterController()
        let character = charactersData[indexPath.row]
        let image = UIImage(data: characterImageData[indexPath.row]) ?? UIImage(named: "bg")!
        vc.initialize(character: Character(
            image: image,
            name: character.name ?? "Name",
            status: Status(rawValue: character.status?.lowercased() ?? "unknown")!,
            species: character.species ?? "Species",
            type: character.type ?? "Type",
            gender: character.gender ?? "Gender",
            origin: character.origin?.name ?? "Origin",
            location: character.location?.name ?? "Location")
        )
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController {
    @objc private func filterButton(sender: UIBarButtonItem) {
        let vc = FilterCharactersController()
        vc.modalPresentationStyle = .custom
        vc.delegate = self
        vc.initialize(gender: gender, status: status)
        present(vc, animated: true)
    }
}

extension MainViewController: MainViewContollerDelegate {
    func update(characters: [Result], images: [Data], gender: String?, status: String?) {
        charactersData = characters
        characterImageData = images
        for character in characters {
            print(character.name ?? "Name")
        }
        self.gender = gender
        self.status = status
        collection.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var text = searchBar.text else {return}
        text = text.split(separator: " ").joined(separator: "%20")
        DataManger.shared.getData(name: text) { [weak self] (character, images) in
            guard let self = self else {return}
            if character.count == 0 {
                self.getAlert()
            } else {
                self.charactersData = character
                self.characterImageData = images
                self.collection.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DataManger.shared.getData { [weak self] (character, images) in
            guard let self = self else {return}
            self.charactersData = character
            self.characterImageData = images
            self.collection.reloadData()
        }
    }
}

extension MainViewController {
    private func getAlert() {
        let alert = UIAlertController(title: "Couldn't find a name" , message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
