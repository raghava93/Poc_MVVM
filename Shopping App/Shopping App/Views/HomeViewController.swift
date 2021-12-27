//
//  ViewController.swift
//  Shopping App
//
//  Created by Raghavendra reddy on 22/12/21.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var table: UITableView!
    lazy var homeModel = HomeViewModel(_networkManager: NetworkManager()) // view model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        fetch product details
        configureTable()
        navigationController?.title = "Shopping"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        
        //        show alert for error
        homeModel.showError = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showAlert("Ups, something went wrong.")
            }
        }
        //        show indicator
        homeModel.showLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            
        }
        //        hide indicator
        homeModel.hideLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
        
        //        fetch product details and update in table
        homeModel.getProducts(completion: { [weak self] in
            debugPrint("called reload")
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        })
        
    }
    
    //    configure tableview to home view controller
    func configureTable() {
        table.largeContentTitle = "Shopping"
        table.delegate = self
        table.dataSource = self
        table.separatorColor = .gray
        table.separatorStyle = .singleLine
        table.tableFooterView = UIView()
        table.allowsMultipleSelection = false
        table.layoutMargins = UIEdgeInsets.zero
        table.separatorInset = UIEdgeInsets.zero
        table.backgroundView = activityIndicator // add indicator as backgrounf view
        activityIndicator.color = #colorLiteral(red: 0.1808195114, green: 0.1178461984, blue: 0.7841414213, alpha: 1)
        table.center = activityIndicator.center
        activityIndicator.style = .large
        //         register cell for table view
        table.register(ProductCell.nib(), forCellReuseIdentifier: ProductCell.identifier())
    }
    
    
    //    navigate to product details view controller
    func showDetailsVC(product:ProductElement)  {
        let vc = (storyboard?.instantiateViewController(withIdentifier: "productDetailsVC"))  as! ProductViewController
        vc.productModel = product
        //        navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
    }
    
}

// MARK:- TableView datasource
extension HomeViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
// MARK:- TableView delegate
extension HomeViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeModel.productsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier(), for: indexPath) as? ProductCell else { fatalError("xib does not exists") }
        let cellVM = homeModel.getCellViewModel(at: indexPath)
        cell.layoutMargins = .zero
        cell.cellViewModel = cellVM
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product =  homeModel.getCellViewModel(at: indexPath)!
        showDetailsVC(product: product)
    }
}
