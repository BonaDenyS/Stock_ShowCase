//
//  FirstViewController.swift
//  AIAStock
//
//  Created by Bona Deny S on 10/9/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var viewModel: FirstViewModel?
    
    private var stocks: [Stock] = []
    private var sortByDate =  false
    private var sortByOpen =  false
    private var sortByHigh =  false
    private var sortByLow =  false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func sortByDate(_ sender: Any) {
        if sortByDate {
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.date!.compare(stock1.date!) == .orderedDescending
            }
            self.tableView.reloadData()
            sortByDate = false
        }else{
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.date!.compare(stock1.date!) == .orderedAscending
            }
            self.tableView.reloadData()
            sortByDate = true
        }
    }
    
    @IBAction func sortByOpen(_ sender: Any) {
        if sortByOpen {
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.open.compare(stock1.open) == .orderedDescending
            }
            self.tableView.reloadData()
            sortByOpen = false
        }else{
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.open.compare(stock1.open) == .orderedAscending
            }
            self.tableView.reloadData()
            sortByOpen = true
        }
    }
    
    @IBAction func sortByHigh(_ sender: Any) {
        if sortByHigh {
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.high.compare(stock1.high) == .orderedDescending
            }
            self.tableView.reloadData()
            sortByHigh = false
        }else{
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.high.compare(stock1.high) == .orderedAscending
            }
            self.tableView.reloadData()
            sortByHigh = true
        }
    }
    
    @IBAction func sortByLow(_ sender: Any) {
        if sortByLow {
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.low.compare(stock1.low) == .orderedDescending
            }
            self.tableView.reloadData()
            sortByLow = false
        }else{
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.low.compare(stock1.low) == .orderedAscending
            }
            self.tableView.reloadData()
            sortByLow = true
        }
    }
    
}

extension FirstViewController {
    static func create() -> FirstViewController {
        return FirstViewController(nibName: "FirstView", bundle: Bundle.main)
    }
}

extension FirstViewController {
    func setupView() {
        guard viewModel != nil else {
            return
        }
        showLoading()
        viewModel?.fetch(symbol:"AAPL", completion: { (stocks) in
            self.stocks = stocks
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.date!.compare(stock1.date!) == .orderedDescending
            }
            self.tableView.reloadData()
            self.hideLoading()
        })
                
        navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.8823710084, green: 0.02105199732, blue: 0.1260389984, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let nib = UINib(nibName: "FirstTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FirstTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = #colorLiteral(red: 0.8823710084, green: 0.02105199732, blue: 0.1260389984, alpha: 1)
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.placeholder = "Search Symbol"
        searchBar.barTintColor = UIColor.init(cgColor: #colorLiteral(red: 0.8823710084, green: 0.02105199732, blue: 0.1260389984, alpha: 1))
        
        self.hideKeyboardWhenTappedAround()
        
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
        cell.openLabel.text = stocks[indexPath.row].open
        cell.highLabel.text = stocks[indexPath.row].high
        cell.lowLabel.text = stocks[indexPath.row].low
        cell.dateLabel.text = stocks[indexPath.row].date
        return cell
        
    }
}

extension FirstViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.showLoading()
        viewModel?.fetch(symbol: searchBar.text!.uppercased(), completion: { (stocks) in
            self.stocks = stocks
            self.stocks.sort { (stock0, stock1) -> Bool in
                stock0.date!.compare(stock1.date!) == .orderedDescending
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class FirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
