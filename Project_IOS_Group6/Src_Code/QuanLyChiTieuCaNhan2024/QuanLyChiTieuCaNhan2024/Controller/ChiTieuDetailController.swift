//
//  ChiTieuDetailController.swift
//  QuanLyChiTieuCaNhan2024
//
//  Created by  User on 24.05.2024.
//
import UIKit

class ChiTieuDetailController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var huy: UIBarButtonItem!
    @IBOutlet weak var luu: UIBarButtonItem!
    var chiTieu: ChiTieu?
    
    @IBOutlet weak var tenChiTieu: UITextField!
    @IBOutlet weak var ngayTao: UITextField!
    @IBOutlet weak var soTien: UITextField!
    @IBOutlet weak var navigation: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // B3: Thuc hien uy quyen cho doi tuong TextField
        tenChiTieu.delegate = self
        ngayTao.delegate = self
        soTien.delegate = self
        
        
        // Lay du lieu truyen sang tu man hinh TableView (Neu co)
        if let chiTieu = chiTieu {
            navigation.title = "Them Chi Tieu"
            tenChiTieu.text = chiTieu.tenCT
            ngayTao.text = chiTieu.ngayTao
            soTien.text = "\(chiTieu.soTien)"
        }
        
    }

   
    // An ban phim
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Ham ket thuc qua trinh soan thao
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("\(tenChiTieu.text!)")
    }
    
    // Nut cancel
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // Dong goi du lieu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("Tu dong goi truoc khi chuyen man hinh ve A")
        let tenCT = tenChiTieu.text ?? ""
        let ngayTao = ngayTao.text ?? ""
        let soTien = soTien.text ?? "0"
        chiTieu = ChiTieu(tenCT: tenCT, ngayTao: ngayTao, soTien: Int(soTien) ?? 0)
    }
}
