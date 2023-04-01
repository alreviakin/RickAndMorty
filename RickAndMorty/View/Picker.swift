//
//  Picker.swift
//  RickAndMorty
//
//  Created by Алексей Ревякин on 26.03.2023.
//

import UIKit

class Picker: UIPickerView {
    
    private var rows: [String] = []

    init(rows: [String]) {
        super.init(frame: CGRect())
        self.rows = rows
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Picker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rows.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rows[row]
    }
    
    
}


