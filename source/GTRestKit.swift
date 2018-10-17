//
//  GTRestKit.swift
//
//  Created by Gabriel Theodoropoulos.
//
//  MIT License
//  Copyright © 2018 Gabriel Theodoropoulos
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


import UIKit


// MARK: - GTRKHTTPMethod

/// The provided HTTP methods by GTRestKit.
///
/// Here's the list of the provided HTTP methods.
///
/// - GET
/// - POST
/// - PUT
/// - PATCH
/// - DELETE
///
/// If the method you want to use does not exist, then feel free to add it
/// to this enum in accordance to the existing cases.
enum GTRKHTTPMethod {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    
    
    /// It returns the name of the HTTP method as a string.
    ///
    /// - Returns: The name of the HTTP method.
    func getName() -> String {
        if self == .GET {
            return "GET"
        } else if self == .POST {
            return "POST"
        } else if self == .PUT {
            return "PUT"
        } else if self == .PATCH {
            return "PATCH"
        } else if self == .DELETE {
            return "DELETE"
        } else {
            return ""
        }
    }
}




// MARK: - GTRKResponseContentType

/// The content type of the response for common cases.
enum GTRKResponseContentType {
    /// Text-related content types, such as text/plain, text/html, text/css, etc.
    case textBased
    
    /// application/json Content-Type
    case applicationJSON
}




// MARK: - GTRKCommonRequestHeaders

/// A list of common request headers provided for conveniency.
///
/// If you want to use a header that is not present here,
/// then feel free to add it so you can conveniently access it in the future,
/// or just provide it directly to the `requestHeaders` property or to the
/// `add(requestHeader:withValue:)` method.
///
/// Example:
/// ```
/// let restKit = GTRestKit()
/// restKit.add(requestHeader: GTRKCommonRequestHeaders.contentType.rawValue,
///             withValue: GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue)
///
/// // or
/// restKit.requestHeaders[GTRKCommonRequestHeaders.contentType.rawValue] = GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue
/// ```
///
/// Available header keys:
///
/// - contentType: Content-Type
/// - authorizationBearer: Authorization
/// - accept: Accept
/// - acceptLanguage: Accept-Language
/// - acceptCharset: Accept-Charset
/// - keepAlive: Keep-Alive
/// - cacheControl: Cache-Control
enum GTRKCommonRequestHeaders: String {
    /// Content-Type
    case contentType = "Content-Type"
    
    /// Authorization
    case authorizationBearer = "Authorization"
    
    /// Accept
    case accept = "Accept"
    
    /// Accept-Language
    case acceptLanguage = "Accept-Language"
    
    /// Accept-Charset
    case acceptCharset = "Accept-Charset"
    
    /// Keep-Alive
    case keepAlive = "Keep-Alive"
    
    /// Cache-Control
    case cacheControl = "Cache-Control"
}




// MARK: - GTRKCommonRequestHeaderValues

/// A list of common request header values provided for conveniency.
///
/// If you want to use a header value that is not present here,
/// then feel free to add it so you can conveniently access it in the future,
/// or just provide it directly to the `requestHeaders` property or to the
/// `add(requestHeader:withValue:)` method.
///
/// Example:
/// ```
/// let restKit = GTRestKit()
/// restKit.add(requestHeader: GTRKCommonRequestHeaders.contentType.rawValue,
///             withValue: GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue)
///
/// // or
/// restKit.requestHeaders[GTRKCommonRequestHeaders.contentType.rawValue] = GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue
/// ```
///
/// Available values:
///
/// - contentTypeTextPlain: text/plain; charset=utf-8
/// - contentTypeTextHTML: text/html charset=utf-8
/// - contentTypeApplicationJSON: application/json
/// - cacheControlNoCache: no-cache
enum GTRKCommonRequestHeaderValues: String {
    /// text/plain; charset=utf-8
    case contentTypeTextPlain = "text/plain; charset=utf-8"
    
