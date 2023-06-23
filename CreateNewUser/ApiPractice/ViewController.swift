//
//  ViewController.swift
//  ApiPractice
//
//  Created by Yogesh on 6/22/23.
//

import UIKit

class ViewController: UIViewController {
    
    let label : UILabel = {
        let l1 = UILabel()
        l1.text = "Create New User"
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
        if userNametf.text != "" && passwordtf.text != ""{
            print(userNametf.text, passwordtf.text)
            createNewUser(username: userNametf.text!, password: passwordtf.text!){ data in
                let decoder = JSONDecoder()
                let ans = try? decoder.decode(ResultModel.self, from: data!)
                
                DispatchQueue.main.async {
                    if ans!.Result == "Success"{
                let alert = UIAlertController(title: "User Created !", message: "\(ans!.Result)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        let alert = UIAlertController(title: "Result !", message: "\(ans!.Result)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Error !", message: "Please Enter Data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}

