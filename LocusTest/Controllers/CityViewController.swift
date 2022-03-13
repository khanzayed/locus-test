//
//  ViewController.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var textCityName: UITextField!
    @IBOutlet weak var btnLookup: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CityViewControllerVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CityViewControllerVM(forecastClient: ForecastNetworkClient(), delegate: self)
        
        setupUI()
    }
    
    private func setupUI() {
        textCityName.delegate = self
        
        btnLookup.layer.borderWidth = 1.0
        btnLookup.layer.borderColor = UIColor.gray.cgColor
        btnLookup.layer.cornerRadius = 4.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cityName = ""
        tableView.reloadData()
    }

    @IBAction func lookupTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        lblError.text = ""
        
        let searchedText = (textCityName.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if searchedText.isEmpty {
            updateErrorLabel(message: "Enter city name to proceed.")
            
            return
        }
        
        activityIndicator.startAnimating()
        btnLookup.isUserInteractionEnabled = false
        textCityName.isUserInteractionEnabled = false
        viewModel.getForecastData(searchedText: searchedText)
    }
    
    fileprivate func updateErrorLabel(message: String) {
        lblError.text = message
//        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alertVC.addAction(okAction)
//
//        DispatchQueue.main.async {
//            self.navigationController?.present(alertVC, animated: true, completion: nil)
//        }
    }
    
}

extension CityViewController: CityViewControllerVMDelegate {
    
    func didLoadForecastData() {
        let viewController = ForecastListViewController.initializeController(forecast: self.viewModel.forecast!)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.btnLookup.isUserInteractionEnabled = true
            self.textCityName.isUserInteractionEnabled = true
            self.textCityName.text = ""
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func didFailedToLoadForecastData(message: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.btnLookup.isUserInteractionEnabled = true
            self.textCityName.isUserInteractionEnabled = true
        }
        
        updateErrorLabel(message: message)
    }
    
}

extension CityViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateErrorLabel(message: "")
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

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SearchedCityCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "SearchedCityCell")
        }
        
        cell!.imageView?.image = UIImage(named: "recent")
        cell!.textLabel?.text = viewModel.searchedCities[indexPath.row].name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        updateErrorLabel(message: "")
        
        self.activityIndicator.startAnimating()
        self.viewModel.fetchWeatherForecastFromCoordinates(data: viewModel.searchedCities[indexPath.row])
    }
    
}
