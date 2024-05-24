//
//  ChiTieuDB.swift
//  QuanLyChiTieuCaNhan2024
//
//  Created by  User on 23.05.2024.
//

import Foundation
import UIKit
import os.log

class ChiTieuDB {
    // MARK: DINH NGHIA DB
    private let DB_NAME = "chitieus.sqlite"
    private let DB_PATH:String?
    private let database:FMDatabase?
    
    // MARK: DINH NGHIA CAC TRUONG CUA BANG
    // 1. Bang chitieus
    private let CHITIEU_TABLE_NAME = "chitieus"
    private let CHITIEU_ID = "_id"
    private let CHITIEU_TENCT = "TenCT"
    private let CHITIEU_NGAYTAO = "NgayTao"
    private let CHITIEU_SOTIEN = "SoTien"
    
    // MARK: CONSTRUCTORS
    init() {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        
        DB_PATH = directories[0] + "/" + DB_NAME
        
        database = FMDatabase(path: DB_PATH)
        
        if database != nil {
            os_log("Khoi tao CSDL thanh cong!")
            // 1. Tao bang chitieus
            let sql = "CREATE TABLE \(CHITIEU_TABLE_NAME)("
            + "\(CHITIEU_ID) INTEGER PRIMARY KEY AUTOINCREMENT, "
            + "\(CHITIEU_TENCT) TEXT PRIMARY KEY, "
            + "\(CHITIEU_NGAYTAO) TEXT, "
            + "\(CHITIEU_SOTIEN) TEXT)"
            
            let _ = tableCreate(sql: sql, tableName: CHITIEU_TABLE_NAME)
            
        }else {
            os_log("Khoi tao CSDL khong thanh cong!")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // Primitive DB
    ////////////////////////////////////////////////////////////////////////////////
    // 1. Open DB
    private func open()->Bool {
        var OK = false
        if database != nil {
            if database!.open() {
                os_log("Mo CSDL thanh cong!")
                OK = true
            } else {
                os_log("Mo CSDL khong thanh cong!")
            }
        }
        
        return OK
    }
    // 2. Dong CSDL
    private func close() {
        if database != nil {
            database!.close()
        }
    }
    // 3. Ham tao bang du lieu
    private func tableCreate(sql:String, tableName:String)->Bool {
        var OK = false
        if open() {
            // Kiem tra xem bang du lieu ton tai hay chua
            if !database!.tableExists(tableName) {
                // Goi ham tao bang trong FMDB
                if database!.executeStatements(sql) {
                    os_log("Tao bang du lieu \(tableName) thanh cong!")
                    OK = true
                } else {
                    os_log("Tao bang du lieu \(tableName) khong thanh cong!")
                }
            }
        }
        
        return OK
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: Dinh nghia cac ham APIs cua CSDL
    ////////////////////////////////////////////////////////////////////////////
    // 1. Them chitieu vao CSDL
    func insertChiTieu(chitieu: ChiTieu) -> Bool {
        var OK = false
        if open() {
            if database!.tableExists(CHITIEU_TABLE_NAME) {
                // Cau lenh SQL
                let sql = "INSERT INTO \(CHITIEU_TABLE_NAME)(\(CHITIEU_TENCT), \(CHITIEU_NGAYTAO), \(CHITIEU_SOTIEN)) VALUES (?,?,?)"
                
                // Ghi du lieu vao bang meals cua CSDL
                if database!.executeUpdate(sql, withArgumentsIn: [chitieu.tenCT, chitieu.ngayTao, chitieu.soTien]) {
                    os_log("Them du lieu thanh cong!")
                    OK = true;
                } else {
                    os_log("Them du lieu khong thanh cong!")
                }
                // Dong CSDL
                close()
            }
            else {
                os_log("Bang du lieu chua ton tai!")
            }
        }
        
        return OK
    }
    
    // 2. Doc toan bo meals tu CSDL
    func readChiTieus(chitieus: inout [ChiTieu]) {
        if open() {
            if database!.tableExists(CHITIEU_TABLE_NAME) {
                // Cau lenh SQL
                let sql = "SELECT * FROM \(CHITIEU_TABLE_NAME) ORDER BY \(CHITIEU_SOTIEN) DESC"
                // Khai bao bien chua du lieu doc ve tu CSDL
                var result:FMResultSet?
                do {
                    result = try database!.executeQuery(sql, values: nil)
                } catch {
                    os_log("Khong the truy van CSDL")
                }
                
                // Doc du lieu tu bien result
                if let result = result {
                    while result.next() {
                        let tenct = result.string(forColumn: CHITIEU_TENCT) ?? ""
                        let ngaytao = result.string(forColumn: CHITIEU_NGAYTAO) ?? ""
                        let sotien = result.int(forColumn: CHITIEU_SOTIEN)
                        
                        // Tao doi tuong meal tu CSDL
                        if let chitieu = ChiTieu(tenCT: tenct, ngayTao: ngaytao, soTien: Int(sotien)) {
                            // Dua vao datasource cua TableView
                            chitieus.append(chitieu)
                        }
                    }
                }
            }
        }
    }
    
    // 3. Sua thong tin chitieu vao CSDL
    func updateChiTieu(chitieu: ChiTieu) -> Bool {
        var OK = false
        if open() {
            
            if database!.tableExists(CHITIEU_TABLE_NAME) {
                // Cau lenh SQL
                let sql = "UPDATE \(CHITIEU_TABLE_NAME)"
                + " SET \(CHITIEU_NGAYTAO) = ?, \(CHITIEU_SOTIEN) = ? "
                + "WHERE \(CHITIEU_TENCT) = ?"
                
                // Sua du lieu chitieu
                if database!.executeUpdate(sql, withArgumentsIn: [chitieu.ngayTao, chitieu.soTien, chitieu.tenCT]) {
                    os_log("Sua du lieu thanh cong!")
                    OK = true;
                } else {
                    os_log("Sua du lieu khong thanh cong!")
                }
                // Dong CSDL
                close()
            }
            else {
                os_log("Bang du lieu chua ton tai!")
            }
        }
        return OK
    }
    
    // 4. Xoa thong tin chitieu vao CSDL
    func deleteChiTieu(chitieu: ChiTieu) -> Bool {
        var OK = false
        if open() {
            if database!.tableExists(CHITIEU_TABLE_NAME) {
                // Cau lenh SQL
                let sql = "DELETE FROM \(CHITIEU_TABLE_NAME) WHERE \(CHITIEU_TENCT) = ?"
                
                // Sua du lieu chitieu
                if database!.executeUpdate(sql, withArgumentsIn: [chitieu.tenCT]) {
                    os_log("Xoa du lieu thanh cong!")
                    OK = true;
                } else {
                    os_log("Xoa du lieu khong thanh cong!")
                }
                // Dong CSDL
                close()
                
            }
            else {
                os_log("Bang du lieu chua ton tai!")
            }
        }
        return OK
    }
    
}
