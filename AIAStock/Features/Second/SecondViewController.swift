//
//  SecondViewController.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/9/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var viewModel: SecondViewModel?
    
    private var stocks0: [Stock] = []
    private var stocks1: [Stock] = []
    private var stocks2: [Stock] = []

    @IBOutlet weak var symbol0: UILabel!
    @IBOutlet weak var symbol1: UILabel!
    @IBOutlet weak var symbol2: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func searchSymbol0(_ sender: Any) {
        searchSymbol(symbolLabel: 0)
    }
    
    @IBAction func searchSymbol1(_ sender: Any) {
        searchSymbol(symbolLabel: 1)
    }
    
    @IBAction func searchSymbol2(_ sender: Any) {
        searchSymbol(symbolLabel: 2)
    }
    
}

extension SecondViewController {
    static func create() -> SecondViewController {
        return SecondViewController(nibName: "SecondView", bundle: Bundle.main)
    }
}

extension SecondViewController {
    func setupView() {
        guard viewModel != nil else {
            return
        }
                
        navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.8823710084, green: 0.02105199732, blue: 0.1260389984, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let nib = UINib(nibName: "SecondTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SecondTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension SecondViewController {
    func searchSymbol(symbolLabel: Int) {
        let alertController = UIAlertController(title: "Search Symbol", message: "Please enter symbol to compare", preferredStyle: .alert)
        
        var searchSymbol: UITextField?
        
        let searchAction = UIAlertAction(
        title: "Search", style: .default) {
            (action) -> Void in

            if (searchSymbol?.text!.count)! > 0 {
                self.changeSymbol(symbolTag: symbolLabel, symbolName: (searchSymbol?.text)!)
            }else{
                self.changeSymbol(symbolTag: symbolLabel, symbolName: "+")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField {
            (symbol) -> Void in
            searchSymbol = symbol
            searchSymbol!.placeholder = "Search symbol"
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    func changeSymbol(symbolTag: Int, symbolName: String) {
        self.showLoading()
        viewModel?.fetch(symbol: symbolName, completion: { (stocks) in
            switch symbolTag {
                case 0:
                    self.symbol0.text = symbolName
                    self.stocks0 = stocks
                    self.stocks0.sort { (stock0, stock1) -> Bool in
                        stock0.date!.compare(stock1.date!) == .orderedDescending
                    }
                    break
                case 1:
                    self.symbol1.text = symbolName
                    self.stocks1 = stocks
                    self.stocks1.sort { (stock0, stock1) -> Bool in
                        stock0.date!.compare(stock1.date!) == .orderedDescending
                    }
                    break
                case 2:
                    self.symbol2.text = symbolName
                    self.stocks2 = stocks
                    self.stocks2.sort { (stock0, stock1) -> Bool in
                        stock0.date!.compare(stock1.date!) == .orderedDescending
                    }
                    break
                default: break
            }
            self.tableView.reloadData()
            self.hideLoading()
        })
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

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
        if stocks0.count > 0 {
            cell.open_symbol0.text = stocks0[indexPath.row].open
            cell.low_symbol0.text = stocks0[indexPath.row].high
            cell.dateLabel.text = stocks0[indexPath.row].date
        }else{
            cell.open_symbol0.text = "-"
            cell.low_symbol0.text = "-"
        }
        if stocks1.count > 0 {
            cell.open_symbol1.text = stocks1[indexPath.row].open
            cell.low_symbol1.text = stocks1[indexPath.row].low
            cell.dateLabel.text = stocks1[indexPath.row].date
        }else{
            cell.open_symbol1.text = "-"
            cell.low_symbol1.text = "-"
        }
        if stocks2.count > 0 {
            cell.open_symbol2.text = stocks2[indexPath.row].open
            cell.low_symbol2.text = stocks2[indexPath.row].low
            cell.dateLabel.text = stocks2[indexPath.row].date
        }else{
            cell.open_symbol2.text = "-"
            cell.low_symbol2.text = "-"
        }
        if stocks0.count < 1 && stocks1.count < 1 && stocks2.count < 1 {
            cell.dateLabel.text = "-"
        }
        return cell
        
    }
}

class SecondTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var open_symbol0: UILabel!
    @IBOutlet weak var open_symbol1: UILabel!
    @IBOutlet weak var open_symbol2: UILabel!
    
    @IBOutlet weak var low_symbol0: UILabel!
    @IBOutlet weak var low_symbol1: UILabel!
    @IBOutlet weak var low_symbol2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
