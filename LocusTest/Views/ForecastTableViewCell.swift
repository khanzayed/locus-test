//
//  ForecastTableViewCell.swift
//  LocusTest
//
//  Created by Faraz Habib on 11/3/2022.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    var viewModel: ForecastTableViewCellVM! {
        didSet {
            //Update UI
            DispatchQueue.main.async {
                self.lblDay.text = self.viewModel.day
                self.lblDate.text = self.viewModel.dateString
                self.lblWeather.text = self.viewModel.weather
                self.lblTemperature.text = self.viewModel.temp
                self.imageViewWeather.image = nil
            }
            
            self.viewModel.downloadImage { [weak self] data in
                DispatchQueue.main.async {
                    self?.imageViewWeather.image = (data != nil) ? UIImage(data: data!) : nil
                }
            }
        }
    }
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    
}
