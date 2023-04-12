//
//  SQLiteDBController.swift
//  E-codes Checker App
//
//  Created by Oleksii Chumak on 06.01.2023.
//

import Foundation
import SQLite

func getInfo(by eCodeInput: String) -> ECodeInfoModel  { // find info by eCodeInput in db
    do {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first! // find path to db
        
        _ = copyDatabaseIfNeeded(sourcePath: Bundle.main.path(forResource: "eCodesDB", ofType: "db")!)
        
        let db = try Connection("\(path)/eCodesDB.db")// establish connection with db
        let eCodesTable = Table("eCodes")// show the exsisting
        
        // add rows
        //let iD = Expression<Int64>("ID")
        let eCode = Expression<String>("ECode")
        let name = Expression<String>("Name")
        let colorAndUsage = Expression<String>("ColorAndUsage")
        let status = Expression<String>("Status")
        
        let eCodeInfoModel = ECodeInfoModel() // model where we store the needed data from db
                       
        // find the info by eCodeInput in db
        for eCodeModel in try db.prepare(eCodesTable.select(eCode, name, colorAndUsage, status).filter(eCode == eCodeInput)) {
            eCodeInfoModel.eCode = eCodeModel[eCode]
            eCodeInfoModel.name = eCodeModel[name]
            eCodeInfoModel.descriptionColorAndUsage = eCodeModel[colorAndUsage]
            eCodeInfoModel.status = eCodeModel[status]
        }
        return eCodeInfoModel
        
    } catch {
        print(error)
        
    }
    return ECodeInfoModel()
}

func copyDatabaseIfNeeded(sourcePath: String) -> Bool {
    let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let destinationPath = documents + "/eCodesDB.db"
    let exists = FileManager.default.fileExists(atPath: destinationPath)
    guard !exists else { return false }
    do {
        try FileManager.default.copyItem(atPath: sourcePath, toPath: destinationPath)
        return true
    } catch {
      print("error during file copy: \(error)")
        return false
    }
}