    /// text/html charset=utf-8
    case contentTypeTextHTML = "text/html charset=utf-8"
    
    /// application/json
    case contentTypeApplicationJSON = "application/json"
    
    /// no-cache
    case cacheControlNoCache = "no-cache"
}




// MARK: - GTRKMimeTypes

/// Some common mime types the can be used for conveniency.
///
/// - textPlain: text/plain
/// - textHTML: text/html
/// - textCSS: text/css
/// - textCSV: text/csv
/// - imageJPEG: image/jpeg
/// - imagePNG: image/png
/// - imageGIF: image/gif
/// - audioWAV: audio/wav
/// - audioOGG: audio/ogg
/// - videoOGG: video/ogg
/// - videoMPEG: video/mpeg
/// - applicationOGG: application/ogg
/// - applicationPDF: application/pdf
/// - applicationRTF: application/rtf
/// - applicationZIP: applization/zip
/// - applicationJSON: application/json
/// - applicationOctetStream: application/octet-stream
/// - applicationJavascript: application/javascript
/// - applicationXML: application/xml
enum GTRKMimeTypes: String {
    /// text/plain
    case textPlain = "text/plain"
    
    /// text/html
    case textHTML = "text/html"
    
    /// text/css
    case textCSS = "text/css"
    
    /// text/csv
    case textCSV = "text/csv"
    
    /// image/jpeg
    case imageJPEG = "image/jpeg"
    
    /// image/png
    case imagePNG = "image/png"
    
    /// image/gif
    case imageGIF = "image/gif"
    
    /// audio/wav
    case audioWAV = "audio/wav"
    
    /// audio/ogg
    case audioOGG = "audio/ogg"
    
    /// video/ogg
    case videoOGG = "video/ogg"
    
    /// video/mpeg
    case videoMPEG = "video/mpeg"
    
    /// application/ogg
    case applicationOGG = "application/ogg"
    
    /// application/pdf
    case applicationPDF = "application/pdf"
    
    /// application/rtf
    case applicationRTF = "application/rtf"
    
    /// application/zip
    case applicationZIP = "applicaton/zip"
    
    /// application/json
    case applicationJSON = "application/json"
    
    /// application/octet-stream
    case applicationOctetStream = "application/octet-stream"
    
    /// application/javascript
    case applicationJavascript = "application/javascript"
    
    /// application/xml
    case applicationXML = "application/xml"
}





// MARK: - GTRKTypeConverter

/// A struct that provides methods to convert between dictionary, JSON and string values.
///
/// Available methods:
///
/// - `toDictionary(fromJSON:)`
/// - `toJSON(fromDictionary:)`
/// - `toString(fromJSON:)`
struct GTRKTypeConverter {
    static let shared = GTRKTypeConverter()
    
    func toDictionary(fromJSON json: Data) -> [String: Any]? {
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: json, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] {
                return dictionary
            }
        }
        catch {
            print(error)
        }
        
        return nil
    }
    
    
    func toJSON(fromDictionary dictionary: [String: Any]) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [JSONSerialization.WritingOptions.prettyPrinted, JSONSerialization.WritingOptions.sortedKeys])
            return jsonData
        }
        catch {
            print(error)
        }
        
        return nil
    }
    
    
    func toString(fromJson json: Data) -> String? {
        if let stringRepresentation = String(data: json, encoding: String.Encoding.utf8) {
            // Remove all "\n" characters from the string representation.
            let stripped = stringRepresentation.replacingOccurrences(of: "\n", with: "")
            return stripped
        }
        
        return nil
    }
    
}




// MARK: - GTRKFileInfo

/// A struct containing properties which keep data about a file that should be uploaded.
///
/// Note that all properties should have a value. Files described by `GTRKFileInfo`
/// objects with missing values in their properties won't be uploaded.
struct GTRKFileInfo {
    /// The actual file contents as a `Data` object.
    var fileContent: Data?
    
