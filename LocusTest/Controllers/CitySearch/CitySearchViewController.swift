//
//  ViewController.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import UIKit

protocol CityControllerDelegate: AnyObject {
    
    func didSelectCity(place: City)
    
}

class CitySearchViewController: UIViewController {

    @IBOutlet weak var textCityName: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CitySearchViewModel!
    weak var delegate: CityControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CitySearchViewControllerVM(delegate: self)
        
        setupUI()
    }
    
    private func setupUI() {
        textCityName.delegate = self
        textCityName.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
}

extension CitySearchViewController: CitySearchDelegate {
    
    func didSearchCities() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func didFailToSearchCities(error: Error?) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }

}

extension CitySearchViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.count > 2 {
            viewModel.searchCities(cityName: textField.text!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        } catch {
            return false
        }
        
        return true
    }
    
}

extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.places.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SearchedCityCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SearchedCityCell")
        }
        
        cell!.imageView?.image = UIImage(named: "recent")
        cell!.textLabel?.text = viewModel.places[indexPath.row].name
        cell!.detailTextLabel?.text = viewModel.places[indexPath.row].getAddress()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        self.delegate?.didSelectCity(place: self.viewModel.places[indexPath.row])
        self.dismiss(animated: true)
    }
    
}
