//
//  ViewController.swift
//  Pokemon Purchase
//
//  Created by William Jones on 4/17/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var checkPokemonBtn: UIButton!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var pokemonTxtFld: UITextField!
    var user: User?
    var pokemonInfo: Pokemon?
    
    override func viewDidLoad() {
        print("viewDidLoad()")
        super.viewDidLoad()
        
        // create a rounded button
        checkPokemonBtn.layer.cornerRadius = 15
                
        user = createUser()

    }
    
    @IBAction func checkPokemon(_ sender: Any) {
        print("checkPokemon()")
        // Check if text field is empty
        if let text = pokemonTxtFld.text, !text.isEmpty {
             // Text field is not empty
            getPokemon(pokemon: text)
        } else {
             // Text field is empty
            print("text field is empty")
        }
    }
    
    func getPokemon(pokemon: String) {
        print("getPokemon()")
        // set the base URL
        let theURL = "https://pokeapi.co/api/v2/pokemon/" + pokemon
        guard let url = URL(string: theURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        
            guard error == nil else {
                debugPrint(error.debugDescription)
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let json = jsonData as? [String: Any] else { return }
                    self.pokemonInfo = self.parsePokemon(json: json)
                    self.checkAffordability()
                                    
                } catch {
                    // The data couldn’t be read because it isn’t in the correct format.
                    debugPrint(error.localizedDescription)
                    self.alertUser(alertTitle: "Pokemon Search Alert", alertMessage: "Pokemon not found.  Please try again.")
                    return
                }
            }
            
            
        }
        task.resume()
    }
    
    func parsePokemon(json: [String: Any]) -> Pokemon {
        print("parsePokemon()")
        let name = json["name"] as? String ?? ""
        let baseExperience = json["base_experience"] as? Int ?? 0
        let pokemon = Pokemon(name: name, baseExperience: baseExperience)
        
        return pokemon

    }
    
    func createUser() -> User {
        print("createUser()")
        // user could be loaded a number of ways. Hardcoded for testing.
        
        //"user": {
        //  "name": "Your",
        //  "last": "Name",
        //  "accountNumber": 11133344556433443,
        //  "balance": 12.34,
        //  "email": "william@williamjones.info"
        //    }
        
        let aUser = User(name: "William", last: "Jones", accountNumber: 11133344556433443, balance: 12.34, email: "william@williamjones.info")
        
        
        firstNameLbl.text = aUser.name
        lastNameLbl.text = aUser.last
        emailLbl.text = aUser.email
        accountLbl.text = String(aUser.accountNumber)
        balanceLbl.text = String(aUser.balance)
        
        return aUser
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
    
    func checkAffordability() {
        print("checkAffordability()")
        
        if let balance = user?.balance, let price = pokemonInfo?.purchasePrice, let name = pokemonInfo?.name {
            if balance >= price {
                print("You have \(balance) and can afford \(name)  that costs \(price)")
                // goToSecondView
                performSegue(withIdentifier: "PurchaseScreen", sender: self)
            } else {
                alertUser(alertTitle: "Account Balance Alert", alertMessage: "Insufficient funds for purchase. Account balance is \(balance) and \(name) costs \(price)")
    
            }
        }

    }
    
    @IBAction func dismissKeyboardOnViewClickeds(_ sender: UIView) {
        print("dismissKeyboardOnViewClickeds()")
        pokemonTxtFld.endEditing(true)
    }
    
    @IBAction func dismissKeyboard(_ sender: UIButton) {
        print("dismissKeyboard()")
        pokemonTxtFld.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue()")
        
        if segue.identifier == "PurchaseScreen" {
            let destinationVC = segue.destination as! PurchaseScreen
            
            destinationVC.balance = user?.balance ?? 0.00
            destinationVC.name = pokemonInfo?.name ?? ""
            destinationVC.price = pokemonInfo?.purchasePrice ?? 0.00
        }
    }
}

