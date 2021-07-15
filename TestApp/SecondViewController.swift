//
//  SecondViewController.swift
//  TestApp
//
//  Created by Roman Muzikantov on 01/07/2021.
//

import UIKit


import CoreLocationUI

protocol SecondViewControllerDelegate: class {
    func didRemoveItem(model: PurchasableModel)
}

class SecondViewController: UIViewController {
    
    static let identifier = "SecondViewController"
    
    @IBOutlet weak var mPurchaseButton: UIButton!
    @IBOutlet weak var mTableView: UITableView!
    
    weak var sheet: TestSheetViewController?
    
    var addedItems: [PurchasableModel] = [] {
        didSet {
            updatePurchaseButton()
        }
    }
    
    var currentHighestId = 0
    
    private func updatePurchaseButton() {
        var total: Float = 0
        
        for item in addedItems {
            total = total + item.price
        }
        
        mPurchaseButton.setTitle("\(total)€", for: .normal)
    }
    
    let items: [PurchasableModel] = [PurchasableModel(itemType: .bacon, price: 0.5, name: "Bacon"), PurchasableModel(itemType: .bum, price: 0.3, name: "Pain"), PurchasableModel(itemType: .cheese, price: 0.7, name: "Fromage"), PurchasableModel(itemType: .cucumber, price: 0.3, name: "Concombre"), PurchasableModel(itemType: .meat, price: 1.5, name: "Viande"),PurchasableModel(itemType: .onions, price: 0.4, name: "Oignons"), PurchasableModel(itemType: .pickles, price: 0.6, name: "Cornichon"), PurchasableModel(itemType: .tomato, price: 0.3, name: "Tomate")]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UINib(nibName: PurchasableItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PurchasableItemTableViewCell.identifier)
        
        /*mPurchaseButton.configuration = .tinted()
        let cartConfig = UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue)
        mPurchaseButton.configuration?.image = UIImage(systemName: "cart.fill", withConfiguration: cartConfig)
        mPurchaseButton.configuration?.imagePlacement = .leading
        mPurchaseButton.configuration?.imagePadding = 15*/
        
        updatePurchaseButton()
    }

    @IBAction func didTapCartButton(_ sender: Any) {
        let viewContoller = self.storyboard?.instantiateViewController(withIdentifier: TestSheetViewController.identifier) as! TestSheetViewController
        viewContoller.modalPresentationStyle = .popover
        if let pop = viewContoller.popoverPresentationController {
            let sheet = pop.adaptiveSheetPresentationController
            sheet.detents = [.medium(), .large()]
            sheet.smallestUndimmedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
        }
        
        sheet = viewContoller
        
        present(viewContoller, animated: true, completion: nil)
        
        viewContoller.addedItems = addedItems
        viewContoller.delegate = self
    }
}

extension SecondViewController: SecondViewControllerDelegate {
    func didRemoveItem(model: PurchasableModel) {
        addedItems.removeAll { modelFromList in
            modelFromList.id == model.id
        }
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchasableItemTableViewCell.identifier, for: indexPath) as! PurchasableItemTableViewCell
        cell.model = items[indexPath.row]
        cell.setupCell()
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

extension SecondViewController: PurchasableItemTableViewCellDelegate {
    func didAddItem(model: PurchasableModel) {
        let newModel = PurchasableModel(itemType: model.itemType, price: model.price, name: model.name)
        newModel.id = currentHighestId
        currentHighestId = currentHighestId + 1
        addedItems.append(newModel)
        
        if let sheet = sheet {
            sheet.addItem(model: newModel)
        }
    }
}
