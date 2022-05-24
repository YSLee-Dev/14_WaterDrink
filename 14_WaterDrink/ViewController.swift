//
//  ViewController.swift
//  14_WaterDrink
//
//  Created by 이윤수 on 2022/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    let cellID = "cellID"
    var alertList : [Alert] = []
    
    lazy var tableView : TableView =  {
        let table = TableView()
        table.tableView.delegate = self
        table.tableView.dataSource = self
        table.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cellID")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }

    func viewSet(){
        self.view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.97, alpha: 1.0)
        self.title = "물마시기"
        
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // self.alertList.count
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? TableViewCell else {return TableViewCell()}
        /*
        cell.mode.isOn = self.alertList[indexPath.row].isOn
        cell.apmLabel.text = self.alertList[indexPath.row].apm
        cell.timeLabel.text = self.alertList[indexPath.row].time
         */
        cell.mode.isOn = true
        cell.apmLabel.text = "AM"
        cell.delegate = self
        cell.timeLabel.text = "00:00"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "물 마실 시간"
        default:
            return nil
        }
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            return
        default:
            break
        }
    }
}

extension ViewController : ModeClick{
    func btnClick() {
        print("클릭")
    }
}
