//
//  LeadingImageLabelView.swift
//  Detector
//
//  Created by Macbook on 27/07/2022.
//

import UIKit

class LeadingImageLabelView: UIView
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    var leadingImageView = UIImageView()
    var textLabel = UILabel()
    private var spacing: CGFloat
    
//    private var labelTrailingConstraint = NSLayoutConstraint()
//
//    private var imageHeightConstraint = NSLayoutConstraint()
//    private var imageWidthConstraint = NSLayoutConstraint()
//    var imageLeadingConstraint = NSLayoutConstraint()
//    private var imageTopConstraint = NSLayoutConstraint()
    
    //------------------------------------------------------------
    //MARK:- Initializers
    //------------------------------------------------------------
    
    init(imageName: String          = "placeholder",
         labelText: String          = "text",
         labelcolor: UIColor        = .black,
         labelLines: Int            = 1,
         font: UIFont               = .systemFont(ofSize: 12),
         spacing: CGFloat           = 8)
    {
        self.leadingImageView.image = UIImage(named: imageName)
        
        self.textLabel.text = labelText
        self.textLabel.textColor = labelcolor
        self.textLabel.numberOfLines = labelLines
        self.textLabel.font = font
        
        self.spacing = spacing
        
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
        leadingImageView.translatesAutoresizingMaskIntoConstraints = false
        leadingImageView.contentMode = .scaleAspectFit
        
        textLabel.translatesAutoresizingMaskIntoConstraints     = false
        
        //subviews
        self.addSubview(leadingImageView)
        self.addSubview(textLabel)
        
        //constraints
        NSLayoutConstraint.activate([
            
            leadingImageView.heightAnchor.constraint(equalToConstant: 24),
            leadingImageView.widthAnchor.constraint(equalToConstant: 24),
            leadingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leadingImageView.topAnchor.constraint(equalTo: topAnchor),
            
            leadingImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            leadingImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingImageView.trailingAnchor, constant: spacing),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func adjustImageSize(side: CGFloat)
    {
        for constraint in leadingImageView.constraints
        {
            if constraint.firstItem === leadingImageView,
               (constraint.firstAttribute == .height || constraint.firstAttribute == .width)
            {
                constraint.constant = side
            }
        }
        layoutIfNeeded()
    }
    
    func adjustImageToCenterY()
    {
        for constraint in constraints
        {
            if constraint.firstItem === leadingImageView,
               constraint.firstAttribute == .top
            {
                constraint.isActive = false
                break
            }
        }
        
        leadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        layoutIfNeeded()
    }
    
//    func configureItemsCenterHorizontally()
//    {
//        imageLeadingConstraint.isActive = false
//        labelTrailingConstraint.isActive = false
//
//        leadingImageView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -2).isActive = true
//
//        leadingImageView.layoutIfNeeded()
//    }
    
//    func configureItemsCenterHorizontallyInContainer(spacingInBetween: CGFloat, imageSide: CGFloat)
//    {
//        for constraint in constraints
//        {
//            if constraint.firstItem === leadingImageView || constraint.secondItem === leadingImageView || constraint.firstItem === textLabel || constraint.secondItem === textLabel
//            { constraint.isActive = false }
//        }
//
//        for constraint in leadingImageView.constraints
//        { constraint.isActive = false }
//
//        for constraint in textLabel.constraints
//        { constraint.isActive = false }
//
//        let contentContainer: UIView =
//            {
//                let obj = UIView()
//                obj.translatesAutoresizingMaskIntoConstraints = false
//                return obj
//            }()
//
//        addSubview(contentContainer)
//        contentContainer.addAllSubviews(leadingImageView,
//                                        textLabel)
//
//        NSLayoutConstraint.activate([
//
//            leadingImageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
//            leadingImageView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
//            leadingImageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
//            leadingImageView.heightAnchor.constraint(equalToConstant: imageSide),
//            leadingImageView.widthAnchor.constraint(equalToConstant: imageSide),
//
//            textLabel.leadingAnchor.constraint(equalTo: leadingImageView.trailingAnchor, constant: spacingInBetween),
//            textLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor),
//            textLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
//            textLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
//
//            contentContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
//            contentContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//
//        layoutIfNeeded()
//    }
    
//    func configureItemsToTrailingEnd()
//    {
//        imageLeadingConstraint.isActive = false
//        layoutIfNeeded()
//    }
    
//    func adjustImageLeadingConstantWithView(constant: CGFloat)
//    {
//        imageLeadingConstraint.constant = constant
//        layoutIfNeeded()
//    }
}
