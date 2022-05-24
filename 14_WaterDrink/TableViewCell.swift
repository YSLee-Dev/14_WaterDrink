//
//  TableViewCell.swift
//  14_WaterDrink
//
//  Created by 이윤수 on 2022/05/24.
//

import UIKit

protocol ModeClick{
    func btnClick()
}

class TableViewCell: UITableViewCell {
    
    let cellID = "cellID"
    
    var alarmImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "timer")
        img.tintColor = UIColor.black
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var apmLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mode : UISwitch = {
        let mode = UISwitch()
        mode.translatesAutoresizingMaskIntoConstraints = false
        mode.addTarget(self, action: #selector(btnClick(_:)), for: .valueChanged)
        return mode
    }()
    
    var delegate : ModeClick?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(){
        self.backgroundColor = .white
        
        self.addSubview(alarmImg)
        self.addSubview(apmLabel)
        self.addSubview(timeLabel)
        self.addSubview(mode)
        
        NSLayoutConstraint.activate([
            self.alarmImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.alarmImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.alarmImg.widthAnchor.constraint(equalToConstant: 30),
            self.alarmImg.heightAnchor.constraint(equalToConstant: 30),
            
            self.apmLabel.leadingAnchor.constraint(equalTo: self.alarmImg.trailingAnchor, constant: 10),
            self.apmLabel.bottomAnchor.constraint(equalTo: self.alarmImg.bottomAnchor),
            
            self.timeLabel.leadingAnchor.constraint(equalTo: self.apmLabel.trailingAnchor, constant: 5),
            self.timeLabel.centerYAnchor.constraint(equalTo: self.alarmImg.centerYAnchor),
            
            self.mode.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.mode.centerYAnchor.constraint(equalTo: self.alarmImg.centerYAnchor)
        ])
    }
    
    @objc func btnClick(_ sender:Any){
        self.delegate?.btnClick()
    }
}
