//
//  ResultView.swift
//  JU Quiz
//
//  Created by hawkar on 2020-11-16.
//

import UIKit

class ResultView: UIView {

    private let titleLabel = UILabel()
    let resultLabel = UILabel()
    let homeButton =  UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = NSLocalizedString("Your Result", comment: "Result title")
        addSubview(titleLabel)
    
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        resultLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        resultLabel.adjustsFontForContentSizeCategory = true
        addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        resultLabel.lineBreakMode = .byWordWrapping
        resultLabel.numberOfLines = 0
    
        let imageView = UIImageView(image: #imageLiteral(resourceName: "resultBoard"))
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: resultLabel.topAnchor, constant: 70).isActive = true
        imageView.centerXAnchor.constraint(equalTo: resultLabel.centerXAnchor).isActive = true
    
        
        homeButton.setTitleColor(.systemGray, for: .normal)
        homeButton.setTitle(NSLocalizedString("Return to Start", comment: "Result button title"), for: .normal)
        addSubview(homeButton)
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        homeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}

