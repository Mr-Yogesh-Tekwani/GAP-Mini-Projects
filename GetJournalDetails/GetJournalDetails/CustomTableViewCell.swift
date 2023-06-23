//
//  CustomTableViewCell.swift
//  GetJournalDetails
//
//  Created by Yogesh on 6/23/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {


    static let identifier = "CustomTableViewCell"
    var chapter = UILabel()
    var comment = UILabel()
    var date = UILabel()
   
    let stack : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        chapter.font = UIFont.boldSystemFont(ofSize: 17)
        comment.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        date.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .regular)
        
        stack.addArrangedSubview(chapter)
        stack.addArrangedSubview(comment)
        stack.addArrangedSubview(date)
        
        chapter.translatesAutoresizingMaskIntoConstraints = false
        comment.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            //stack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
