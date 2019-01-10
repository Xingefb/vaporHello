import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // your code here
    let client = try app.make(Client.self)
    let res = try client.get("http://baidu.com").wait()
    print("response log:", res.http.body) // Response

}

