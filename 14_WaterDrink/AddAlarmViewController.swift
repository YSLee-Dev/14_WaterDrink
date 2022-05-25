//
//  AddAlarmViewController.swift
//  14_WaterDrink
//
//  Created by 이윤수 on 2022/05/25.
//

import UIKit

protocol AddAlarm{
    func okBtnClick(text: String, date:Date)
}

class AddAlarmViewController : UIViewController{
    
    lazy var msgTextView : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.font = UIFont.boldSystemFont(ofSize: 28)
        tv.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.38, alpha: 1.0)
        tv.text = "알림과 함께 받을\n메세지를 적어보세요.\n😊"
        tv.delegate = self
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 15
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        return tv
    }()
    
    var dataPicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko")
        picker.layer.cornerRadius = 15
        picker.layer.masksToBounds = true
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var okBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("확인", for: .normal)
        btn.backgroundColor = UIColor(hue: 0.5639, saturation: 0.42, brightness: 1, alpha: 1.0)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(okBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var margin = self.navigationController?.systemMinimumLayoutMargins.leading
    var delegate : AddAlarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.97, alpha: 1.0)
        self.title = "알람설정"
        viewSet()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func viewSet(){
        self.view.addSubview(self.msgTextView)
        self.view.addSubview(self.dataPicker)
        self.view.addSubview(self.okBtn)
        
        NSLayoutConstraint.activate([
            self.msgTextView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.msgTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin ?? 10),
            self.msgTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -(margin ?? 10)),
            self.msgTextView.heightAnchor.constraint(equalToConstant: 150),
            
            self.dataPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin ?? 10),
            self.dataPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -(margin ?? 10)),
            self.dataPicker.topAnchor.constraint(equalTo: self.msgTextView.bottomAnchor, constant: 20),
            self.dataPicker.heightAnchor.constraint(equalToConstant: 150),
            
            self.okBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin ?? 10),
            self.okBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -(margin ?? 10)),
            self.okBtn.heightAnchor.constraint(equalToConstant: 50),
            self.okBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    @objc func okBtnClick(_ sender:Any){
        self.delegate?.okBtnClick(text: self.msgTextView.text, date: self.dataPicker.date)
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddAlarmViewController : UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newValue = textView.text.count + text.count
        
        if newValue >= 25{
            return false
        }
        
        return true
    }
}
