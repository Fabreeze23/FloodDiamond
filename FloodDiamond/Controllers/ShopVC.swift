//
//  SecondViewController.swift
//  FloodDiamond
//
//  Created by Fabrice Mulumba on 7/7/18.
//  Copyright © 2018 Fabrice Mulumba. All rights reserved.
//
// Shop will be a tableview with a button for buying.
// https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
// Receives data from GET request of diamonds


import UIKit

class ShopVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var diamond: Diamond!
    var diamonds = [Diamond]() //Placeholder for array of diamonds
    var user: User!
    
    var receiptDict: NSDictionary = ["first": 1]

    @IBOutlet weak var loadDiamondButton: UIButton!
    

    
    @IBOutlet weak var diamondSelector: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDiamondButton.layer.cornerRadius = 10

        tableView.delegate = self
        tableView.dataSource = self
        print(user)
        print(user.userId)
        
        
        
        //self.tableView.tableFooterView = UIView(frame: CGRect.zero)
       
        //getDiamondData()
        //Will make the get request in here
        
    
        /*
        guard let diamondsURL = URL(string: GET_DIAMONDS_URL) else { return }
                    
            URLSession.shared.dataTask(with: diamondsURL) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                //Implement JSON decoding and parsing
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    let diamondData = try JSONDecoder().decode([Diamond].self, from: data)
                    
                    //Get back to the main queue
                    DispatchQueue.main.async {
                        print(diamondData)
                        self.diamonds = diamondData
                        self.tableView.reloadData() //Need this
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
            
            }.resume()
        //End implementing URLSession
        
        */
        
        
    }
    
    /*
    func getDiamondData() {
        
        let diamondsURL = URL(string: "http://192.168.1.246:8080/GetDiamonds")
        
        let task = URLSession.shared.dataTask(with: diamondsURL!) { [unowned self] (data, response, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))") // 5
                return
            }
            do {
                let diamondData = try JSONDecoder().decode([Diamond].self, from: data)
                self.diamonds = diamondData
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Error is : \n\(error)")
            }
            }
        
            task.resume()
    }
*/
    
    @IBAction func loadDiamondsTapped(_ sender: Any) {
        
        let diamondsURL = URL(string: GET_DIAMONDS_URL)
        
        let task = URLSession.shared.dataTask(with: diamondsURL!) { [unowned self] (data, response, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))") // 5
                return
            }
            do {
                let diamondData = try JSONDecoder().decode([Diamond].self, from: data)
                self.diamonds = diamondData
                
                DispatchQueue.main.async { [unowned self] in
                    //self.tableView.delegate = self
                    //self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Error is : \n\(error)")
            }
            
        }
        
        task.resume()
    }
        
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        
        print(diamonds.count)
        
        return diamonds.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        diamond = diamonds[indexPath.row] 
        print(diamond.name)
        
        diamondSelector.text = diamond.name
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "diamondCell") as? DiamondCell {
            
            
            cell.configureCell(diamond: diamond)
            
            
            return cell
            
        } else {
            return DiamondCell()
        }
        
    }
    
    // When buyButtonTapped is tapped, sned post request 
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        /*
         if segue.identifier == "buttonToReceipt" {
         if let receiptVC = segue.destination as? ReceiptVC {
         receiptVC.diamondIDString = diamond._id
         receiptVC.supplierIDString = diamond.supplierId
         }
         }
        
        print("Help")
 */
        
        if segue.identifier == "buttonToReceipt" {
            print("Check")

                if let receiptVC = segue.destination as? ReceiptVC {
                    print("We good")
                    receiptVC.diamondIDString = diamond._id
                    receiptVC.supplierIDString = diamond.supplierId
                    receiptVC.diamondPrice = String(diamond.price)
                    receiptVC.diamondName = diamond.name
                    receiptVC.nameOfUser = user.username
                    
                    let buy = Buy(userId: user.userId, supplierId: diamond.supplierId, diamondId: diamond._id)
                    
                    let buyURL = URL(string: POST_BUY_URL)
                    
                    var request = URLRequest(url: buyURL!)
                    request.httpMethod = "POST"
                    // Make sure that we include headers specifying that our request's HTTP body
                    // will be JSON encoded
                    var headers = request.allHTTPHeaderFields ?? [:]
                    headers["Content-Type"] = "application/json"
                    request.allHTTPHeaderFields = headers
                    
                    let encoder = JSONEncoder()
                    do {
                        let buyData = try encoder.encode(buy)
                        // ... and set our request's HTTP body
                        request.httpBody = buyData
                        if (balance < diamond.price) {
                            self.showBuyingFailedAlert()
                            print("Not enough money")
                        }
                        balance -= diamond.price //Subtract balance from the price of the diamond
                        
                        print("buyData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
                        
                    } catch {
                        print("Error")
                    }
                    /*
                    
                    // Create and run a URLSession data task with our JSON encoded POST request
                    let config = URLSessionConfiguration.default
                    let session = URLSession(configuration: config)
                    let task = session.dataTask(with: request) { (responseData, response, responseError) in
                        guard responseError == nil else {
                            return
                        }
                        
                        if let jsonObj = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) as? NSDictionary {
                            
                            
                            //printing the json in console
                            //print(jsonObj!.value(forKey: "userId")!)
                            print(jsonObj!)
                            
                            print("This is your receipt data")
                            
                            self.receiptDict = jsonObj!
                            print(self.receiptDict)
                        }
                            
                        else {
                            print("No receipt data")
                        }
                        
                    }
                    
                    task.resume()
                    
                        */
                    
                }
            
        }
    }

    private func showBuyingFailedAlert() {
        let alertView = UIAlertController(title: "Buying Failed",
                                          message: "Insufficient funds",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Please check your account", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }

}

