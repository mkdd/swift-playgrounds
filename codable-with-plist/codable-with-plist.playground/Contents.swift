import UIKit
import PlaygroundSupport

/*
 Playfround for loading and storing objects via codable in plist
 
 @see: Load plist in playground: https://medium.com/@vhart/read-write-and-delete-file-handling-from-xcode-playground-abf57e445b4
 
 */


struct StoredData: Codable {
    
    var itemId: String
    var countObjects: Int
    var testable: Bool
}

func store(data: StoredData) {
    
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    
    let urlToFile = playgroundSharedDataDirectory.appendingPathComponent("StoredData.plist")
    
    do {
        let data = try encoder.encode(data)
        try data.write(to: urlToFile)

    } catch {
        print("error on writing file: \(error)")
    }
    
}


func read() -> StoredData? {
    let pathAsUrl = playgroundSharedDataDirectory.appendingPathComponent("StoredData.plist")
    
    do {
        let data = try Data(contentsOf: pathAsUrl)
        let storedData = try PropertyListDecoder().decode(StoredData.self, from: data)
        print(storedData)
        return storedData
        
    } catch  {
        print("error on reading data: \(error)")
    }
    
    print("no data found")
    return nil

}


let data = StoredData(itemId: "customId", countObjects: 5, testable: false)
store(data: data)

let dataFromPlist = read()
print("loaded data \n \(String(describing: dataFromPlist))")
