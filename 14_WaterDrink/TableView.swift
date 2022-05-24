//
//  TableView.swift
//  14_WaterDrink
//
//  Created by 이윤수 on 2022/05/24.
//

import UIKit

class TableView: UIView {
    
    var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.97, alpha: 1.0)
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
