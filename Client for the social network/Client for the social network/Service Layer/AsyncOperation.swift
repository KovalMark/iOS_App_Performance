import UIKit
import Alamofire

class AsyncOperation: Operation {
    
    // Собственное свойство состояний, которое будет возвращать стандартные флаги
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    // Необходимо, чтобы класс Operation был совместим с механизмом KVO из Objective-C
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    // Чтобы операция стала асинхронной
    override var isAsynchronous: Bool {
        return true
    }
    
    // Теперь учитывается и предопределённое свойство isReady, и состояние операции, которое устанавливает ему очередь и значение.
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    // Так мы сами сможем управлять состоянием операции, меняя значение свойства state. А стандартные флаги, переопределённые нами, будут возвращать это состояние. Теперь, пока мы сами не завершим операцию, присвоив значение finish свойству state, она не завершится.
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    // Изменению подвергается и метод start, который очередь вызывает при начале выполнения операции. Проверяем, не была ли отменена операция еще до начала выполнения.
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}