    /// The mime type of the file.
    var mimetype: String?
    
    /// The name of the file.
    var filename: String?
}





// MARK: - GTRestKit

/// A lightweight but powerful library for making HTTP requests and consuming RESTful APIs.
class GTRestKit: NSObject, URLSessionTaskDelegate {
    
    // MARK: - Properties
    
    /// The collection of the request headers that should be provided before making a HTTP request.
    ///
    /// To add request headers to a request, either access this dictionary directly, or use the
    /// `add(requestHeader:withValue:)` method.
    var requestHeaders = [String: String]()
    
    /// The HTTP status code of the last made request.
    var httpStatusCode: Int?
    
    /// The character set allowed in a URL string.
    ///
    /// The following characters are not allowed:
    ///
    /// =\"#%/<>?@\\^`{|}+ (space character included)
    fileprivate let customAllowedSet =  CharacterSet(charactersIn:"=\"#%/<>?@\\^`{|}+ ").inverted
    
    /// The content type of the response.
    ///
    /// This property gets its value automatically when the server sends a response back.
    /// It's used for the most common content types.
    var responseContentType: GTRKResponseContentType?
    
    /// The URL that a request is made to.
    var url: URL?
    
    /// The response coming from the server as a `URLResponse` object.
    ///
    /// It would be also useful to convert it and use it as a `HTTPURLResponse` object instead:
    ///
    /// ```
    /// if let response = response as? HTTPURLResponse { ... }
    /// ```
    var response: URLResponse?
    
    
    
    // MARK: - Init
    
    override init() {
        super.init()
    }
    
    
    
    
    // MARK: - Fileprivate Methods
    
