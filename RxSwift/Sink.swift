//
//  Sink.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

class Sink<O : ObserverType>  {
    fileprivate let _observer: O

    init(observer: O) {
        _observer = observer
    }
    
    final func forwardOn(_ event: Event<O.E>) {
        _observer.on(event)
    }
    
    final func forwarder() -> SinkForward<O> {
        return SinkForward(forward: self)
    }

}

final class SinkForward<O: ObserverType>: ObserverType {
    typealias E = O.E
    
    private let _forward: Sink<O>
    
    init(forward: Sink<O>) {
        _forward = forward
    }
    
    final func on(_ event: Event<E>) {
        switch event {
        case .next:
            _forward._observer.on(event)
        case .error, .completed:
            _forward._observer.on(event)
        }
    }
}

