//
//  FileterCharactersController.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 26.03.2023.
//

import UIKit



class FilterCharactersController: UIViewController {
    weak var delegate: MainViewContollerDelegate?
    private let genders = ["-","Female", "Male", "Genderless", "unknown"]
    private let status = ["_", "Alive", "Dead", "unknown"]
    private lazy var backgroundBlur: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.alpha = 0.85
        view.frame = self.view.frame
        return view
    }()
    private let whiteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()
    private lazy var genderButton: UIButton = {
       let button = UIButton()
        button.setTitle("Select Gender", for: .normal)
        button.layer.borderColor = UIColor.cyan.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(addCategory(sender:)), for: .touchUpInside)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    private lazy var statusButton: UIButton = {
       let button = UIButton()
        button.setTitle("Select Status", for: .normal)
        button.layer.borderColor = UIColor.cyan.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(addCategory(sender:)), for: .touchUpInside)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    private var picker = Picker(rows: [])
    private let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()
    private lazy var filterButton: UIButton = {
       let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 19
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(filter), for: .touchUpInside)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    private lazy var clearButton: UIButton = {
       let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 19
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(clear), for: .touchUpInside)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    func initialize(gender: String?, status: String?) {
        if let gender {
            genderButton.setTitle(gender, for: .normal)
        }
        if let status {
            statusButton.setTitle(status, for: .normal)
        }
    }
    
    private func configure() {
        view.addSubview(backgroundBlur)
        view.addSubview(whiteBackgroundView)
        whiteBackgroundView.addSubview(genderButton)
        whiteBackgroundView.addSubview(statusButton)
        whiteBackgroundView.addSubview(filterButton)
        whiteBackgroundView.addSubview(clearButton)
    }
    
    override func viewDidLayoutSubviews() {
        whiteBackgroundView.snp.remakeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        genderButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(genderButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }

        filterButton.snp.makeConstraints { make in
            make.top.equalTo(statusButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }

        clearButton.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }
        
    }
}

extension FilterCharactersController {
    @objc func addCategory(sender: UIButton) {
        if sender == genderButton {
            picker = Picker(rows: genders)
            genderButton.isEnabled = false
        } else {
            picker = Picker(rows: status)
            statusButton.isEnabled = false
        }
        
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.lightGray, for: .normal)
        saveButton.addTarget(self, action: #selector(saveBtn), for: .touchUpInside)
        
        
        backgroundView.addSubview(picker)
        backgroundView.addSubview(saveButton)
        backgroundView.alpha = 0
        self.view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-30)
        }
        picker.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0){
            self.backgroundView.alpha = 1
        }
    }
    
    @objc private func saveBtn() {
        let index = picker.selectedRow(inComponent: 0)
        let selectedValue = picker.pickerView(picker, titleForRow: index, forComponent: index)!
        if genders[index] == selectedValue {
            genderButton.isEnabled = true
            if index != 0 {
                genderButton.setTitle(selectedValue, for: .normal)
            } else {
                genderButton.setTitle("Select Gender", for: .normal)
            }
        } else {
            statusButton.isEnabled = true
            if index != 0 {
                statusButton.setTitle(selectedValue, for: .normal)
            } else {
                statusButton.setTitle("Select Gender", for: .normal)
            }
        }
        UIView.animate(withDuration: 0.5, delay: 0, animations: ({
            self.backgroundView.alpha = 0
        })) { _ in
            for view in self.backgroundView.subviews {
                view.removeFromSuperview()
            }
            self.backgroundView.removeFromSuperview()
        }
    }
    
    @objc
    private func filter() {
        var gender = genderButton.titleLabel?.text
        var status = statusButton.titleLabel?.text
        if gender == "Select Gender" {
            gender = nil
        }
        if status == "Select Status" {
            status = nil
        }
        DataManger.shared.getData (gender: gender, status: status){ [weak self] (characters, images) in
            guard let self = self else {return}
            self.delegate?.update(characters: characters, images: images, gender: gender, status: status)
        }
        dismiss(animated: true)
    }
    
    @objc
    private func clear() {
        self.genderButton.setTitle("Select Gender", for: .normal)
        self.statusButton.setTitle("Select Status", for: .normal)
    }
}
