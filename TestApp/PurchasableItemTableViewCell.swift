//
//  PurchasableItemTableViewCell.swift
//  TestApp
//
//  Created by Roman Muzikantov on 14/07/2021.
//

import UIKit

protocol PurchasableItemTableViewCellDelegate: class {
    func didAddItem(model: PurchasableModel)
}

class PurchasableItemTableViewCell: UITableViewCell {
    
    static let identifier = "PurchasableItemTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var healthyLabel: UILabel!
    @IBOutlet weak var addImageView: UIImageView!
    
    var delegate: PurchasableItemTableViewCellDelegate?
    
    var model: PurchasableModel?
    
    func setupCell() {
        nameLabel.text = "\(model!.name) - \(model!.price)€"
        
        addImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAddImage(_:))))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /*let colorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .systemGreen)
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 200, weight: .bold, scale: .large)
        let config = sizeConfig.applying(colorConfig)
        let healthyImage = UIImage(systemName: "cross.circle.fill", withConfiguration: config)
        
        let attachment = NSTextAttachment(image: healthyImage!)
        let attachmentString = NSMutableAttributedString(attachment: attachment)*/
        let attachmentString = NSMutableAttributedString("")
        attachmentString.append(NSAttributedString(" Très sain"))
        healthyLabel.attributedText = attachmentString
        healthyLabel.textColor = .systemGreen
        
        /*addImageView.preferredImageVariantShape = .circle
        addImageView.preferredImageVariantFill = .filled
        let addConfig = UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue)
        addImageView.image = UIImage(systemName: "plus", withConfiguration: addConfig)*/
        
        addImageView.image = UIImage(systemName: "plus")
        addImageView.isUserInteractionEnabled = true
    }
    
    @objc func didTapAddImage(_ sender: Any) {
        delegate?.didAddItem(model: model!)
    }
}
