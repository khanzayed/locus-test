//
//  CitySearchListViewController.swift
//  LocusTest
//
//  Created by Faraz Habib on 3/5/2023.
//

import UIKit

class CityListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSearchCity: UIButton!
    
    private var viewModel: CityListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CityListViewControllerVM(forecastClient: ForecastNetworkClient(),
                                             delegate: self)
    }

    @IBAction func searchCityButtonTapped(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let citySearchVC = storyboard.instantiateViewController(withIdentifier: "CitySearchViewController") as? CitySearchViewController else { return }
        citySearchVC.delegate = self
        self.navigationController?.present(citySearchVC, animated: true)
    }
    
}

extension CityListViewController: CityControllerDelegate {
    
    func didSelectCity(place: City) {
        guard let cityName = place.name else {
            // Handle error
            return
        }
        
        viewModel.getForecastData(searchedText: cityName)
    }
    
}

extension CityListViewController: CityListWeatherDelegate {
    
    func didLoadForecastData() {
        let viewController = ForecastListViewController.initializeController(forecast: self.viewModel.forecast!)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func didFailedToLoadForecastData(message: String) {
        // Handle error
    }
    
    
}

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CityCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "CityCell")
        }
        cell!.imageView?.image = UIImage(named: "recent")
        cell!.textLabel?.text = viewModel.searchedCities[indexPath.row].name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
