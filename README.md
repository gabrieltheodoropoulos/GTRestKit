**GTRestKit** is a lightweight but powerful Swift library that lets you make HTTP requests in iOS and consume RESTful APIs in a modern, easy, and straightforward fashion. Tested extensively in real world applications and production, GTRestKit can become a really handy tool when dealing with web services, RESTful APIs and communication with servers. Rewritten with Swift 4.2 and with new features for convenient usage.

*View documentation for the GTRestKit library exported using Jazzy [here](https://gtiapps.com/docs/gtrestkit/index.html).*

## Installing GTRestKit

Installing GTRestKit can be done manually.

1.  Clone or download this repository.
2.  Go to the Source folder.
3.  Drag and drop the GTRestKit.swift file into your project.

## Testing GTRestKit - A demo server included

Any server providing RESTful APIs can be used to test GTRestKit. If you don't have any, there are many servers out there providing services for free. Take a look at [this big collection of public APIs](https://github.com/toddmotto/public-apis/blob/master/README.md).

However, a small test server is included in this project too. It's a Node.js implementation, and you can run it locally to test GTRestKit if you wish so. After you have fetched the project, you can find it in the *Server* folder. By default, the server listens to port 3000, but if you want to pick another port just edit the *index.js* file and go to the bottom end of it. To run the server, open the Terminal app, and then using the `cd` command navigate to the folder where the server implementation exists. To start it, just type:

```
node index.js
```

If you don't have the Node.js installed, read [this tutorial](https://blog.teamtreehouse.com/install-node-js-npm-mac) that can help you do so, or find something similar on the web. Alternatively, use the following URL, where this small server project runs on Heroku:

```
https://gtrestkit-demo-server.herokuapp.com
```

_(Just replace the `http://localhost:3000` with the above in the following examples or in the demo project)_

The endpoints you can use are:

*  `/testapi/getsimple`: A simple GET request that returns a success message only.
*  `/testapi/getwithqueryparams`: A GET request that accepts two query parameters in the URL and returns a JSON response with simple mathematical operations applied on the two parameters. Name the two parameters "a" and "b" *(example: `/testapi/getwithqueryparams?a=5&b=10`).*
*   `/testapi/postsimple`: A simple POST test request. It returns a JSON that includes the original posted data, and an HTTP status code 201.
*  `/testapi/postsinglefile`: A POST request that allows you to upload a single file, with our without other HTTP body values or URL query parameters. This endpoint returns just some specific metadata about the uploaded file formatted as JSON. The actual file is NOT stored or used by any other way.
*   `/testapi/uploadmultiplefiles`: A POST request similar to the previous one, but used to upload multiple files.

All the above endpoints will be used in the code examples that come next.

Other HTTP methods like PUT, PATCH or DELETE are used similarly to the demo GET or POST APIs, therefore the server does not provide an API for testing them.

## Using GTRestKit

To start using GTRestKit, initialise a GTRestKit object either locally inside a function, or globally as a class property.

```swift
let restKit = GTRestKit()
```

If you're planning on releasing that object later, then change the previous statement with this:

```swift
var restKit: GTRestKit! = GTRestKit()
```

That way, you can just make it nil when you no longer need it.

```swift
restKit = nil
```

The simplest way to use it after having initialised your GTRestKit object is to provide a URL as a string and the HTTP method you want to use:

```swift
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
```

After that, all you have to do is to handle the results in the completion handler, or the error if any exists. Note that the error is an `Error` object, that is either created by the system while trying to communicate with the server, or it's generated by GTRestKit itself.

`results` is an `Any` object, meaning that you have to cast it to the proper datatype before using it. The selection of the HTTP method to use in a request is made by using a custom enum integrated in the GTRestKit, called `GTRKHTTPMethod`. The available methods are:

*   GET
*   POST
*   PUT
*   PATCH
*   DELETE

In case you want to use an HTTP method not included in the above list, then just add it to the `GTRKHTTPMethod` enum in accordance to the existing values.

The URL in the request above belongs to the demo server implementation included in this project, running locally. When the server responds to that request, it sends the following text message back:

`This is the message of SUCCESS!`

### Providing URL query parameters

If you want to send URL query parameters along with your request, all you have to do is to provide a dictionary with the respective keys and values in the `urlParams` parameter of the `makeRequest(toURL:usingHTTPMethod:urlParams:bodyParams:completionHandler:)` method. The following example demonstrates that:

```swift
let urlParams = ["a": "5", "b": "10"]

restKit.makeRequest(toURL: "http://localhost:3000/testapi/getwithqueryparams",
                    usingHTTPMethod: .GET,
                    urlParams: urlParams,
                    bodyParams: nil) { (results, error) in

    if let results = results as? [String: Any] {
        print(results)
    }
}
```

**Important**: The `urlParams` parameter expects a `[String: String]` dictionary.

As shown in the two previous examples, we cast the `results` object to the appropriate datatype before using it. In case you are unsure however whether the server will reply with a JSON or a text content (which is quite often in case of error messages), GTRestKit can help you out determine that. There's a property called `responseContentType`, and based on its value you can determine whether server has sent a text based content, or a JSON content. See how we can use it by modifying the last example:

```swift
let urlParams = ["a": "5", "b": "10"]

restKit.makeRequest(toURL: "http://localhost:3000/testapi/getwithqueryparams",
                    usingHTTPMethod: .GET,
                    urlParams: urlParams,
                    bodyParams: nil) { (results, error) in

    if let contentType = restKit.responseContentType {
        if contentType == GTRKResponseContentType.textBased {
            print(results as! String)
        } else if contentType == GTRKResponseContentType.applicationJSON {
            print(results as! [String: Any])
        }
    }
}
```

`responseContentType` is of `GTRKResponseContentType` type, which is a custom enum included in the GTRestKit. At the time being, the distinguish is made only between text based (text/plain, text/html, etc) and JSON (application/json) response content types. In any other case the `responseContentType` property remains nil.

### Sending data using the HTTP request body

To send data to the server using the HTTP request body just provide a `[String: Any]` dictionary to the `bodyParams` parameter of the `makeRequest(toURL:usingHTTPMethod:urlParams:bodyParams:completionHandler:)` method. Here's an example:

```swift
let body: [String: Any] = ["name": "Clark", "lastname": "Kent", "hero": "Superman", "age": 25, "male": true]

restKit.makeRequest(toURL: "http://localhost:3000/testapi/postsimple",
                    usingHTTPMethod: .POST,
                    urlParams: nil,
                    bodyParams: body) { (results, error) in

    if let error = error {
        print(error)
    } else {
        if let results = results as? [String: Any] {
            print(results)
        }
    }
}
```

### Specifying request headers

GTRestKit provides a dictionary where you can add all the request headers you want to send along with the request, called `requestHeaders`. To add headers, there two ways available: You can set them straight to the `requestHeaders` dictionary:

```swift
restKit.requestHeaders["Content-Type"] = "application/json"
```

Or, you can use a convenient method provided by GTRestKit named `add(requestHeader:withValue:)`:

```swift
restKit.add(requestHeader: "Content-Type", withValue: "application/json")
```

**Important**: The Content-Type "application/json" is automatically added to the request headers in case you have omitted it or even if you don't set any headers at all when making HTTP requests that send data using the HTTP body.

GTRestKit can become more assistive when setting request headers by offering two other enums: `GTRKCommonRequestHeaders` and `GTRKCommonRequestHeaderValues`. Both of these contain some common header keys and values, so you don't have to remember their exact syntax and also to avoid typo errors. The following is a request that POSTs the data from the previous example, but this time the content type header is set manually based on whatever discussed on this part:

```swift
restKit.add(requestHeader: GTRKCommonRequestHeaders.contentType.rawValue,
            withValue: GTRKCommonRequestHeaderValues.contentTypeApplicationJSON.rawValue)

let body: [String: Any] = ["name": "Clark", "lastname": "Kent", "hero": "Superman", "age": 25, "male": true]

restKit.makeRequest(toURL: "http://localhost:3000/testapi/postsimple",
                    usingHTTPMethod: .POST,
                    urlParams: nil,
                    bodyParams: body) { (results, error) in

    if let error = error {
        print(error)
    } else {
        if let results = results as? [String: Any] {
            print(results)
        }
    }
}
```

### Uploading a single file

GTRestKit offers a different method to use when it's necessary to upload files, called `uploadFiles(toURL:usingHTTPMethod:urlParams:bodyParams:filesInfo:completionHandler:)`. It's quite similar to the `makeRequest(toURL:usingHTTPMethod:urlParams:bodyParams:completionHandler:)` method that has been demonstrated so far, but the key difference is an additional parameter value, the `filesInfo`. Before being able to upload a file, you must initialise a `GTRKFileInfo` object which describes the file to be uploaded, and populate values to its properties. `GTRKFileInfo` is a struct having three properties only:

1.  `fileContent`: The actual contents of the file (a Data object).
2.  `mimetype`: The mime type of the file.
3.  `filename`: the name of the file.

Let's say, for example, that you want to upload an image called _car.png_ to the server. Before doing that, you must initialise a `GTRKFileInfo` object and use it as shown below:

```swift
var fileInfo = GTRKFileInfo()

if let path = Bundle.main.path(forResource: "car", ofType: "png") {
    fileInfo.fileContent = try? Data(contentsOf: URL(fileURLWithPath: path))
    fileInfo.mimetype = GTRKMimeTypes.imagePNG.rawValue
    fileInfo.filename = "car.png"
}
```

The mime type is a string property, and you can assign a value directly to it. For convenience reasons though, GTRestKit provides the `GTRKMimeTypes` enum that contains a list of several common mime types, so you don't have to remember their exact syntax. If you want to avoid using it, then the following is perfectly acceptable too:

```swift
fileInfo.mimetype = "image/png"
```

After having initialised and configured the `GTRKFileInfo` object as shown above, you can pass it to the `uploadFiles(toURL:usingHTTPMethod:urlParams:bodyParams:filesInfo:completionHandler:)` method and make your request:

```swift
var fileInfo = GTRKFileInfo()
if let path = Bundle.main.path(forResource: "car", ofType: "png") {
    fileInfo.fileContent = try? Data(contentsOf: URL(fileURLWithPath: path))
    fileInfo.mimetype = GTRKMimeTypes.imagePNG.rawValue
    fileInfo.filename = "car.png"
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
```

**Important**: The `filesInfo` parameter expects an array of `GTRKFileInfo` objects.

Note that if any of the three properties of a `GTRKFileInfo` object is nil, then the file won't be uploaded.

As an additional remark, the _multipart/form-data_ content type is added automatically to the request headers, including the _boundary_ created on the fly each time the above method is used to upload files.

### Uploading multiple files

Uploading multiple files is quite similar to uploading a single file as described in the previous part. The only additional action required is to create more `GTRKFileInfo` objects that will describe each single file. Then, you append them to an array, and you pass the array as an argument to the `filesInfo` parameter. Here's an example that POSTs and uploads multiple files:

```swift
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
```

In the snippet above, each file is of different type, therefore a different mime type is used each time.

### More GTRestKit Highlights

Whatever described so far demonstrates the usage of the GTRestKit library. However, there's some additional information necessary to be noted down. Apart from the methods and properties presented up until now, GTRestKit also implements a few _fileprivate_ methods that work internally in the class. Unless you want to customise it, there's no real need to modify them. Additionally, there are three more public properties that you might find handy when making HTTP requests and especially when debugging:

1.  `httpStatusCode`: This is the HTTP status code (200, 201, 404, etc) of the last performed request.
2.  `url`: It's the final URL that the request is made to, after any URL query parameters have been appended to it.
3.  `response`: The URLResponse object that contains the response coming from the server. You might want to cast it to an HTTPURLResponse like that:

```swift
if let response = response as? HTTPURLResponse { ... }
```

Other than that, when using any of the two methods to make HTTP requests shown in the previous parts and the server's response contains an HTTP status code in the range from 200 to 299, then the result object of the completion handler has an actual value (not nil) if the server returns data. For any other HTTP status code, GTRestKit generates an `Error` object that contains the HTTP status code value, as well as any error message (text message) coming from the server. Lastly, even though the various features and possibilities of the GTRestKit were presented one by one, it's obvious that you can combine them when that makes sense. For instance, it's a common tactic to send additional data through the HTTP body of the request when uploading files to a server.
