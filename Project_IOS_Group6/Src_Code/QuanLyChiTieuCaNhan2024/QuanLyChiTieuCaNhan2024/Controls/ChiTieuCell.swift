//
//  ChiTieuCell.swift
//  QuanLyChiTieuCaNhan2024
//
//  Created by  User on 22.05.2024.
//

import UIKit

class ChiTieuCell: UITableViewCell {
    
    // MARK: PROPERTIES
    @IBOutlet weak var tenCT: UILabel!
    
    @IBOutlet weak var ngayTao: UILabel!
    
    @IBOutlet weak var soTien: UILabel!
    
    var onTap:UITapGestureRecognizer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if onTap     != nil {
            onTap!.delegate = self
        }
    }

    // Dinh nghia ham uy quyen cho doi tuong UITapGestureRecognizer
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view == self.contentView)
    }
}
