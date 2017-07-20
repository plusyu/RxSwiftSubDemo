//
//  Event.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

public enum Event<Element> {
    
    case next(Element)
    
    case error(Swift.Error)
    
    case completed
}


extension Event {

    public var isStopEvent: Bool {
        switch self {
        case .next: return false
        case .error, .completed: return true
        }
    }
    
    public var element: Element? {
        if case .next(let value) = self {
            return value
        }
        return nil
    }
    
    public var error: Swift.Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
    
    public var isCompleted: Bool {
        if case .completed = self {
            return true
        }
        return false
    }
}

extension Event {
    public func map<Result>(_ transform: (Element) throws -> Result) -> Event<Result> {
        do {
            switch self {
            case let .next(element):
                return .next(try transform(element))
            case let .error(error):
                return .error(error)
            case .completed:
                return .completed
            }
        }
        catch let e {
            return .error(e)
        }
    }
}

public protocol EventConvertible {
    
    associatedtype ElementType
    
    var event: Event<ElementType> { get }
}

extension Event : EventConvertible {

    public var event: Event<Element> {
        return self
    }
}

