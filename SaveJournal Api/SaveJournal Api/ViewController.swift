//
//  ViewController.swift
//  SaveJournal Api
//
//  Created by Yogesh on 6/23/23.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = ViewModel()
    
    let label : UILabel = {
        let l1 = UILabel()
        l1.text = "Add New Comment ! "
        l1.font = UIFont(name: "Arial", size: 15)
        return l1
    }()
    
    let userNametf : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter UserName"
        tf.textColor = .systemBlue
        return tf
    }()
    
    let chaptertf : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Chapter"
        tf.textColor = .systemBlue
        return tf
    }()
    
    
    let commenttf : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Comment"
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
        stack.addArrangedSubview(chaptertf)
        stack.addArrangedSubview(commenttf)
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
    
    @objc func submitButtonClicked() {
        if userNametf.text != "" && chaptertf.text != "" && commenttf.text != "" {
            viewModel.saveComment(username: userNametf.text!, chapter: chaptertf.text!, comment: commenttf.text!) { data in
                
                let decoder = JSONDecoder()
                let result = try? decoder.decode(ResultModel.self, from: data!)
                
                DispatchQueue.main.async {
                    
                    if result?.Result == "Success" {
                        let alert = UIAlertController(title: "Comment Saved", message: "Save Successfull !", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        let alert = UIAlertController(title: "Comment NOT Saved", message: "Save Error !", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    
    
}

