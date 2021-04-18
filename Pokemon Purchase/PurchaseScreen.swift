//
//  PurchaseScreen.swift
//  Pokemon Purchase
//
//  Created by William Jones on 4/17/21.
//

import UIKit

class PurchaseScreen: UIViewController {
    
    var balance: Float = 0.00
    var name: String = ""
    var price: Float = 0.00
    @IBOutlet weak var AccountBalance: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var PokemonPrice: UILabel!
    
    override func viewDidLoad() {
        print("PurchaseScreen.viewDidLoad()")
        super.viewDidLoad()
        
        AccountBalance.text = String(balance)
        pokemonName.text = name
        PokemonPrice.text = String(price)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("PurchaseScreen.buttonPressed() Go Back")
        // dismiss screen and go back to first screen
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func purchaseButtonPressed(_ sender: UIButton) {
        print("PurchaseScreen.buttonPressed() Purchase")
        alertUser(alertTitle: "Purchase Alert", alertMessage: "Pokekon purchase option is currently unavailable.")
    }
    
    fileprivate func alertUser(alertTitle: String, alertMessage: String) {
        // alert user of insufficient account balance
        let dialogMessage = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        // Create OK button action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("clicked ok button")
        })
        //Add OK button
        dialogMessage.addAction(ok)
        // display alert
        self.present(dialogMessage, animated: true, completion: nil)
    }

}

