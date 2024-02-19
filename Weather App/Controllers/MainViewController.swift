//
//  ViewController.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import UIKit
import CoreLocation

//MARK: - MainViewController
final class MainViewController: UIViewController {

    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = itemsView as? UIView
    }
    
    private let manager: HelperManager
    
    init(manager: HelperManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var itemsView: ControllerOutputProtocol?
    //A Abstracted API class via Protocol.
    var itemsModel: ModelInputProtocol?
    
    var currentWeather: CurrentWeatherModel?
    var dailyWeather: DailyWeatherModel?
    var exactWeather: ExactWeatherModel?
    var geo: [PlaceType : String]?



    
    //MARK: - Private Property
    private var titles = [String]()
    
    //MARK: - Actions

}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dailyWeather?.daily.time.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomCell_TV.self), for: indexPath) as! CustomCell_TV
        cell.contentView.backgroundColor = #colorLiteral(red: 0.4297590852, green: 0.7995296121, blue: 0.906637311, alpha: 1)
        let weekDay = manager.getWeekDay(time: dailyWeather!.daily.time[indexPath.row])
        let image = UIImage(named: manager.getIconWeather(code: dailyWeather!.daily.weathercode[indexPath.row]))
        cell.configure(image: image,
                       weekday: weekDay,
                       maxTemp: dailyWeather?.daily.temperature_2m_max[indexPath.row],
                       minTemp: dailyWeather?.daily.temperature_2m_min[indexPath.row],
                       sunrise: manager.getHourAndMinutes(time: dailyWeather!.daily.sunrise[indexPath.row]),
                       sunSet: manager.getHourAndMinutes(time: dailyWeather!.daily.sunset[indexPath.row]),
                       maxWindSpeed: dailyWeather?.daily.windspeed_10m_max[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let padding: CGFloat = 3
        let maskLayer = CALayer()
        
        maskLayer.backgroundColor = UIColor.white.cgColor
        maskLayer.cornerRadius = 10
        
        maskLayer.frame = CGRect(x: padding,
                                 y: padding,
                                 width: cell.bounds.width - 2 * padding,
                                 height: cell.bounds.height - padding)
        cell.layer.mask = maskLayer
    }
}


//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = exactWeather?.hourly.time.count else { return 0 }
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:CustomCell_CV.self), for: indexPath) as! CustomCell_CV
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        if exactWeather?.hourly.isDay[indexPath.row + self.manager.getCurrentHour()]  == 1 {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.4297590852, green: 0.7995296121, blue: 0.906637311, alpha: 1)
        } else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }

        let image = UIImage(named: self.manager.getIconWeather(code: exactWeather!.hourly.weatherCode[indexPath.item + self.manager.getCurrentHour() ]))
        cell.configure(image: image,
                       temperature: "\(String(describing: exactWeather!.hourly.temperature2M[indexPath.item + self.manager.getCurrentHour() ]))",
                       hour: self.manager.getHourAndMinutes(time: exactWeather!.hourly.time[indexPath.item + self.manager.getCurrentHour() ]))
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3) // Отступы сверху и снизу
    }

}

//MARK: - Menu
extension MainViewController {
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        // [IndexPath] после iOS 16
        let configuration = UIContextMenuConfiguration(identifier: nil,
                                                       previewProvider:
                                                        {() -> UIViewController in
            let view = PreviewView()
            let controller = PreviewViewController(weather: self.exactWeather!,
                                                   index: indexPath.item + self.manager.getCurrentHour())
            controller.itemsView = view
            controller.itemsView?.controller = controller
            return controller  },
                                                       actionProvider:
                                                        {_ in
            let actiont = UIAction(title: "Close",image: UIImage(systemName: "xmark.circle"),
                                   attributes: .destructive)
            { _ in }
            let menu = UIMenu(title: "Detail View", options: .displayInline, children: [actiont])
            return menu
        }
        )
        return configuration
    }
}

//MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            guard let location = locations.first else { return }
            
            let serialQueue = DispatchQueue(label: "ru.nikita-shestakov.serial-queue", attributes: .concurrent)
            let group = DispatchGroup()
                        
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            let workItem4 = DispatchWorkItem {
                group.enter()
                self.itemsModel?.getNameOfPlace(lattitude: latitude, longitude: longitude, group: group)
            }
            
            let workItem1 = DispatchWorkItem {
                group.enter()
                self.itemsModel?.getCurrentWeather(lattitude: latitude, longitude: longitude, group: group)
            }
            
            let workItem2 = DispatchWorkItem {
                group.enter()
                self.itemsModel?.getDailyWeather(lattitude: latitude, longitude: longitude, group: group)
            }
            
            let workItem3 = DispatchWorkItem {
                group.enter()
                self.itemsModel?.getExactWeather(lattitude: latitude, longitude: longitude, group: group)
            }
            
            
            serialQueue.async(group: group, execute: workItem1)
            serialQueue.async(group: group, execute: workItem2)
            serialQueue.async(group: group, execute: workItem3)
            serialQueue.async(group: group, execute: workItem4)
            
            //group.wait()
            group.notify(queue: DispatchQueue.main) {
                DispatchQueue.main.async {
                    self.itemsView?.setupCurrentLocation()
                }
                DispatchQueue.main.async {
                    self.itemsView?.reloadTable()
                }
                DispatchQueue.main.async {
                    self.itemsView?.reloadCollection()
                }
                DispatchQueue.main.async {
                    self.itemsView?.setupAllData()
                }
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("location otkaz")
        }
}

//MARK: - ViewOutputProtocol
extension MainViewController: ViewOutputProtocol {
    
    func currentLocationCoordinates() {
        
            Location.shared.startLocationManager()
            Location.shared.localManager.delegate = self

        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                Location.shared.localManager.delegate = self
            }
        }
    }
}

//MARK: - ControllerInputProtocol
extension MainViewController: ControllerInputProtocol {
    
    func setGeodata(geo: [PlaceType : String]) {
        self.geo = geo
    }
    
    func onDailyWeatherRetrieval(weather: DailyWeatherModel) {
        
        self.dailyWeather = weather
    }
    
    func onExactWeatherRetrieval(weather: ExactWeatherModel) {
        self.exactWeather = weather
    }
    
    func onCurrentWeatherRetrieval(weather: CurrentWeatherModel) {
        self.currentWeather = weather
    }
}
