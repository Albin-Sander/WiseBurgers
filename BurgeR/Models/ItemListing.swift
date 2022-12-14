//
//  ItemListing.swift
//  BurgeR
//
//  Created by Albin Sander on 2022-11-01.
//

import Foundation
import UIKit
import CoreLocation
import CloudKit
import SwiftUI

struct ItemListing {
    let recordId: CKRecord.ID?
    let name: String
    let author: String
    let stars: Int64
    let image: CKAsset
    let description: String
   
    
    
    init(recordId: CKRecord.ID? = nil, name: String, author: String, stars: Int64, image: CKAsset, description: String) {
        self.recordId = recordId
        self.name = name
        self.author = author
        self.stars = stars
        self.image = image
        self.description = description
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name, "stars": stars, "author": author, "description": description, "image": image]
    }
    
    static func fromRecord(_ record: CKRecord) -> ItemListing? {
        guard let name = record.value(forKey: "name") as? String, let author = record.value(forKey: "author") as? String, let stars = record.value(forKey: "stars") as? Int64, let image = record.value(forKey: "image") as? CKAsset, let description = record.value(forKey: "description") as? String
        else {
            return nil
        }
        guard let data = try? Data(contentsOf: (image.fileURL!)) else { return nil }
        guard let hej = UIImage(data: data) else { return nil }
        return ItemListing(recordId: record.recordID, name: name, author: author, stars: stars, image: image, description: description)
    }
}
