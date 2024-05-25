//
//  ChiTieu.swift
//  QuanLyChiTieuCaNhan2024
//
//  Created by  User on 22.05.2024.
//

import UIKit

class ChiTieu {
    // MARK: PROPERTIES
    var tenCT:String
    var ngayTao:String
    var soTien:Int
    
    // MARK: CONSTRUCTORS
    init?(tenCT: String, ngayTao: String, soTien: Int) {
        
        // Khong tao duoc chi tieu
        if tenCT.isEmpty {
            return nil
        }
        
        if soTien < 0 || soTien > 10000000 {
            return nil
        }
        
        self.tenCT = tenCT
        self.ngayTao = ngayTao
        self.soTien = soTien
    }
}
