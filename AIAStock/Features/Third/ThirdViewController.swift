//
//  ThirdViewController.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/9/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var apikeyField: UITextField!
    
    @IBOutlet weak var intervalPicker: UIPickerView!
    @IBOutlet weak var outputsizePicker: UIPickerView!
    
    
    private var interval = "1min"
    private var outputsize = "compact"
    
    var viewModel: ThirdViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func applySettings(_ sender: Any) {
        showLoading()
        if apikeyField.text!.count > 0 {
            KeychainSwift().set(apikeyField.text!, forKey: Query.apikey.rawValue)
        }
        
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        UserDefaults.standard.set(interval, forKey: Query.interval.rawValue)
        UserDefaults.standard.set(outputsize.lowercased(), forKey: Query.outputsize.rawValue)
        apikeyField.text = ""
        hideLoading()
    }
}

extension ThirdViewController {
    func setupView() {
        guard viewModel != nil else {
            return
        }
        
        intervalPicker.delegate = self
        intervalPicker.dataSource = self
        
        outputsizePicker.delegate = self
        outputsizePicker.dataSource = self
                
        navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.8823710084, green: 0.02105199732, blue: 0.1260389984, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func showLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    func hideLoading() {
        dismiss(animated: false, completion: nil)
    }
}

extension ThirdViewController {
    static func create() -> ThirdViewController {
        return ThirdViewController(nibName: "ThirdView", bundle: Bundle.main)
    }
}

extension ThirdViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.self == intervalPicker {
            return viewModel!.intervalList.count
        }else {
            return viewModel!.outputsizeList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.self == intervalPicker {
            interval = viewModel!.intervalList[row]
        }else {
            outputsize = viewModel!.outputsizeList[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Helvetica Neue", size: 12)
        
        if pickerView.self == intervalPicker {
            label.text = viewModel!.intervalList[row]
        }else {
            label.text = viewModel!.outputsizeList[row]
        }
        
        label.textAlignment = .center
        return label
    }
}
