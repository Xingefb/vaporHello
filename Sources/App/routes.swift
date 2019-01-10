import Vapor

struct User:Content {
    
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get("users") { req -> Future<Response> in
        return try req.content.decode(Todo.self).flatMap({ todo in
            return todo.save(on: req).map {_ in
                return req.redirect(to: "users")
            }
        })
    }
    
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("message") { req in
        return "info"
    }
    
    // if not add return flag String can return any
    router.get("users", Int.parameter) { req -> String in
        let id = try req.parameters.next(Int.self)
        return "requested id #\(id)"
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

