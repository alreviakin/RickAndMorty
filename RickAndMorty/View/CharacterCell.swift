//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 22.03.2023.
//

import UIKit
import SnapKit
import Alamofire

final class CharacterCell: UICollectionViewCell {
    private var view: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let indicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private var imageData: Data?
//    private var character: Character?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(view)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(indicator)
        contentView.addSubview(typeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = nil
        typeLabel.text = nil
        imageData = nil
    }
    
    func configure(character: CellCharacter){
        imageView.image = character.image
        nameLabel.text = character.name
        typeLabel.text = character.status.rawValue.capitalized + " - " + character.type
        switch character.status {
        case .alive :
            indicator.backgroundColor = .green
        case .dead:
            indicator.backgroundColor = .red
        case .unknown:
            indicator.backgroundColor = .gray
        }
    }
    
    override func layoutSubviews() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(contentView.bounds.height * 0.7)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        indicator.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.height.width.equalTo(10)
        }
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(indicator.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(indicator.snp.centerY)
        }
        
    }
    
    
}