    /// It performs the actual request using the parameter values given to it.
    ///
    /// - Parameters:
    ///   - url: The request URL. Any URL parameters are included.
    ///   - httpMethod: The HTTP method to use.
    ///   - body: The HTTP body of the request, if exists.
    ///   - completionHandler: The completion handler returning either the results coming from the server, or an error object in case something bad happens.
    fileprivate func performRequest(toURL url: URL, usingHTTPMethod httpMethod: GTRKHTTPMethod, body: Data?, completionHandler: @escaping ((_ results: Any?, _ error: Error?) -> Void)) {
        
        // Initialize a URLRequest object to make the HTTP request.
        var request: URLRequest! = URLRequest(url: url)
        
        // Set the chosen HTTP method's name to the request.
        request.httpMethod = httpMethod.getName()
        
        // Add any request headers.
        for (key,value) in requestHeaders {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Add the HTTP body (if exists).
        if let httpBody = body {
            request.httpBody = httpBody
        }
        
        
        // Instantiate a session configuration object.
        let sessionConfiguration = URLSessionConfiguration.default
        
        // Initialze a new URLSession object.
        let session = Foundation.URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
        
        // Instantiate a data task using the above session object and make the request.
        let task = session.dataTask(with: request) { (data, response, error) in
            // Keep the response.
            self.response = response
            
            // Get the HTTP status code from the response, if the response is not nil.
            if let httpResponse = response as? HTTPURLResponse {
                // Keep the response HTTP status code.
                self.httpStatusCode = httpResponse.statusCode
            }
            
            // Check if an error occurred.
            if let error = error {
                NSLog("[GTRestKit] An error occurred on HTTP request:")
                NSLog("%@", error.localizedDescription)
                completionHandler(nil, error)
            } else {
                // Get the returned data (if exists).
                if let data = data {
                    if let response = response as? HTTPURLResponse {
                        // Search for and get the content type of the response.
                        var contentType: String?
                        for (key, value) in response.allHeaderFields {
                            if (key as! String).contains("Content-Type") {
                                contentType = value as? String
                                break
                            }
                        }
                        
                        // Make sure that the content type was found.
                        if let contentType = contentType {
                            var results: Any?
                            
                            if contentType.contains("text/") {
                                // The returned data is text based.
                                results = GTRKTypeConverter.shared.toString(fromJson: data)
                                self.responseContentType = GTRKResponseContentType.textBased
                            } else if contentType.contains("application/json") {
                                // The returned data is JSON data.
                                results = GTRKTypeConverter.shared.toDictionary(fromJSON: data)
                                self.responseContentType = GTRKResponseContentType.applicationJSON
                            } else {
                                NSLog("[GTRestKit] Unable to determine how to convert received data.")
                            }
                            
                            // Call the completion handler.
                            completionHandler(results, nil)
                            
                        } else {
                            NSLog("[GTRestKit] No Content-Type header was found on the response, unable to determine how to convert received data.")
                        }
                    }
                    
                } else {
                    NSLog("[GTRestKit] No data returned")
                    completionHandler(nil, nil)
                }
            }
            
            request = nil
        }
        
        // Clear the following properties before proceeding.
        response = nil
        responseContentType = nil
        
        // Resume the task.
        task.resume()
        
    }
    
    
    
    
    
    
    /// It creates a custom error object.
    ///
    /// The `userInfo` dictionary of the custom error contains the HTTP status code of the request,
    /// and optionally a message coming from the server, if that message exists in the results coming back
    /// from the server.
    ///
    /// In case the `httpStatusCode` property is `nil`, then 0 is used as the default value.
    ///
    /// - Parameter results: The results coming from the server that possibly contain an error message.
    /// - Returns: A custom `Error` object.
    fileprivate func getError(getMessageFromResults results: Any?) -> Error {
        var userInfo: [String: Any] = ["HTTPStatusCode": self.httpStatusCode ?? 0]
        if let message = results as? String {
            userInfo["message"] = message
        }
        
        return NSError(domain: "GTRestKitErrorDomain", code: 0, userInfo: userInfo)
    }
    
    
    
    /// Append URL query parameters to a URL string.
    ///
    /// - Parameters:
    ///   - urlParams: The parameters to append to the query in the form: 'http:...?param1=val1&param2=val2&...'.
    ///   - url: The URL of the request.
    /// - Returns: A `URL` object in case the parameters have been appended successfuly to the original URL string, or nil if that fails.
    fileprivate func add(urlParams: [String: String], toURL url: String) -> URL? {
        // Begin by appending the "?" symbol to the url string.
        var urlString = url + "?"
        
        // Make a loop to add each URL parameter one by one.
        var paramsCounter = 0
        for (key, value) in urlParams {
            urlString += "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: customAllowedSet) ?? "")"
            
            // Make sure to add the "&" symbol to the url string if there are still more parameters to come.
            paramsCounter += 1
            if paramsCounter < urlParams.count {
                urlString += "&"
            }
        }
        
        // Create again the URL using the new url string that contains the query parameters.
        if let updatedURL = URL(string: urlString) {
            return updatedURL
        }
        
        return nil
    }
    
    
    
    /// Append a string value to a Data object.
    ///
    /// - Parameters:
    ///   - string: The string to be appended.
    ///   - toData: The data object.
    /// - Returns: An updated data object that includes the string converted to data too.
    fileprivate func append(string: String, toData: Data) -> Data {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) {
            var updatedData = toData
            updatedData.append(data)
            return updatedData
        }
        
        return toData
    }
    
    
    
    // MARK: - Public Methods
    
