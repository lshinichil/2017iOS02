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
        // 保存するメッセージを取得する
        let timeLineMessage = self.postTextView.text
        // mBaasに保存してくれる人を呼んでくる
        let object = NCMBObject(className: "timeLine")
        // 保存するデータと場所を決める
        object?.setObject(timeLineMessage, forKey: "timeLineMessage")
        // データをmBaasに保存する
        object?.saveInBackground({ (error) in
            // データが保存し終わったあとどうするぅ？
            /********** レッスン3-2 写真投稿の画面に移動する **********/
            // エラーでなかったら
            if error == nil {
                // 移動先の画面を呼んでくる
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostPictureViewController") as! PostPictureViewController
                /********** レッスン4-5 保存したobjectIdを次の画面に渡しておく **********/
                vc.objectId = object!.objectId
                /********** レッスン4-5 保存したobjectIdを次の画面に渡しておく **********/
                // 表示する
                self.show(vc, sender: nil)
            }
            /********** レッスン3-2 写真投稿の画面に移動する **********/
        })
        /********** レッスン2-1 メッセージを保存する **********/
    }
    
}
