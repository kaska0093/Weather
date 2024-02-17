//
//  CustomCell_TV.swift
//  Weather App
//
//  Created by Nikita Shestakov on 04.02.2024.
//

import UIKit

final class CustomCell_TV: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialization()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageViewIcon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private let weekdayLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    private let maxTempLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    private let minTempLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    private let sunriseLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    private let sunsetLabel: UILabel = {
        let label = UILabel()
 
        return label
    }()
    
    func getAttributedString(systemName: String) -> NSAttributedString {
        let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: systemName, withConfiguration: configuration)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        return imageString
    }
    private let maxwindLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    func configure(image: UIImage?, weekday: String?, maxTemp: Double?, minTemp: Double?, sunrise: String?, sunSet: String?, maxWindSpeed: Double?) {
        imageViewIcon.image = image
        weekdayLabel.text = weekday
        
        if let maxTemp {
            let fullString = NSMutableAttributedString(string: String(maxTemp) + "℃")
            fullString.insert(getAttributedString(systemName: "thermometer.high"), at: 0)
            maxTempLabel.attributedText = fullString
        }
        if let minTemp {
            let fullString = NSMutableAttributedString(string: String(minTemp) + "℃")
            fullString.insert(getAttributedString(systemName: "thermometer.low"), at: 0)
            minTempLabel.attributedText = fullString
        }
        
        if let sunrise {
            let fullString = NSMutableAttributedString(string: sunrise)
            fullString.insert(getAttributedString(systemName: "sunrise"), at: 0)

            sunriseLabel.attributedText = fullString
        }
        if let sunSet {
            let fullString = NSMutableAttributedString(string: sunSet)
            //fullString.append(getAttributedString(systemName: "sunset"))
            fullString.insert(getAttributedString(systemName: "sunset"), at: 0)
            
            sunsetLabel.attributedText = fullString
        }

        if let max = maxWindSpeed {
            maxwindLabel.text = "\(max) m/s"
        }
    }
    private func initialization() {
        let array: [UIView] = [imageViewIcon,weekdayLabel, maxwindLabel, maxTempLabel, minTempLabel, sunsetLabel, sunriseLabel]
        for view in array {
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            
            imageViewIcon.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            imageViewIcon.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            imageViewIcon.widthAnchor.constraint(equalToConstant: 50),
            imageViewIcon.heightAnchor.constraint(equalToConstant: 50),
            
            maxwindLabel.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: 10),
            maxwindLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            maxTempLabel.trailingAnchor.constraint(equalTo: sunriseLabel.leadingAnchor, constant: -10),
            maxTempLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),

            minTempLabel.trailingAnchor.constraint(equalTo: sunsetLabel.leadingAnchor, constant: -10),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),

            weekdayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            weekdayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            weekdayLabel.widthAnchor.constraint(equalToConstant: 40),
            
            
            sunriseLabel.trailingAnchor.constraint(equalTo: weekdayLabel.leadingAnchor, constant: -5),
            sunriseLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            sunsetLabel.trailingAnchor.constraint(equalTo: weekdayLabel.leadingAnchor, constant: -5),
            sunsetLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}
