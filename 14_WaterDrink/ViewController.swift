//
//  ViewController.swift
//  14_WaterDrink
//
//  Created by 이윤수 on 2022/05/24.
//

import UIKit
import UserNotifications

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
    
    var userNoti = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertList = alertListLoading()
        viewSet()
    }

    func viewSet(){
        self.view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.97, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barBtnClick(_:)))
        
        self.title = "물마시기"
        
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    @objc func barBtnClick(_ sender:Any){
        let add = AddAlarmViewController()
        add.delegate = self
        self.navigationController?.pushViewController(add, animated: true)
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       self.alertList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? TableViewCell else {return TableViewCell()}
        cell.modeLabel.text = String(self.alertList[indexPath.row].isOn)
        cell.apmLabel.text = self.alertList[indexPath.row].apm
        cell.timeLabel.text = self.alertList[indexPath.row].time
        
        if !self.alertList[indexPath.row].isOn {
            cell.backgroundColor = .gray
        }else{
            cell.backgroundColor = .white
        }
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
    
    func alertListLoading() -> [Alert]{
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data, let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else {return []}
        return alerts
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
            self.userNoti.removePendingNotificationRequests(withIdentifiers: [self.alertList[indexPath.row].id])
            self.alertList.remove(at: indexPath.row)
            self.tableView.tableView.deleteRows(at: [indexPath], with: .right)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alertList), forKey: "alerts")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.alertList[indexPath.row].isOn = !self.alertList[indexPath.row].isOn
        self.tableView.tableView.reloadRows(at: [indexPath], with: .right)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alertList), forKey: "alerts")
        
        if self.alertList[indexPath.row].isOn{
            self.userNoti.addNofi(alert: self.alertList[indexPath.row])
        }else {
            self.userNoti.removePendingNotificationRequests(withIdentifiers: [self.alertList[indexPath.row].id])
        }
    }
}

extension ViewController : AddAlarm{
    func okBtnClick(text: String, date: Date) {
        var alertList = self.alertListLoading()
        let newAlert = Alert(date: date, isOn: true, msg: text)
        
        alertList.append(newAlert)
        alertList.sort{
            $0.date < $1.date
        }
        self.alertList = alertList
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alertList), forKey: "alerts")
        
        // 노티 추가
        self.userNoti.addNofi(alert: newAlert)
        
        self.tableView.tableView.reloadData()
    }
}
