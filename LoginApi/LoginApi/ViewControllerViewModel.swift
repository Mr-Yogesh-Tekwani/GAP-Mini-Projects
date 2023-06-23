//
//  ViewControllerViewModel.swift
//  LoginApi
//
//  Created by Yogesh on 6/22/23.
//

import Foundation

class ViewControllerViewModel {

func login(username: String, password: String, completionHandler: @escaping (Data?) -> ()){
    
    let url = URL(string: "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/UserLogin")
    
    var urlReq = URLRequest(url: url!)
    
    urlReq.httpMethod = "POST"
    
    let body = [
        "UserName" : username,
        "Password" : password
    ]
    
    let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
    
    urlReq.httpBody = bodyData
    urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
        
        if let data = data {
            print("Data: ", String(data: data, encoding: .utf8))
            completionHandler(data)
        }
        else{
            completionHandler(nil)
        }
        
        if let error = error {
            print(error.localizedDescription)
        }
        
    }
    task.resume()
    
}




}


