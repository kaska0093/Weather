//
//  MainView.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import UIKit

class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        
        //FIXME: should ne called there! But not 3 times)
        //getDataFromModel()
        controller?.currentLocationCoordinates()

        tableView.delegate = controller as? any UITableViewDelegate
        tableView.dataSource = controller as? any UITableViewDataSource
        
        collectionView.delegate = controller as? any UICollectionViewDelegate
        collectionView.dataSource = controller as? any UICollectionViewDataSource
    }
    
    //MARK: - Actions
    @objc func refreshData() {
        controller?.currentLocationCoordinates()
    }

    
    
    //MARK: - Protocols
    var controller: ViewOutputProtocol?
    let activityIndicator = UIActivityIndicatorView(style: .large)

    let refreshControl = UIRefreshControl()


    //MARK: - Lazy properies
    lazy var tableView: UITableView = {
        activityIndicator.color = .red
        activityIndicator.startAnimating()
        let tableView = UITableView()
        tableView.backgroundView = activityIndicator
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 0.82831949, green: 0.9516910911, blue: 0.9535943866, alpha: 1)
        tableView.separatorColor = .red
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 10
        
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.red.cgColor
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionViewLoyout = UICollectionViewFlowLayout()
        collectionViewLoyout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLoyout)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.backgroundColor = #colorLiteral(red: 0.82831949, green: 0.9516910911, blue: 0.9535943866, alpha: 1)
        collectionView.layer.cornerRadius = 10
        
        //collectionView.isPagingEnabled = true // остановка после каждой ячейки
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.red.cgColor
        return collectionView
    }()
    
    lazy var temparatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    lazy var cloudcoverLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var pressureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var windspeedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var weatherIconImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var weatherStack: UIStackView = {
       var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        stack.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        stack.layer.cornerRadius = 10

        return stack
    }()
    lazy var geoStack: UIStackView = {
       var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        stack.backgroundColor = . systemGray4
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        stack.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        stack.layer.cornerRadius = 10
        return stack
    }()
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var regionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var streetLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
}

//MARK: - Settings View
private extension MainView {
    // настройка superView
    
    func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.82831949, green: 0.9516910911, blue: 0.9535943866, alpha: 1)
        addSubView()
        addActions()
        setupCollections()
        setupLayout()
    }
}

//MARK: - Settings
private extension MainView {
    
    func addSubView() {
        
        weatherStack.addArrangedSubview(temparatureLabel)
        weatherStack.addArrangedSubview(cloudcoverLabel)
        weatherStack.addArrangedSubview(pressureLabel)
        weatherStack.addArrangedSubview(windspeedLabel)
        geoStack.addArrangedSubview(regionLabel)
        geoStack.addArrangedSubview(cityLabel)
        geoStack.addArrangedSubview(streetLabel)

        self.addSubview(weatherStack)
        self.addSubview(geoStack)

        self.addSubview(tableView)
        self.addSubview(collectionView)
        self.addSubview(weatherIconImage)
    }
    
    func addActions() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func setupCollections() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherStack.translatesAutoresizingMaskIntoConstraints = false
        geoStack.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CustomCell_CV.self, forCellWithReuseIdentifier: String(describing: CustomCell_CV.self))
        tableView.register(CustomCell_TV.self, forCellReuseIdentifier: String(describing: CustomCell_TV.self))
    }
}
//MARK: - Layout
private extension MainView {
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            weatherStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            weatherStack.trailingAnchor.constraint(equalTo: geoStack.leadingAnchor, constant: -20),
            weatherStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            geoStack.leadingAnchor.constraint(equalTo: weatherStack.trailingAnchor, constant: 20),
            geoStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            geoStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            collectionView.heightAnchor.constraint(equalToConstant: 106),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: weatherStack.bottomAnchor, constant: 20),
            
            
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            weatherIconImage.leadingAnchor.constraint(equalTo: weatherStack.trailingAnchor, constant: 20),
            weatherIconImage.widthAnchor.constraint(equalToConstant: 30),
            weatherIconImage.heightAnchor.constraint(equalToConstant: 30),
            weatherIconImage.topAnchor.constraint(equalTo: geoStack.bottomAnchor, constant: 10),
        ])
    }
}

//MARK: - ControllerOutputProtocol
extension MainView: ControllerOutputProtocol {
    
    func setupCurrentLocation() {
        
        if let geo = controller?.geo {
            regionLabel.text = geo[PlaceType.region]
            cityLabel.text = geo[PlaceType.city]
            streetLabel.text = geo[PlaceType.street]
        }
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func reloadTable() {
        tableView.reloadData()
        tableView.backgroundView = nil
        self.refreshControl.endRefreshing()
    }
    
    
    func setupAllData() {

        if let weather = controller?.currentWeather {
            temparatureLabel.text = "Temp \(String(describing: weather.current.temperature_2m)) ℃"
            cloudcoverLabel.text = "Cloud cover \(String(describing: weather.current.cloudcover)) %"
            pressureLabel.text = "Pressure \(String(describing: weather.current.pressure_msl)) kPa"
            windspeedLabel.text = "Wind speed \(String(describing: weather.current.windspeed_10m)) m/s"
            //FIXME: - HelperManager
            let image = UIImage(named: HelperManager().getIconWeather(code: weather.current.weathercode))
            weatherIconImage.image = image
        }
    }
}

