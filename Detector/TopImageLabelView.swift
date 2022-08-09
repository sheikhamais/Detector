//
//  TopImageLabelView.swift
//  Detector
//
//  Created by Amais Sheikh	 on 01/08/2022.
//

import UIKit

class TopImageLabelView: UIView
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    var imageLabelStackView: UIStackView =
    {
        let obj = UIStackView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.axis = .vertical
        return obj
    }()
    
    var topImageView = UIImageView()
    var textLabel = UILabel()

    //------------------------------------------------------------
    //MARK:- Initializers
    //------------------------------------------------------------
    
    init(image: UIImage?,
         labelText: String          = "text",
         labelcolor: UIColor        = .white,
         labelLines: Int            = 1,
         font: UIFont               = .boldSystemFont(ofSize: 24),
         spacing: CGFloat           = 8)
    {
        self.topImageView.image = image?.withRenderingMode(.alwaysTemplate)
        self.textLabel.text = labelText
        self.textLabel.textColor = labelcolor
        self.textLabel.numberOfLines = labelLines
        self.textLabel.font = font
        
        self.imageLabelStackView.spacing = spacing
        
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------------------------------------------------------------
    //MARK:- Configuration Functions
    //------------------------------------------------------------
    
    private func configure()
    {
        //properties
        translatesAutoresizingMaskIntoConstraints = false
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints     = false
        textLabel.textAlignment = .center
        topImageView.contentMode = .scaleAspectFit
        
        //subviews
        addSubview(imageLabelStackView)
        imageLabelStackView.addArrangedSubview(topImageView)
        imageLabelStackView.addArrangedSubview(textLabel)
//        self.addSubview(leadingImageView)
//        self.addSubview(textLabel)
        
        //constraints
        NSLayoutConstraint.activate([
            
            topImageView.heightAnchor.constraint(equalToConstant: 24),
//            topImageView.widthAnchor.constraint(equalToConstant: 24),
            imageLabelStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageLabelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
//            leadingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            leadingImageView.topAnchor.constraint(equalTo: topAnchor),
            
            imageLabelStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            imageLabelStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
            
//            textLabel.topAnchor.constraint(equalTo: topAnchor),
//            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
//            textLabel.leadingAnchor.constraint(equalTo: leadingImageView.trailingAnchor, constant: spacing),
//            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
