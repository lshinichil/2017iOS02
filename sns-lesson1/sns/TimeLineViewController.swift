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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableViewと相談する準備その２
        // snsTableViewとこのファイルの中で相談します
        self.snsTableView.delegate = self
        // snsTableViewのデータをこのファイルの中に置きます
        self.snsTableView.dataSource = self
        
        /********** レッスン xibファイルの登録 **********/
        // TimeLineTableViewCell.xibという名前のファイルを取得する
        let xib = UINib(nibName: "TimeLineTableViewCell", bundle: nil)
        // 上で取得したカスタムセルをsnsTableViewに登録する
        self.snsTableView.register(xib, forCellReuseIdentifier: "TimeLineTableViewCell")
        /********** レッスン xibファイルの登録 **********/
    }
    
    // tableViewとの相談↓
    // セクションの数どうするぅ？
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1セクションでお願いします。
        return 1
    }
    
    // セクションの中のセルの数どうするぅ？
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数は10個でお願いします。
        return 10
    }
    
    // 各行のセルの中身どうするぅ？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /********** レッスン カスタムセルを取得するxibファイルの登録 **********/
        // snsTableViewの中の"TimeLineTableViewCell"と名前つけたカスタムセルをください
        let timeLineCell = self.snsTableView.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell
        // カスタムセルの中のtimeLineLabelという名前のLabelにテキストを入力する
        timeLineCell.timeLineLabel.text = "ブルーハワイなう(*´ω｀*)"
        // カスタムセルの中のtimeLineImageViewという名前のUIImageViewに画像を設置する
        timeLineCell.timeLineImageView.image = UIImage(named: "drink")
        // 上のcellと名前つけたセルでお願いします
        return timeLineCell
        /********** レッスン カスタムセルを取得するxibファイルの登録 **********/

    }
    // tableViewとの相談↑
    
    /********** レッスン cellの高さの相談を追加 **********/
    // 各行のセルの高さどうするぅ？
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 300でお願いします
        return 300
    }
    /********** レッスン cellの高さの相談を追加 **********/

}
