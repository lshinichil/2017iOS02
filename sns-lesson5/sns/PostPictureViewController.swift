//
//  PostPictureViewController.swift
//  sns
//
//  Created by REO HARADA on 2017/10/29.
//  Copyright © 2017年 reo harada. All rights reserved.
//

import UIKit

/********** レッスン3-4 UIImagePickerControllerと相談する準備 **********/
// UIImagePickerControllerと相談する準備その１
// UIImagePickerControllerDelegate:UIImagePickerControllerと相談する宣言
// UINavigationControllerDelegate:UIImagePickerControllerは、UINavigationControllerの子どもであり、UINavigationControllerとの相談宣言も必要
class PostPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
/********** レッスン3-4 UIImagePickerControllerと相談する準備 **********/
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    /********** レッスン3-3 iPhoneに保存してある写真を取得、カメラを起動してくれる部品を用意 **********/
    var imgPC = UIImagePickerController()
    /********** レッスン3-3 iPhoneに保存してある写真を取得、カメラを起動してくれる部品を用意 **********/
    /********** レッスン4-4 objectIdを保存しておく部品を用意 **********/
    var objectId = ""
    /********** レッスン4-4 objectIdを保存しておく部品を用意 **********/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /********** レッスン3-4 UIImagePickerControllerと相談する準備 **********/
        // UIImagePickerControllerと相談する準備その2
        self.imgPC.delegate = self
        /********** レッスン3-4 UIImagePickerControllerと相談する準備 **********/
        /********** レッスン3-7 選んだ写真を編集したいとき **********/
        // 編集モードに変更
        self.imgPC.allowsEditing = true
        /********** レッスン3-7 選んだ写真を編集したいとき **********/
    }
    
    @IBAction func tapSelectFromPicture(_ sender: Any) {
        /********** レッスン3-5 写真から選ぶ画面を起動する **********/
        // もし、PhotoLibraryが読み込み可能であれば
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // UIImagePickerControllerにどこから写真を選ぶか指定する（PhotoLibraryから）
            self.imgPC.sourceType = .photoLibrary
            // UIImagePickerControllerを表示する
            self.present(imgPC, animated: true, completion: nil)
        }
        /********** レッスン3-5 写真から選ぶ画面を起動する **********/
    }
    
    @IBAction func tapSelectFromCamera(_ sender: Any) {
        /********** レッスン3-x カメラをを起動する **********/
        // もし、カメラが読み込み可能であれば
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // UIImagePickerControllerにどこから写真を選ぶか指定する（カメラから）
            self.imgPC.sourceType = .camera
            // UIImagePickerControllerを表示する
            self.present(imgPC, animated: true, completion: nil)
        }
        /********** レッスン3-x カメラをを起動する **********/
    }
    
    @IBAction func tapPostCompleteButton(_ sender: Any) {
        if self.selectedImageView.image == nil {
            self.notificationLabel.isHidden = false
            return
        }
        /********** レッスン4-1 選んだ写真を保存する **********/
        // 選んだ画像（UIImage）をデータに変更（Data）
        let data = UIImagePNGRepresentation(self.selectedImageView.image!)
        // ファイルを保存してくれる人（NCMBFile）を呼んでくる
        // ファイル名と保存するデータを渡す
        //let file = NCMBFile.file(withName: "reoharada.png", data: data) as? NCMBFile
        /********** レッスン4-6 ファイル名にobjectIdを利用する **********/
        let file = NCMBFile.file(withName: "\(objectId).png", data: data) as? NCMBFile
        /********** レッスン4-6 ファイル名にobjectIdを利用する **********/
        // ファイルを保存してもらう
        file?.saveInBackground({ (error) in
            // ファイル保存が終わったらどうするぅ？
            /********** レッスン4-2 保存が終わったあとの処理 **********/
            // もし、エラーでなかったら
            if error == nil {
                // 最初の画面に戻る
                self.navigationController?.popToRootViewController(animated: true)
            }
            /********** レッスン4-2 保存が終わったあとの処理 **********/
        })
        /********** レッスン4-1 選んだ写真を保存する **********/
    }
    
    /********** レッスン3-6 UIImagePickerControllerとの相談 **********/
    // UIImagePickerControllerとの相談↓
    // 写真を選択した後どうするぅ？
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /********** レッスン3-7 選んだ写真を編集したいとき **********/
        // 編集した画像を取得
        let img = info[UIImagePickerControllerEditedImage] as! UIImage
        /********** レッスン3-7 選んだ写真を編集したいとき **********/
        // 選んだ画像をselectedImageViewに表示する
        self.selectedImageView.image = img
        // UIImagePickerControllerの画面を閉じる
        self.imgPC.dismiss(animated: true, completion: nil)
    }
    /********** レッスン3-6 写真を選択したらどうするぅ？ **********/
    
}
