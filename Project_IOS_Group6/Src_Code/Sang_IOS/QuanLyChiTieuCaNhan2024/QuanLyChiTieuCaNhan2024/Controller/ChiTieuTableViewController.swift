//
//  ChiTieuTableViewController.swift
//  QuanLyChiTieuCaNhan2024
//
//  Created by  User on 22.05.2024.
//

import UIKit

class ChiTieuTableViewController: UITableViewController {
    
    // MARK: PROPERTIES
    @IBOutlet weak var navigation: UINavigationItem!
    private var chitieus = [ChiTieu]()
    private let chiTieuDetailID = "ChiTieuDetailController"
    private let editChiTieuDetailID = "EditChiTieuDetailController"
    
    // Tao doi tuong truy van CSDL
    private let dao = ChiTieuDB();
    
    // Dinh nghia kieu du lieu enum dung danh dau duong di
    enum NavigationType {
        case newChiTieu
        case editChiTieu
    }
    
    // Dinh nghia bien danh dau duong di
    var navigationType:NavigationType = .newChiTieu
    
    // Bien luu gia tri Indexpath
    private var selectedIndexpath:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
////         Tao du lieu gia cho mang chitieu
//                for _ in 0...5 {
//                    if let chitieu = ChiTieu(tenCT: "ChiTieu1", ngayTao: "22/05/2024", soTien: 100){
//                        chitieus.append(chitieu)
//                    }
//                }
        
        // Them Edit Button cho Navigation Bar
        navigation.leftBarButtonItem = editButtonItem
        
        // Doc toan bo du lieu meals tu CSDL neu co
        dao.readChiTieus(chitieus: &chitieus)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chitieus.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseCell = "ChiTieuCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? ChiTieuCell {
            
            // Lay du lieu tu DataSource
            let chitieu = chitieus[indexPath.row]
            
            // Do du lieu tu ChiTieu vao cell
            cell.tenCT.text = chitieu.tenCT
            cell.ngayTao.text = chitieu.ngayTao
            cell.soTien.text = "\(chitieu.soTien)";

            return cell
            
        }

        
        
        // Khong tao duoc cell
        fatalError("Khong the tao cell!")
    }
    
    