    /// A convenient method for adding headers to the HTTP request.
    ///
    /// Use this method if you don't want to add request headers to the `requestHeaders` property manually.
    /// Simply provide the header name and the value as arguments.
    ///
    /// To make it even easier, you can use the `GTRKCommonRequestHeaders` and `GTRKCommonRequestHeaderValues` enum values
    /// for adding common headers and values to the `requestHeaders` property.
    ///
    /// Make sure that you always provide request headers prior to making the HTTP request.
    ///
    /// Example:
    /// ```
    /// let restKit = GTRestKit()
    /// restKit.add(requestHeader: GTRKCommonRequestHeaders.contentType.rawValue,
    ///             withValue: GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue)
    ///
    /// // ...or by setting the actual values...
    /// restKit.add(requestHeader: "Content-Type",
    ///             withValue: "application/json")
    /// ```
    ///
    /// - Parameters:
    ///   - header: The request header key.
    ///   - value: The request header value.
    func add(requestHeader header: String, withValue value: String) {
        if header == GTRKCommonRequestHeaders.authorizationBearer.rawValue {
            requestHeaders[header] = "Bearer " + value
        } else {
            requestHeaders[header] = value
        }
    }
    
    
    
    
    /// Use this method to perform an HTTP request.
    ///
    /// Before calling this method you would probably want to specify some request headers. To do that,
    /// you can use the `requestHeaders` dictionary directly by setting the headers and their respective values as follows:
    ///
    /// ```
    /// let restKit = GTRestKit()
    /// restKit.requestHeaders["Content-Type"] = "application/json"
    /// ```
    ///
    /// Alternatively, you could use the `add(requestHeader:withValue:)` convenient method provided:
    ///
    /// ```
    /// let restKit = GTRestKit()
    /// restKit.add(requestHeader: "Content-Type", withValue: "application/json")
    /// ```
    ///
    /// For greater flexibility, you could also use the `GTRKCommonRequestHeaders` and `GTRKCommonRequestHeaderValues` enums
    /// which both contain some common request headers and their values.
    ///
    /// In case of an error when performing an HTTP request, the `results` in the completion handler remains nil, while the `error` object
    /// indicates the problem. The error can be a custom one generated by GTRestKit when the request doesn't return an HTTP status code
    /// ranging from 200 to 299, and it can potentialy include a message coming from the server too.
    ///
    /// The `results` object in the completion handler is an `Any` object. If you know the actual datatype expected to be returned,
    /// then cast to that datatype instantly:
    ///
    /// ```
    /// if let dict = results as? [String: Any] { ... }
    /// ```
    ///
    /// If you're unsure about the server results in case the server returns multiple result types (JSON, plain text, etc),
    /// then you could use the `responseContentType` property in case the results type has been recongized automatically. Here's an example:
    ///
    /// ```
    /// if let contentType = restKit.responseContentType {
    ///     if contentType == GTRKResponseContentType.textPlain || contentType == GTRKResponseContentType.textHTML {
    ///         print(results as! String)
    ///     } else if contentType == GTRKResponseContentType.applicationJSON {
    ///         print(results as! [String:  Any])
    ///     }
    /// }
    /// ```
    ///
    /// Lastly, you cannot use this method to upload files. To do so, see the `uploadFiles(toURL:usingHTTPMethod:urlParams:bodyParams:filesInfo:completionHandler:)` method.
    ///
    /// - Parameters:
    ///   - url: The request URL (endpoint) as a string value.
    ///   - httpMethod: The HTTP method (GET, POST, etc) to use in the request. See the `GTRKHTTPMethod` for more information.
    ///   - urlParams: Any query parameters you want to pass along with the request through the URL.
    ///   - bodyParams: Any body parameters you want to send along with the request. These parameters are sent as JSON object.
    ///   - completionHandler: A completion handler that includes the results from the server in case everything ran smoothly and no error exists, and an error object in case something bad happens.
    func makeRequest(toURL url: String, usingHTTPMethod httpMethod: GTRKHTTPMethod, urlParams: [String: String]?, bodyParams: [String: Any]?, completionHandler: @escaping (_ results: Any?, _ error: Error?) -> Void) {
        
        // Initialize a URL object from the url string parameter value.
        var targetURL = URL(string: url)
        
        // Check if there are query parameters that should be appended to the URL.
        if let urlParams = urlParams {
            if urlParams.count > 0 {
                // There are URL parameters to add.
                targetURL = add(urlParams: urlParams, toURL: url)
            }
        }
        
        // Keep the URL to the url class property in case it's necessary to access it.
        self.url = targetURL
        
        
        // Check if there's body data to be send along with the request.
        var body: Data?
        if let bodyParams = bodyParams {
            // Convert the body parameters to JSON data.
            body = GTRKTypeConverter.shared.toJSON(fromDictionary: bodyParams)
            
            // Check if the content type "application/json" has been added to the request headers.
            // If not, add it now.
            if requestHeaders["Content-Type"] == nil {
                requestHeaders[GTRKCommonRequestHeaders.contentType.rawValue] = GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue
            }
            
        }
        
        
        // Perform the request if the targetURL is a valid URL object and not nil.
        if let targetURL = targetURL {
            // Call the following method to perform the request.
            performRequest(toURL: targetURL, usingHTTPMethod: httpMethod, body: body) { (results, error) in
                if let httpStatusCode = self.httpStatusCode {
                    // In case of 2XX HTTP status code, then call the completion handler and pass the results.
                    // Also pass the error even though it's going to be nil by default.
                    if (200...299).contains(httpStatusCode) {
                        completionHandler(results, error)
                    } else {
                        // The HTTP status code is other than 200 or 201.
                        // Check if there's an error coming by performing the request.
                        if let error = error {
                            // In this case call the completion handler and pass nil for the results, and the
                            // error coming by performing the request.
                            completionHandler(nil, error)
                        } else {
                            // No error was created by performing the request.
                            // Generate a custom one using the HTTP status code (if exists), and any
                            // potential message that might exist in the results that is coming from the server.
                            completionHandler(nil, self.getError(getMessageFromResults: results))
                        }
                    }
                }
            }
        } else {
            // Call the completion handler and create a custom error object.
            completionHandler(nil, NSError(domain: "GTRestKitErrorDomain", code: 0, userInfo: ["message": "Wrong URL format: '\(url)'"]))
        }
    }
    
    
    
