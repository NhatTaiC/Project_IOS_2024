import UIKit

class ChiTieuDetailController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var soTien: UITextField!
    @IBOutlet weak var ngayTao: UITextField!
    @IBOutlet weak var tenChiTieu: UITextField!
    
    var chiTieu: ChiTieu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soTien.delegate = self
        ngayTao.delegate = self
        tenChiTieu.delegate = self
        
        if let chiTieu = chiTieu {
            tenChiTieu.text = chiTieu.tenCT
            soTien.text = String(chiTieu.soTien)
            ngayTao.text = chiTieu.ngayTao
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveChiTieu))
    }
    
    @objc func saveChiTieu() {
        guard let tenCT = tenChiTieu.text, !tenCT.isEmpty,
              let soTienText = soTien.text, let soTien = Int(soTienText),
              let ngayTao = ngayTao.text, !ngayTao.isEmpty else {
            let alert = UIAlertController(title: "Lỗi", message: "Vui lòng nhập đầy đủ thông tin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Cập nhật trực tiếp đối tượng `chiTieu` gốc
        chiTieu?.tenCT = tenCT
        chiTieu?.soTien = soTien
        chiTieu?.ngayTao = ngayTao
        
        performSegue(withIdentifier: "unwindToChiTieuTableViewController", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
