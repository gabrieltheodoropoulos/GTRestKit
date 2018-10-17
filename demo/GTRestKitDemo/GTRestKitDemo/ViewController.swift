//
//  ViewController.swift
//  GTRestKitDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2018 Gabriel Theodoropoulos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var restKit = GTRestKit()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



    @IBAction func makeSimpleGetRequest(_ sender: Any) {
        restKit.makeRequest(toURL: "http://localhost:3000/testapi/getsimple",
                            usingHTTPMethod: .GET,
                            urlParams: nil,
                            bodyParams: nil) { (results, error) in
            if let error = error {
                print(error)
            } else {
                if let messageFromServer = results as? String {
                    print(messageFromServer)
                }
            }
        }
    }
    
    

    @IBAction func makeGetRequestWithParams(_ sender: Any) {
        let urlParams = ["a": "5", "b": "10"]
        
        restKit.makeRequest(toURL: "http://localhost:3000/testapi/getwithqueryparams",
                            usingHTTPMethod: .GET,
                            urlParams: urlParams,
                            bodyParams: nil) { (results, error) in
                                
            if let contentType = self.restKit.responseContentType {
                if contentType == GTRKResponseContentType.textBased {
                    print(results as! String)
                } else if contentType == GTRKResponseContentType.applicationJSON {
                    print(results as! [String: Any])
                }
            }
        }
    }

    
    @IBAction func makeSimplePostRequest(_ sender: Any) {
        restKit.add(requestHeader: GTRKCommonRequestHeaders.contentType.rawValue, withValue: GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue)
        
        let body: [String: Any] = ["name": "Clark", "lastname": "Kent", "hero": "Superman", "age": 25, "male": true]
        
        restKit.makeRequest(toURL: "http://localhost:3000/testapi/postsimple", usingHTTPMethod: .POST, urlParams: nil, bodyParams: body) { (results, error) in
            if let error = error {
                print(error)
            } else {
                if let results = results as? [String: Any] {
                    print(results)
                }
            }
        }
    }
    
    
    @IBAction func uploadSingleFile(_ sender: Any) {
        var fileInfo = GTRKFileInfo()
        if let path = Bundle.main.path(forResource: "beach", ofType: "jpg") {
            fileInfo.fileContent = try? Data(contentsOf: URL(fileURLWithPath: path))
            fileInfo.mimetype = GTRKMimeTypes.imageJPEG.rawValue
            fileInfo.filename = "beach.jpg"
        }
        
        
        restKit.uploadFiles(toURL: "http://localhost:3000/testapi/postsinglefile",
                            usingHTTPMethod: .POST,
                            urlParams: nil,
                            bodyParams: nil,
                            filesInfo: [fileInfo]) { (results, error) in
                                
            if let error = error {
                print(error)
            } else {
                if let results = results as? [String: Any] {
                    print(results)
                }
            }
        }
    }
    
    
    
    @IBAction func uploadMultipleFiles(_ sender: Any) {
        var pdfFile = GTRKFileInfo()
        if let path = Bundle.main.path(forResource: "dummy", ofType: "pdf") {
            pdfFile.fileContent = try? Data(contentsOf: URL(fileURLWithPath: path))
            pdfFile.mimetype = GTRKMimeTypes.applicationPDF.rawValue
            pdfFile.filename = "dummy.pdf"
        }
        
        var jpgFile = GTRKFileInfo()
        if let path = Bundle.main.path(forResource: "beach", ofType: "jpg") {
            jpgFile.fileContent = try? Data(contentsOf: URL(fileURLWithPath: path))
            jpgFile.mimetype = GTRKMimeTypes.imageJPEG.rawValue
            jpgFile.filename = "beach.jpg"
        }
        
        var txtFile = GTRKFileInfo()
        if let path = Bundle.main.path(forResource: "demo", ofType: "txt") {
            txtFile.fileContent = try? Data(contentsOf: URL(fileURLWithPath: path))
            txtFile.mimetype = GTRKMimeTypes.textPlain.rawValue
            txtFile.filename = "demo.txt"
        }
        
        let filesToUpload = [pdfFile, jpgFile, txtFile]
        
        restKit.uploadFiles(toURL: "http://localhost:3000/testapi/uploadmultiplefiles",
                            usingHTTPMethod: .POST,
                            urlParams: nil,
                            bodyParams: nil,
                            filesInfo: filesToUpload) { (results, error) in
                                
            if let error = error {
                print(error)
            } else {
                if let results = results as? [String: Any] {
                    print(results)
                }
            }
        }
    }
    
    
}

