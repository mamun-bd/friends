//
//  SPFileManager.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPFileManager: NSObject {
    
    private static let fileManager = SPFileManager()
    let directory = SPFileManager.defaultArtworkDirectory()
    
    class var shared: SPFileManager {
        return fileManager
    }
    
    class func defaultArtworkDirectory() -> String {
        
        var path = ""
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.last {
            path = "\(url.path)/SPArtowrks"
        }
        if !fileManager.fileExists(atPath: path) && path != ""  {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
            } catch _ {
            }
        }
        return path
        
    }
    
    func getImage(withURL urlString: String, withCompletion handler: @escaping (UIImage?) -> Void)  {
        
        if let url = URL.init(string: urlString) {
            
            let lastPathComponent = url.lastPathComponent
            let path = "\(directory)/\(lastPathComponent)"
            if FileManager.default.fileExists(atPath: path) == true {
                if let image = UIImage.init(contentsOfFile: path) {
                    handler(image)
                } else {
                    download(withURL: url, withLocalPath: path) { (image) in
                        handler(image)
                    }
                }
            } else {
                download(withURL: url, withLocalPath: path) { (image) in
                    handler(image)
                }
            }
            
        }
        
    }

    func download(withURL url:URL, withLocalPath path:String, withCompletion handler: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                try? data.write(to: URL.init(fileURLWithPath: path))
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        handler(image)
                    }
                } else {
                    handler(nil)
                }
            } else {
                handler(nil)
            }
        }
        
    }
    
}
