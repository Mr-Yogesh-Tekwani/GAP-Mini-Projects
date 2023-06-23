//
//  ViewController.swift
//  GetJournalDetails
//
//  Created by Yogesh on 6/23/23.
//

import UIKit

class ViewController: UIViewController {
    
    var tableViewModel = TableViewModel()
    var tableVC = TableViewController()
    var allDetails : [ResultModel] = []
    
    
    let label : UILabel = {
        let l1 = UILabel()
        l1.text = "Get Journal Details ! "
        l1.font = UIFont(name: "Arial", size: 15)
        return l1
    }()
    
    let userNametf : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter UserName"
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
        
        if userNametf.text != "" {
            tableViewModel.getDetails(username: userNametf.text!) { data in
                if let data = data {
                
                self.allDetails = data
                self.tableVC.allDetails = data
                
                DispatchQueue.main.async {
                    self.tableVC.tableView.reloadData()
                    self.navigationController?.pushViewController(self.tableVC, animated: true)
                }
                }
                else{
                    print("Error !")
                }
            }
        }
    }
    
}

