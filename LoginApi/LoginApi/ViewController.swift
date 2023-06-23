//
//  ViewController.swift
//  LoginApi
//
//  Created by Yogesh on 6/22/23.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = ViewControllerViewModel()
    
    let label : UILabel = {
        let l1 = UILabel()
        l1.text = "Login Page"
        l1.font = UIFont(name: "Arial", size: 15)
        return l1
    }()
    
    let userNametf : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter UserName"
        tf.textColor = .systemBlue
        return tf
    }()
    
    let passwordtf : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Password"
        tf.isSecureTextEntry = true
        tf.textColor = .systemBlue
        return tf
    }()
    
    let submitButton : UIButton = {
        let b = UIButton()
        b.backgroundColor = .gray
        b.setTitle("Submit", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        return b
    }()
    
    let stack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(userNametf)
        stack.addArrangedSubview(passwordtf)
        stack.addArrangedSubview(submitButton)
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stack)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
    @objc func submitButtonClicked(){
        print("Submit Clicked!")
        
        if self.userNametf.text != "" && self.passwordtf.text != ""{
            print(self.userNametf.text, self.passwordtf.text)
            viewModel.login(username: self.userNametf.text!, password: self.passwordtf.text!) { data in
                print("VC Data ", data)
                let decoder = JSONDecoder()
                let ans = try? decoder.decode(ResultModel.self, from: data!)
                print("Ans: ", ans!.Result)
                
                DispatchQueue.main.async {
                    if ans!.Result == "Login successful" {
                        let alert = UIAlertController(title: "Login Successfull", message: "You are Logged in !", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        let alert = UIAlertController(title: "Login Error !", message: "Invalid Details", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
            
        }
        else {
            let alert = UIAlertController(title: "Error !", message: "Invalid Login Details !!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}

