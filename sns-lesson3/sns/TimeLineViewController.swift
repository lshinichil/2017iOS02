//
//  TimeLineViewController.swift
//  sns
//
//  Created by REO HARADA on 2017/10/29.
//  Copyright © 2017年 reo harada. All rights reserved.
//

import UIKit

// tableViewと相談する準備その１
// UITableViewDelegate:「このclassのなかでtableViewと相談する」という意味
// UITableViewDataSource:「このclassのなかにtableViewのデータを置きます」という意味
class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var snsTableView: UITableView!
    /********** レッスン2 ｍBaasから取得したでデータを格納する部品 **********/
    // mbaasから取得したデータを用意する
    var data = [NCMBObject]()
    /********** レッスン2 ｍBaasから取得したでデータを格納する部品 **********/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableViewと相談する準備その２
        // snsTableViewとこのファイルの中で相談します
        self.snsTableView.delegate = self
        // snsTableViewのデータをこのファイルの中に置きます
        self.snsTableView.dataSource = self
        
        /********** レッスン1 xibファイルの登録 **********/
        // TimeLineTableViewCell.xibという名前のファイルを取得する
        let xib = UINib(nibName: "TimeLineTableViewCell", bundle: nil)
        // 上で取得したカスタムセルをsnsTableViewに登録する
        self.snsTableView.register(xib, forCellReuseIdentifier: "TimeLineTableViewCell")
        /********** レッスン1 xibファイルの登録 **********/
        
        /********** レッスン2-3 ｍBaasからデータを取得する **********/
        // mBaasからデータを取得してくれる人を呼んでくる
//        let query = NCMBQuery(className: "timeLine")
        // 最新日時順に取得する
//        query?.order(byDescending: "createDate")
        // mBaasからデータを取得する
//        query?.findObjectsInBackground({ (values, error) in
            // データを取得した後どうするぅ？
            // エラーでなければ
//            if error == nil {
                // self.dataに取得したデータをいれる
//                self.data = values as! [NCMBObject]
                // tableViewと相談し直す
//                self.snsTableView.reloadData()
//            }
//        })
        /********** レッスン2-3 ｍBaasからデータを取得する **********/
    }
    
    /********** レッスン3-1 viewWillAppearのタイミングでｍBaasからデータを取得する **********/
    override func viewWillAppear(_ animated: Bool) {
//        // mBaasからデータを取得してくれる人を呼んでくる
        let query = NCMBQuery(className: "timeLine")
//        // 最新日時順に取得する
        query?.order(byDescending: "createDate")
        // mBaasからデータを取得する
        query?.findObjectsInBackground({ (values, error) in
//            // データを取得した後どうするぅ？
//            // エラーでなければ
            if error == nil {
//                // self.dataに取得したデータをいれる
                self.data = values as! [NCMBObject]
//                // tableViewと相談し直す
                self.snsTableView.reloadData()
            }
        })
    }
    /********** レッスン3-1 viewWillAppearのタイミングでｍBaasからデータを取得する **********/
    
    // tableViewとの相談↓
    // セクションの数どうするぅ？
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1セクションでお願いします。
        return 1
    }
    
    // セクションの中のセルの数どうするぅ？
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /********** レッスン2 mBaasから取得したデータの数でお願いします **********/
        return self.data.count
        /********** レッスン2 mBaasから取得したデータの数でお願いします **********/
    }
    
    // 各行のセルの中身どうするぅ？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /********** レッスン1 カスタムセルを取得するxibファイルの登録 **********/
        // snsTableViewの中の"TimeLineTableViewCell"と名前つけたカスタムセルをください
        let timeLineCell = self.snsTableView.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell
        // カスタムセルの中のtimeLineLabelという名前のLabelにテキストを入力する
        /********** レッスン2 mBaasから取得したデータをセルのラベルにいれる **********/
        timeLineCell.timeLineLabel.text = self.data[indexPath.row].object(forKey: "timeLineMessage") as! String
        /********** レッスン2 mBaasから取得したデータをセルのラベルにいれる **********/
        // カスタムセルの中のtimeLineImageViewという名前のUIImageViewに画像を設置する
        timeLineCell.timeLineImageView.image = UIImage(named: "drink")
        // 上のcellと名前つけたセルでお願いします
        return timeLineCell
        /********** レッスン1 カスタムセルを取得するxibファイルの登録 **********/
    }
    
    /********** レッスン1 cellの高さの相談を追加 **********/
    // 各行のセルの高さどうするぅ？
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 300でお願いします
        return 300
    }
    /********** レッスン1 cellの高さの相談を追加 **********/
    
    // tableViewとの相談↑
}
