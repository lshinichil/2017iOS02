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
    /********** レッスン5-2 ｍBaasから取得した画像データをキャッシュしておく部品 **********/
    var imgData = [String:Data]()
    /********** レッスン5-2 ｍBaasから取得した画像データをキャッシュしておく部品 **********/
    /********** レッスン5-5 データを更新する部品を用意 **********/
    var refreshControl = UIRefreshControl()
    /********** レッスン5-5 データを更新する部品を用意 **********/
    
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
//        // mBaasからデータを取得してくれる人を呼んでくる
//        let query = NCMBQuery(className: "timeLine")
//        // 最新日時順に取得する
//        query?.order(byDescending: "createDate")
//        // mBaasからデータを取得する
//        query?.findObjectsInBackground({ (values, error) in
//            // データを取得した後どうするぅ？
//            // エラーでなければ
//            if error == nil {
//                // self.dataに取得したデータをいれる
//                self.data = values as! [NCMBObject]
//                // tableViewと相談し直す
//                self.snsTableView.reloadData()
//            }
//        })
        /********** レッスン2-3 ｍBaasからデータを取得する **********/
        
        /********** レッスン5-6 UIRefreshControlのアクションを指定 **********/
//        // アクションの追加
        self.refreshControl.addTarget(self, action: #selector(TimeLineViewController.refreshData), for: .valueChanged)
//        // snsTableViewに追加
        self.snsTableView.addSubview(self.refreshControl)
        /********** レッスン5-6 UIRefreshControlのアクションを指定 **********/
    }
    
    /********* レッスン3-1 viewWillAppearのタイミングでｍBaasからデータを取得する *********/
    override func viewWillAppear(_ animated: Bool) {
        // mBaasからデータを取得してくれる人を呼んでくる
        let query = NCMBQuery(className: "timeLine")
        // 最新日時順に取得する
        query?.order(byDescending: "createDate")
        // mBaasからデータを取得する
        query?.findObjectsInBackground({ (values, error) in
            // データを取得した後どうするぅ？
            // エラーでなければ
            if error == nil {
                // self.dataに取得したデータをいれる
                self.data = values as! [NCMBObject]
                // tableViewと相談し直す
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
        /********** レッスン4-3 mBaasから画像を取得して、データをいれる **********/
        // 保存されてるデータを取得してくれる人（NCMBFile）を用意する
        //let file = NCMBFile.file(withName: "reoharada.png", data: nil) as! NCMBFile
        /********** レッスン5-1 セルの再利用対策 **********/
        // セルの画像を空にしておく
         timeLineCell.timeLineImageView.image = nil
        /********** レッスン5-1 セルの再利用対策 **********/
        /********** レッスン5-4 画像データキャッシュがあればそれを利用する **********/
        let id = self.data[indexPath.row].objectId!
        if self.imgData[id] != nil {
            timeLineCell.timeLineImageView.image = UIImage(data: self.imgData[id]!)
            return timeLineCell
        }
        /********** レッスン5-4 画像データキャッシュがあればそれを利用する **********/
        /********** レッスン4-7 mBaasから画像を取得して、データをいれる **********/
        let file = NCMBFile.file(withName: "\(self.data[indexPath.row].objectId!).png", data: nil) as! NCMBFile
        /********** レッスン4-7 mBaasから画像を取得して、データをいれる **********/
        // データを取得してもらう
        file.getDataInBackground { (data, error) in
            // データを取得したらどうするぅ？
            // もし、エラーでなかったら
            if error == nil {
                // セルの画像を設定する
                timeLineCell.timeLineImageView.image = UIImage(data: data!)
                /********** レッスン5-3 画像データキャッシュ保存 **********/
                self.imgData[self.data[indexPath.row].objectId!] = data!
                /********** レッスン5-3 画像データキャッシュ保存 **********/
            }
        }
        /********** レッスン4-3 mBaasから画像を取得して、データをいれる **********/
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
    
    /********** レッスン5-7 refreshData関数を用意 **********/
//    // refreshDataと呼ばれたときどうするぅ？
    @objc func refreshData() {
//        // mBaasからデータを取得してくれる人を呼んでくる
        let query = NCMBQuery(className: "timeLine")
//        // 最新日時順に取得する
        query?.order(byDescending: "createDate")
//        // mBaasからデータを取得する
        query?.findObjectsInBackground({ (values, error) in
//            // UIRefreshControl停止
            self.refreshControl.endRefreshing()
//            // データの初期化
            self.data = [NCMBObject]()
            self.imgData = [String:Data]()
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
    /********** レッスン5-7 refreshData関数を用意 **********/


}
