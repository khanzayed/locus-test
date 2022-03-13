//
//  ForecastListViewController.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import UIKit

class ForecastListViewController: UIViewController, MainStoryboarded {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ForecastListViewControllerVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        self.title = "Hourly Forecast"
        
        lblCity.text = viewModel.city
        lblTemp.text = viewModel.temp
        lblWeather.text = viewModel.weather
        
        lblHumidity.text = viewModel.humidity
        lblPressure.text = viewModel.pressure
        lblWind.text = viewModel.windSpeed
        
        if let imageName = viewModel.weatherImageName {
            viewModel.downloadImage(imageName: imageName) { [weak self] data in
                guard let this = self else { return }
                
                DispatchQueue.main.async {
                    if let data = data {
                        this.imageViewWeather.image = UIImage(data: data)
                    } else {
                        this.imageViewWeather.image = nil
                    }
                }
            }
        }
    }
    
    deinit {
        print("Deinit called \(String(describing: ForecastListViewController.self))")
    }
    
    static func initializeController(forecast: Forecast) -> ForecastListViewController {
        let viewController = ForecastListViewController.instantiate()
        viewController.viewModel = ForecastListViewControllerVM(forecast: forecast)
        
        return viewController
    }
    
}

extension ForecastListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecast.hourly?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell") as! ForecastTableViewCell
        cell.viewModel = ForecastTableViewCellVM(forcastData: viewModel.forecast.hourly![indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let viewController = ForecastDetailsViewController.initializeController(forecastData: viewModel.forecast.hourly![indexPath.row])
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
