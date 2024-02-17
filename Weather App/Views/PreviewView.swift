//
//  PreviewView.swift
//  Weather App
//
//  Created by Nikita Shestakov on 06.02.2024.
//


import UIKit

class PreviewView: UIView {
    
    //MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .green
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Protocols
    var controller: PreviewViewOutputProtocol?

    
    //MARK: - Lazy properies
    
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
    lazy var windDirection: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var windGusts: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var uvIndex: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .green

        return label
    }()

    var isDay = [Int]?.self
    
    
    lazy var stack: UIStackView = {
       var stack = UIStackView()
        stack.layer.opacity = 0.9
        stack.layer.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        stack.layer.cornerRadius = 10
        
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowRadius = 7
        stack.layer.shadowOpacity = 0.4
        stack.layer.shadowOffset = CGSize(width: 15, height: 15)
        
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        return stack
    }()
}

private extension PreviewView {
    func setupUI() {
        self.backgroundColor = .systemMint
        addSubView()
        setupTableView()
        setupLayout()
    }
}


private extension PreviewView {
    
    func addSubView() {
        stack.addArrangedSubview(temparatureLabel)
        stack.addArrangedSubview(cloudcoverLabel)
        stack.addArrangedSubview(pressureLabel)
        stack.addArrangedSubview(windspeedLabel)
        stack.addArrangedSubview(windDirection)
        stack.addArrangedSubview(windGusts)
        stack.addArrangedSubview(uvIndex)


        

        self.addSubview(stack)
    }
    
    func setupTableView() {
        stack.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension PreviewView {
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),

        ])
    }
}

//MARK: - Protocol realization
extension PreviewView: PreviewControllerOutputProtocol {
    
    func setupAllData(currentWeatherDetail: ExactWeatherModel, index: Int) {
        
        temparatureLabel.text = "temperature \(currentWeatherDetail.hourly.temperature2M[index])"
        cloudcoverLabel.text = "cloudcover \(currentWeatherDetail.hourly.cloudCover[index])"
        pressureLabel.text = "pressuew \(currentWeatherDetail.hourly.surfacePressure[index])"
        windspeedLabel.text = "wind speed \(currentWeatherDetail.hourly.windSpeed10M[index])"
        windDirection.text = "wind direction \(currentWeatherDetail.hourly.windDirection10M[index])"
        windGusts.text = "wind gusts \(currentWeatherDetail.hourly.windGusts10M[index])"
        uvIndex.text = "UV index \(currentWeatherDetail.hourly.uvIndex[index])"
    }
}
