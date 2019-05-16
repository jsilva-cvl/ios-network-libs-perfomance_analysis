//
//  NewVC.swift
//  iOSNetPerformance
//
//  Created by José Silva on 16/05/2019.
//  Copyright © 2019 Codavel. All rights reserved.
//

import UIKit
import Alamofire


class NewVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startTime = Date().timeIntervalSince1970 * 1000
        let URL:String = "http://porto.speedtest.net.zon.pt:8080/speedtest/random750x750.jpg"
        
        
        let emptyCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        URLCache.shared = emptyCache
        
        Alamofire.request(URL).responseData {
            (response) in
            if(response.error == nil) {
                print(response.error)
            }
            
            if let data = response.data {
                print(data.count)
                let stopTime = Date().timeIntervalSince1970 * 1000
                
                print(stopTime - startTime)
            }
        }
        
    }
}
