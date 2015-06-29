//
//  ViewController.swift
//  NUtest
//
//  Created by Takemi Watanuki on 2015/06/28.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet var textfield : UITextField!
    @IBOutlet var myLabel : UILabel!
    @IBOutlet var textNumOfArray : UILabel!
    @IBOutlet var textAtNum : UILabel!
    
    
    
    //空の配列を用意する
    var stringArray : [String] = []
    
    //中身を確認するためのnum
    var num = 0
    
    
    //NSUserDefaultsを使うための宣言
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textfield.delegate = self
        
        
        
        
        
        //昔"openKey"という鍵で保存したかどうか確認
        if((defaults.objectForKey("openKey")) != nil){
            
            //objectsを配列として確定させ、前回の保存内容を格納
            let objects = defaults.objectForKey("openKey") as? [String]
            
            //各名前を格納するための変数を宣言
            var nameString:AnyObject
            
            //前回の保存内容が格納された配列の中身を一つずつ取り出す
            for nameString in objects!{
                //配列に追加していく
                stringArray.append(nameString as String)
            }
            
        }
        
        
        
        
        
        
        //現在保存されているstringArrayの要素数を表示
        textNumOfArray.text = String(stringArray.count)
        
    }
    
    //配列に保存する
    @IBAction func save(){
        
        //配列にtextfieldの文字列を保存
        stringArray.append(self.textfield.text)
        
        //配列をopenKeyで保存
        defaults.setObject(stringArray, forKey: "openKey")
        defaults.synchronize()
        
        //現在保存されているstringArrayの要素数を表示
        textNumOfArray.text = String(stringArray.count)
    }
    
    

    //中身を確認する
    @IBAction func up(){
        
        //stringArrayの中身があることを確認
        if !stringArray.isEmpty == true{
            
            //配列の要素数以上の数字になったらエラーをおこすので、越えたら0に戻す
            if num >= stringArray.count {
                
                num = 0
                
            }
            
            //配列の中身を表示してあげる
            myLabel.text = stringArray[num]
            
            //配列の何番目にいるのかを表示してあげる
            textAtNum.text = String(num)
            
            //配列の確認する番数を増やす
            num++
        }
        
    }
    
    //保存している内容をすべて消す
    @IBAction func clear(){
        stringArray.removeAll()
        defaults.removeObjectForKey("openKey")
        myLabel.text = ""
        textAtNum.text = ""
        textNumOfArray.text = ""
        
        //現在保存されているstringArrayの要素数を表示
        textNumOfArray.text = String(stringArray.count)
    }
    
    
    /*
    UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
    */
    func textFieldDidBeginEditing(textField: UITextField){
        println("textFieldDidBeginEditing:" + textField.text)
    }
    
    /*
    UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        println("textFieldShouldEndEditing:" + textField.text)
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}

