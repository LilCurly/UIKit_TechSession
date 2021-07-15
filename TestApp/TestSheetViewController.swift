//
//  TestSheetViewController.swift
//  TestApp
//
//  Created by Roman Muzikantov on 01/07/2021.
//

import UIKit

class TestSheetViewController: UIViewController {
    
    static let identifier = "TestSheetViewController"
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mConfirmButton: UIButton!
    
    weak var delegate: SecondViewControllerDelegate?
    
    var addedItems: [PurchasableModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mConfirmButton.configuration = .filled()
        mConfirmButton.configuration?.image = UIImage(systemName: "creditcard.fill")
        mConfirmButton.configuration?.title = "Payer"
        mConfirmButton.configuration?.buttonSize = .large
        mConfirmButton.configuration?.imagePlacement = .trailing
        mConfirmButton.configuration?.imagePadding = 20
        
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UINib(nibName: DeletableItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DeletableItemTableViewCell.identifier)
        
        view.backgroundColor = .white
    }
}

extension TestSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeletableItemTableViewCell.identifier, for: indexPath) as! DeletableItemTableViewCell
        cell.model = addedItems[indexPath.row]
        cell.setupCell()
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func addItem(model: PurchasableModel) {
        addedItems.append(model)
        
        mTableView.beginUpdates()
        mTableView.insertRows(at: [IndexPath(row: addedItems.count - 1, section: 0)], with: .automatic)
        mTableView.endUpdates()
    }
}

extension TestSheetViewController: DeletetableItemTableViewCellDelegate {
    func didRemoveItem(model: PurchasableModel) {
        mTableView.beginUpdates()
        for (index, modelFromList) in addedItems.enumerated() {
            if modelFromList.id == model.id {
                addedItems.remove(at: index)
                mTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        }
        mTableView.endUpdates()
        delegate?.didRemoveItem(model: model)
    }
}
