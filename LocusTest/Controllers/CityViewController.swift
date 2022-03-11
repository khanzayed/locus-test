//
//  ViewController.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var btnLookup: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: CityViewControllerVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CityViewControllerVM(forecastClient: ForecastNetworkClient(), delegate: self)
    }
    
    private func setupUI() {
        lblCityName.text = "City"
    }

    @IBAction func lookupTapped(_ sender: UIButton) {
        activityIndicator.startAnimating()
        viewModel.getForecastData(cityName: "london")
    }
    
}

extension CityViewController: CityViewControllerVMDelegate {
    
    func didLoadForecastData() {
        let viewController = ForecastListViewController.initializeController(forecast: self.viewModel.forecast!)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func didFailedToLoadForecastData() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        
        let alertVC = UIAlertController(title: "Error", message: "Failed to fetch forecast details.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
    
}