//    // Dinh nghia ham xu ly su kien cho cell
//    @objc private func editChiTieu(_ sender: UITapGestureRecognizer) {
//        //print("Cell tapped")
//        // Tao doi tuong man hinh ChiTieuDetailController
//        if let chiTieuDetail = self.storyboard!.instantiateViewController(withIdentifier: chiTieuDetailID) as? ChiTieuDetailController {
//            // Lay doi tuong cell duoc tap
//            if let cell = sender.view as? ChiTieuCell {
//                // Xac dinh vi tri cua cell trong table view
//                if let indexPath = tableView.indexPath(for: cell) {
//
//                    // Truyen chitieu sang chiTieuDetailController
//                    chiTieuDetail.chiTieu = chitieus[indexPath.row]
//
//                    // Danh dau duong di
//                    navigationType = .editChiTieu
//
//                    // Luu vi tri cell duoc chon
//                    selectedIndexpath = indexPath
//
//                    // Chuyen sang man hinh khac
//                    present(chiTieuDetail, animated: true)
//                }
//            }
//        }
//    }
    
    // Dinh nghia ham xu ly su kien cho cell
    @objc private func editChiTieu(_ sender: UITapGestureRecognizer) {
        //print("Cell tapped")
        // Tao doi tuong man hinh ChiTieuDetailController
        if let editChiTieuDetail = self.storyboard!.instantiateViewController(withIdentifier: editChiTieuDetailID) as? EditChiTieuDetailController {
            // Lay doi tuong cell duoc tap
            if let cell = sender.view as? ChiTieuCell {
                // Xac dinh vi tri cua cell trong table view
                if let indexPath = tableView.indexPath(for: cell) {
                    
                    // Truyen chitieu sang chiTieuDetailController
                    editChiTieuDetail.chiTieu = chitieus[indexPath.row]

                    // Danh dau duong di
                    navigationType = .editChiTieu

                    // Luu vi tri cell duoc chon
                    selectedIndexpath = indexPath

                    // Chuyen sang man hinh khac
                    present(editChiTieuDetail, animated: true)
                }
            }
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete chitieu trong CSDL
            let _ = dao.deleteChiTieu(chitieu: chitieus[indexPath.row])
            
            // Xoa phan tu tu datasource
            chitieus.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //print("Cell tapped")
         // Tao doi tuong man hinh ChiTieuDetailController
         if let editChiTieuDetail = self.storyboard!.instantiateViewController(withIdentifier: editChiTieuDetailID) as? EditChiTieuDetailController {
             
             // Truyen chitieu sang ChiTieuDetailController
             editChiTieuDetail.chiTieu = chitieus[indexPath.row]
             
             // Danh dau duong di
             navigationType = .editChiTieu
             
             // Luu vi tri cell duoc chon
             selectedIndexpath = indexPath
             
             // Chuyen sang man hinh khac
             present(editChiTieuDetail, animated: true)
             
         }
     }
     
    @IBAction func newChiTieu(_ sender: UIBarButtonItem) {
        // Tao doi tuong man hinh ChiTieuDetailController
        if let chiTieuDetail = self.storyboard!.instantiateViewController(withIdentifier: chiTieuDetailID) as? ChiTieuDetailController {
            
            // Danh dau duong di
            navigationType = .newChiTieu
            
            // Chuyen sang man hinh khac
            present(chiTieuDetail, animated: true)
        }
    }
   
     // Dinh nghia ham unwind quay ve tu chiTieuDetailController
     @IBAction func unwindFromChiTieuDetailController(_ segue: UIStoryboardSegue) {
         //print("unwind from meal detail")
         // Lay doi tuong man hinh ChiTieuDetailController
         if let chiTieuDetail = segue.source as? ChiTieuDetailController {
             if let chitieu = chiTieuDetail.chiTieu {
                 switch navigationType {
                     
                 case .newChiTieu:
                     // Them chitieu moi vao datasource
                     chitieus.append(chitieu)
                     
                     // Tao mot dong (cell) moi cho tableView
                     let newIndexPath = IndexPath(row: chitieus.count - 1, section: 0)
                     tableView.insertRows(at: [newIndexPath], with: .left)
                     
                     // Them chitieu moi vao CSDL
                     let _ = dao.insertChiTieu(chitieu: chitieu)
                     
                 case .editChiTieu:
                     
                     if let indexPath = selectedIndexpath {
                         // Update chitieu moi vao CSDL
                         let _ = dao.updateChiTieu(chitieu: chitieu)
                         
                         // Update datasource
                         chitieus[indexPath.row] = chitieu
                         
                         // Update tableView cell
                         tableView.reloadRows(at: [indexPath], with: .left)
                         	
                     }
                 }
             }
         }
     }
        
    // Dinh nghia ham unwind quay ve tu chiTieuDetailController
    @IBAction func unwindFromEditChiTieuDetailController(_ segue: UIStoryboardSegue) {
        //print("unwind from meal detail")
        // Lay doi tuong man hinh ChiTieuDetailController
        if let editChiTieuDetail = segue.source as? EditChiTieuDetailController {
            if let chitieu = editChiTieuDetail.chiTieu {
                switch navigationType {

                case .newChiTieu:
                    // Them chitieu moi vao datasource
                    chitieus.append(chitieu)

                    // Tao mot dong (cell) moi cho tableView
                    let newIndexPath = IndexPath(row: chitieus.count - 1, section: 0)
                    tableView.insertRows(at: [newIndexPath], with: .left)

                    // Them chitieu moi vao CSDL
                    let _ = dao.insertChiTieu(chitieu: chitieu)

                case .editChiTieu:

                    if let indexPath = selectedIndexpath {
                        // Update chitieu moi vao CSDL
                        let _ = dao.updateChiTieu(chitieu: chitieu)

                        // Update datasource
                        chitieus[indexPath.row] = chitieu

                        // Update tableView cell
                        tableView.reloadRows(at: [indexPath], with: .left)

                    }
                }
            }
        }
    }
    
 
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Lay doi tuong man hinh EditChiTieuDetailController
         if let editChiTieuDetail = segue.destination as? EditChiTieuDetailController {
             // Lay doi tuong cell duoc tap
             if let cell = sender as? ChiTieuCell {
                 // Xac dinh vi tri cua cell trong table view
                 if let indexPath = tableView.indexPath(for: cell) {
                     // Truyen chitieu sang editChiTieuDetailController
                     editChiTieuDetail.chiTieu = chitieus[indexPath.row]
                     
                     // Danh dau duong di
                     navigationType = .editChiTieu
                     
                     // Luu vi tri cell duoc chon
                     selectedIndexpath = indexPath
                     
                     // Chuyen sang man hinh khac
                     //present(mealDetail, animated: true)
                 }
             }
         }
     }
     
     

}
