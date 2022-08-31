//
//  ViewController.swift
//  RESTAPIExample
//
//  Created by Salty Dog on 8/30/22.
//rod rigging 5/8 wire if they do that they are good rigging shop
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://timeapi.io/api/TimeZone/zone?timeZone=Europe/London"
        getData(from: url)
        
    }
    
    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("URLSession establishment FAILED")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print ("FAILED converting \(error.localizedDescription)")
            }
            guard let json = result else {
                print("JSON does not equal result")
                return
            }
            print("\nThe following is a printout of time in the hh:mm format. Time zone is set to London.")

            var jsonStr = json.currentLocalTime
            let jsonArr = Array(jsonStr)
            jsonStr = String(jsonArr[11..<16])
            print("\n" + jsonStr)
        })
            task.resume()
    }
}

struct Response: Codable {
    let timeZone: String
    let currentLocalTime: String
}

// RESULTS FORMAT = 2022-08-31T04:57:05.4995974
