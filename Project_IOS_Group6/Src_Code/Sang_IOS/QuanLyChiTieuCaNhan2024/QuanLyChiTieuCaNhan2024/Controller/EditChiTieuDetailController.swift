//
//  EditChiTieuDetailController.swift
//  QuanLyChiTieuCaNhan2024
//
//  Created by  User on 24.05.2024.
//

import UIKit

class EditChiTieuDetailController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tenCT: UITextField!
    @IBOutlet weak var ngayTao: UITextField!
    @IBOutlet weak var soTien: UITextField!
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var luu: UIBarButtonItem!
    
    var chiTieu: ChiTieu?
    
    override func viewDidLoad() {
        // B3: Thuc hien uy quyen cho doi tuong TextField
        tenCT.delegate = self
        ngayTao.delegate = self
        soTien.delegate = self
        
        
        // Lay du lieu truyen sang tu man hinh TableView (Neu co)
        if let chiTieu = chiTieu {
            navigation.title = "Edit Chi Tieu"
            tenCT.text = chiTieu.tenCT
            ngayTao.text = chiTieu.ngayTao
            soTien.text = "\(chiTieu.soTien)"
        }
        
        tenCT.isUserInteractionEnabled = false
    }
    
    // An ban phim
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Ham ket thuc qua trinh soan thao
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(tenCT.text!)")
    }
    
    // Nut quay ve
    @IBAction func QuayVe(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // Dong goi du lieu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("Tu dong goi truoc khi chuyen man hinh ve A")
        let tenCT = tenCT.text ?? ""
        let ngayTao = ngayTao.text ?? ""
        let soTien = soTien.text ?? "0"
        chiTieu = ChiTieu(tenCT: tenCT, ngayTao: ngayTao, soTien: Int(soTien) ?? 0)
    }
}
