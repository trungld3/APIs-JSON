//
//  ViewController.swift
//  APIs & JSON
//
//  Created by TrungLD on 6/5/20.
//  Copyright © 2020 TrungLD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!

    
    
    @IBAction func SubmitPressed(_ sender: Any) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + "&appid=f873b69f162570e0d0e8fcbe299a3a1f"){
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                else {
                    if let urlContent = data{
                        do {
                              let jsonResult  = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                             print(jsonResult)
                            print(jsonResult["name"])
                            
                            if let description =  (( jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)? ["description"] as? String {
                                DispatchQueue.main.sync {
                                    self.labelWeather.text = description
                                    
                                }
                            }
                          
                          
                        }
                        catch {
                            print("JSON processing failed")
                           
                        }
                        
                       
                    }
                }
            }
            task.resume()
        } else {
            labelWeather.text = "couldn't find weather for that city - please try another"
        }
    }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        


}

}
