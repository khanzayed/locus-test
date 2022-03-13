//
//  ForecastDetailsViewController.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import UIKit

class ForecastDetailsViewController: UIViewController, MainStoryboarded {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    
    var viewModel: ForecastDetailsViewControllerVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    deinit {
        print("Deinit called \(String(describing: ForecastDetailsViewController.self))")
    }

    private func setupUI() {
        self.title = viewModel.dayString
        
        lblCity.text = viewModel.city
        lblTemp.text = viewModel.temp
        lblWeather.text = viewModel.weather
        lblDate.text = viewModel.dateString
        
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

    static func initializeController(forecastData: ForecastData) -> ForecastDetailsViewController {
        let viewController = ForecastDetailsViewController.instantiate()
        viewController.viewModel = ForecastDetailsViewControllerVM(forecastData: forecastData)
        
        return viewController
    }
    
}
