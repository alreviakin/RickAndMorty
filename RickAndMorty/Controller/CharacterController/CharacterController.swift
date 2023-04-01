//
//  CharacterController.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 25.03.2023.
//

import UIKit
import SnapKit

class CharacterController: UIViewController {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let speciesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let typeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let genderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let originLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalCentering
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(imageView)
        view.addSubview(stack)
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(speciesLabel)
        if typeLabel.text != nil {
            stack.addArrangedSubview(typeLabel)
        }
        stack.addArrangedSubview(statusLabel)
        stack.addArrangedSubview(genderLabel)
        stack.addArrangedSubview(originLabel)
        stack.addArrangedSubview(locationLabel)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(view.bounds.width - 70)
        }
        stack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo((view.bounds.width - 70) / 2)
        }
    }
    
    func initialize(character: Character) {
        title = character.name
        imageView.image = character.image
        nameLabel.text = "Name: " + character.name
        statusLabel.text = "Status: " + character.status.rawValue
        speciesLabel.text = "Species: " + character.species
        if !character.type.isEmpty{
            typeLabel.text = "Type: " + character.type
        }
        genderLabel.text = "Gender: " + character.gender
        originLabel.text = "Origin: " + character.origin
        locationLabel.text = "Location: " + character.location
    }
    
}
