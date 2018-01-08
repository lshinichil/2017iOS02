//
//  PostTextViewController.swift
//  sns
//
//  Created by REO HARADA on 2017/10/29.
//  Copyright © 2017年 reo harada. All rights reserved.
//

import UIKit

class PostTextViewController: UIViewController {
    @IBOutlet weak var postTextView: UITextView!
    
    @IBAction func tapNextButton(_ sender: Any) {
        /********** レッスン2-1 メッセージを保存する **********/
//        // 保存するメッセージを取得する
        let timeLineMessage = self.postTextView.text
//        // mBaasに保存してくれる人を呼んでくる
        let object = NCMBObject(className: "timeLine")
//        // 保存するデータと場所を決める
        object?.setObject(timeLineMessage, forKey: "timeLineMessage")
//        // データをmBaasに保存する
        object?.saveInBackground({ (error) in
//            // データを保存したあとどうするぅ？
        })
        /********** レッスン2-1 メッセージを保存する **********/
    }
    
}
