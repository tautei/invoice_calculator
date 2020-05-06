//
//  ViewController.swift
//  invoice_calculator
//
//  Created by monet-macbook-pro on 2020/3/28.
//  Copyright © 2020 monet-macbook-pro. All rights reserved.
//

import UIKit
import Foundation



class ViewController: UIViewController {

    @IBOutlet weak var salesAmountInput: UITextField!
    @IBOutlet weak var taxRate: UITextField!
    @IBOutlet weak var taxAmount: UITextField!
    @IBOutlet weak var totalAmountInput:UITextField!
    @IBOutlet weak var yearnow: UILabel!
    @IBOutlet weak var capitalshow: UILabel!
    @IBOutlet weak var companySerialInput: UITextField!
    @IBOutlet weak var companyNameInput: UITextField!
    
    //var companydata = CompanyData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //取得日期與並顯示
        let now = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "中華民國yyy年MM月dd日"
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") // 設定地區(台灣)
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei") // 設定時區(台灣)
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.republicOfChina)
        let dateFormatString:String = dateFormatter.string(from:now)
        yearnow.text = String("\(dateFormatString)")
        
        
        
        
        
    }
    
    //收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    @IBAction func salessend(_ sender: Any) {

        if salesAmountInput.text!.count < 20 {
        //無論輸入框收到什麼值，都先把逗號給幹掉
        let saleshavedou = salesAmountInput.text
        let salesremovedou = saleshavedou!.replacingOccurrences(of: ",", with: "") //取代
        salesAmountInput.text = salesremovedou
        
        //處理optinonal
        if let salesAmount = salesAmountInput.text,let sales = Double(salesAmount){
            
            //計算開始
            let total = sales * 105 / 100
            let totalmoney = String(format: "%.0f", total)
            let totalmoneyint = Int(totalmoney)
            
            //把total數字千分位，轉換金錢格式
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "zh_TW")
            formatter.maximumFractionDigits = 0
            let totalmoneyString = formatter.string(from: NSNumber(value: totalmoneyint!))
            totalAmountInput.text = totalmoneyString
        
            //先把sales數字千分位
            let salesmoneyString = formatter.string(from:NSNumber(value:sales))
            salesAmountInput.text = salesmoneyString
                
            //算稅
            let tax = sales * 5 / 100
            let taxmoney = String(format: "%.0f", tax)
            let taxmoneyint = Int(taxmoney)
            let taxmoneyString = formatter.string(from:NSNumber(value:taxmoneyint!))
            taxAmount.text = taxmoneyString
            
            //大寫中文
            capitalshow.text = totalmoneyString?
                .replacingOccurrences(of: "0", with: "零")
                .replacingOccurrences(of: "1", with: "壹")
                .replacingOccurrences(of: "2", with: "貳")
                .replacingOccurrences(of: "3", with: "參")
                .replacingOccurrences(of: "4", with: "肆")
                .replacingOccurrences(of: "5", with: "伍")
                .replacingOccurrences(of: "6", with: "陸")
                .replacingOccurrences(of: "7", with: "柒")
                .replacingOccurrences(of: "8", with: "捌")
                .replacingOccurrences(of: "9", with: "玖")
                .replacingOccurrences(of: ",", with: "")
        }
    
        //replacingOccurrences(of: ",", with: "")
        //totalAmountInput.text = String(Double(salesAmountInput.text!)! * 105/100)
        //taxAmount.text = String(Double(salesAmountInput.text!)! * 5/105)
        }else{
            salesAmountInput.text = "超過金額請重新輸入"
            totalAmountInput.text = ""
            taxAmount.text = ""
            capitalshow.text = ""
        }
    }
    
        
    
    @IBAction func totalsend(_ sender: Any) {
        
        if salesAmountInput.text!.count < 20 {
        //無論輸入框收到什麼值，都先把逗號給幹掉
        let totalhavedou = totalAmountInput.text
        let totalremovedou = totalhavedou!.replacingOccurrences(of: ",", with: "") //取代
        totalAmountInput.text = totalremovedou
        
        if let totalAmount = totalAmountInput.text,let total = Double(totalAmount){
                
            //算銷售
            let sales = total / 105 * 100
            let salesmoney = String(format: "%.0f", sales)
            let salesmoneyint = Int(salesmoney)

            //把數字千分位
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "zh_TW")
            formatter.maximumFractionDigits = 0
            let salesmoneyString = formatter.string(from: NSNumber(value: salesmoneyint!))
            salesAmountInput.text = salesmoneyString
            
            //先把sales數字千分位
            let totalmoneyString = formatter.string(from:NSNumber(value:total))
            totalAmountInput.text = totalmoneyString
        
            //算稅
            let tax = sales * 5 / 100
            let taxmoney = String(format: "%.0f", tax)
            let taxmoneyint = Int(taxmoney)
            let taxmoneyString = formatter.string(from:NSNumber(value:taxmoneyint!))
            taxAmount.text = taxmoneyString
            
            //大寫中文
            let totalmoneyStringChines = totalmoneyString?
                .replacingOccurrences(of: "0", with: "零")
                .replacingOccurrences(of: "1", with: "壹")
                .replacingOccurrences(of: "2", with: "貳")
                .replacingOccurrences(of: "3", with: "參")
                .replacingOccurrences(of: "4", with: "肆")
                .replacingOccurrences(of: "5", with: "伍")
                .replacingOccurrences(of: "6", with: "陸")
                .replacingOccurrences(of: "7", with: "柒")
                .replacingOccurrences(of: "8", with: "捌")
                .replacingOccurrences(of: "9", with: "玖")
                .replacingOccurrences(of: ",", with: "")
            capitalshow.text = totalmoneyStringChines
        }
        
        //salesAmountInput.text = String((Double(totalAmountInput.text!)! / 105) * 100)
        //taxAmount.text = String((Double(totalAmountInput.text!)! / 105) * 5)
        }else{
            totalAmountInput.text = "超過金額請重新輸入"
            salesAmountInput.text = ""
            taxAmount.text = ""
            capitalshow.text = ""
        }
    }
    
    
    @IBAction func serialsend(_ sender: Any) {
        let serialstring = companySerialInput.text
        if serialstring?.count == 8 {
            let urlStr = "https://data.gcis.nat.gov.tw/od/data/api/5F64D864-61CB-4D0D-8AD9-492047CC1EA6?$format=json&$filter=Business_Accounting_NO eq \(String(describing: serialstring!))&$skip=0&$top=50".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let url = URL(string: urlStr!) {
                URLSession.shared.dataTask(with: url) { (data, response , error) in
                    if let data = data, let companyResaults = try? JSONDecoder().decode([CompanyData].self, from: data) {
                        DispatchQueue.main.async {
                            self.companyNameInput.text = companyResaults[0].Company_Name
                        }
                    }
                }.resume()
            }
        }else{
            self.companyNameInput.text = ""
        }
    }
    
    
    @IBAction func companysend(_ sender: Any) {
        let companystring = companyNameInput.text
            let urlStr = "https://data.gcis.nat.gov.tw/od/data/api/6BBA2268-1367-4B42-9CCA-BC17499EBE8C?$format=json&$filter=Company_Name like \(String(describing: companystring!)) and Company_Status eq 01&$skip=0&$top=50".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let url = URL(string: urlStr!) {
                URLSession.shared.dataTask(with: url) { (data, response , error) in
                    if let data = data, let companyResaults = try? JSONDecoder().decode([CompanyData].self, from: data) {
                        if companyResaults.count == 1{
                            DispatchQueue.main.async {
                                    self.companySerialInput.text = companyResaults[0].Business_Accounting_NO
                                }
                        }
                    }
                }.resume()
            }else{
                self.companySerialInput.text = ""
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    

}

