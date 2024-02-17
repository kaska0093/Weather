//
//  PreviewViewController.swift
//  Weather App
//
//  Created by Nikita Shestakov on 06.02.2024.
//

import UIKit
//import Charts


final class PreviewViewController: UIViewController, PreviewViewOutputProtocol {
    
    var currentWeather: ExactWeatherModel?
    var index: Int?
    var itemsView: PreviewControllerOutputProtocol?

    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = itemsView as? UIView
        self.preferredContentSize = CGSize(width: 300, height: 230)
        self.itemsView?.setupAllData(currentWeatherDetail: currentWeather!, index: index!)
    }
    
    init(itemsView: PreviewControllerOutputProtocol? = nil, weather: ExactWeatherModel, index: Int) {
        super.init(nibName: nil, bundle: nil)

        self.currentWeather = weather
        self.itemsView = itemsView
        self.index = index

    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
