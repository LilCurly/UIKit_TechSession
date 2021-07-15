//
//  DeletableItemTableViewCell.swift
//  TestApp
//
//  Created by Roman Muzikantov on 14/07/2021.
//

import UIKit

protocol DeletetableItemTableViewCellDelegate: class {
    func didRemoveItem(model: PurchasableModel)
}

class DeletableItemTableViewCell: UITableViewCell {
    
    static let identifier = "DeletableItemTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var removeImage: UIImageView!
    
    var model: PurchasableModel?
    
    weak var delegate: DeletetableItemTableViewCellDelegate?
    
    func setupCell() {
        nameLabel.text = "\(model!.name)"
        
        removeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRemove(_:))))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        /*removeImage.preferredImageVariantFill = .filled
        removeImage.preferredImageVariantShape = .circle
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .systemRed)
        removeImage.image = UIImage(systemName: "trash", withConfiguration: config)*/
        removeImage.image = UIImage(systemName: "trash")
        removeImage.isUserInteractionEnabled = true
    }
    
    @objc func didTapRemove(_ sender: Any) {
        delegate?.didRemoveItem(model: model!)
    }
}