    /// Use this method to perform an HTTP request and upload one or more files to the server.
    ///
    /// Your request can include URL parameters or body parameters as well that will be sent along with the files.
    ///
    /// To include a file in your request, you must initialize and use a `GTRKFileInfo` object:
    ///
    /// ```
    /// var fileInfo = GTRKFileInfo()
    /// if let path = Bundle.main.path(forResource: "car", ofType: "png") {
    ///     fileInfo.fileContent = try? Data(contentsOf: URL(fileURLWithPath: path))
    ///     fileInfo.mimetype = GTRKMimeTypes.imagePNG.rawValue
    ///     fileInfo.filename = "car.png"
    /// }
    /// ```
    ///
    /// If any of the properties shown in the snippet above is nil, the file won't be uploaded.
    ///
    /// To include that file to the request, simply provide it as an argument to this method, but always as an array item,
    /// even if you're uploading just one file:
    ///
    /// ```
    /// restKit.uploadFiles(toURL: SOME_URL, usingHTTPMethod: .POST, urlParams: nil, bodyParams: nil, filesInfo: [fileInfo]) { (results, error) in
    ///     ...
    /// }
    /// ```
    ///
    /// All the above apply when uploading multiple files too. Regarding the *mimetype* property, you can either set it directly:
    ///
    /// ```
    /// fileInfo.mimetype = "image/png"
    /// ```
    ///
    /// or you can use the `GTRKMimeTypes` enum and pick a value from there:
    ///
    /// ```
    /// fileInfo.mimetype = GTRKMimeTypes.imagePNG.rawValue
    /// ```
    ///
    /// For more information, see the `GTRKMimeTypes` enum.
    ///
    /// Also, for more general details about using this method, see the documentation of the
    /// `makeRequest(toURL:usingHTTPMethod:urlParams:bodyParams:completionHandler:)` method
    /// which is quite similar.
    ///
    /// - Parameters:
    ///   - url: The request URL (endpoint) as a string value.
    ///   - httpMethod: The HTTP method (GET, POST, etc) to use in the request. See the `GTRKHTTPMethod` for more information.
    ///   - urlParams: Any query parameters you want to pass along with the request through the URL.
    ///   - bodyParams: Any body parameters you want to send along with the request. These parameters are sent as JSON object.
    ///   - filesInfo: A collection of `GTRKFileInfo` objects regarding the file or files that should be uploaded to the server.
    ///   - completionHandler: A completion handler that includes the results from the server in case everything ran smoothly and no error exists, and an error object in case something bad happens.
    func uploadFiles(toURL url: String, usingHTTPMethod httpMethod: GTRKHTTPMethod, urlParams: [String: String]?, bodyParams: [String: Any]?, filesInfo: [GTRKFileInfo], completionHandler: @escaping (_ results: Any?, _ error: Error?) -> Void) {
        
        // Initialize a URL object from the url string parameter value.
        var targetURL = URL(string: url)
        
        // Check if there are query parameters that should be appended to the URL.
        if let urlParams = urlParams {
            if urlParams.count > 0 {
                // There are URL parameters to add.
                targetURL = add(urlParams: urlParams, toURL: url)
            }
        }
        
        // Keep the URL to the url class property in case it's necessary to access it.
        self.url = targetURL
        
        
        
        // Specify the boundary.
        let boundary = "------------------------------------------------------boundary\(Int(Date.timeIntervalSinceReferenceDate))"
        
        // Add the multipart/form-data content type and the boundary to the request headers.
        requestHeaders["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        
        // Initialize a Data object.
        var body = Data()
        
        // Add the body parameters to the body object that was initialized right above.
        if let bodyParams = bodyParams {
            for (key, value) in bodyParams {
                body = append(string: "--\(boundary)\r\n", toData: body)
                body = append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n", toData: body)
                body = append(string: "\(value)\r\n", toData: body)
            }
        }
        
        // Add the files info to the body as they exist in the filesInfo array.
        for file in filesInfo {
            if let filename = file.filename, let content = file.fileContent, let mimetype = file.mimetype {
                body = append(string: "--\(boundary)\r\n", toData: body)
                body = append(string: "Content-Disposition: form-data; name=\"\(filename)\"; filename=\"\(filename)\"\r\n", toData: body)
                body = append(string: "Content-Type: \(mimetype)\r\n\r\n", toData: body)
                body.append(content)
                body = append(string: "\r\n", toData: body)
            }
        }
        
        // Close the body.
        body = append(string: "\r\n--\(boundary)--\r\n", toData: body)
        
        
        // Perform the request if the targetURL is a valid URL object and not nil.
        if let targetURL = targetURL {
            // Call the following method to perform the request.
            performRequest(toURL: targetURL, usingHTTPMethod: httpMethod, body: body) { (results, error) in
                if let httpStatusCode = self.httpStatusCode {
                    // In case of 2XX HTTP status code, then call the completion handler and pass the results.
                    // Also pass the error even though it's going to be nil by default.
                    if (200...299).contains(httpStatusCode) {
                        completionHandler(results, error)
                    } else {
                        // The HTTP status code is other than 200 or 201.
                        // Check if there's an error coming by performing the request.
                        if let error = error {
                            // In this case call the completion handler and pass nil for the results, and the
                            // error coming by performing the request.
                            completionHandler(nil, error)
                        } else {
                            // No error was created by performing the request.
                            // Generate a custom one using the HTTP status code (if exists), and any
                            // potential message that might exist in the results that is coming from the server.
                            completionHandler(nil, self.getError(getMessageFromResults: results))
                        }
                    }
                }
            }
        } else {
            // Call the completion handler and create a custom error object.
            completionHandler(nil, NSError(domain: "GTRestKitErrorDomain", code: 0, userInfo: ["message": "Wrong URL format: '\(url)'"]))
        }
    }
    
    
}


