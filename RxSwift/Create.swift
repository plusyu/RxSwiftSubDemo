//
//  Create.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//

extension Observable {

    public static func create(_ subscribe: @escaping (AnyObserver<E>) -> Void) -> Observable<E> {
        return AnonymousObservable(subscribe)
    }
}

final fileprivate class AnonymousObservableSink<O: ObserverType> : Sink<O>, ObserverType {
    typealias E = O.E
    typealias Parent = AnonymousObservable<E>
    
    // state
    private var _isStopped = 0
    
    override init(observer: O) {
        super.init(observer: observer)
    }
    
    func on(_ event: Event<E>) {
        switch event {
        case .next:
            if _isStopped == 1 {
                return
            }
            forwardOn(event)
        case .error, .completed:
            forwardOn(event)
        }
    }
    
    func run(_ parent: Parent) -> Void {
        return parent._subscribeHandler(AnyObserver(self))
    }
}

    
final fileprivate class AnonymousObservable<Element> : Producer<Element> {
    typealias SubscribeHandler = (AnyObserver<Element>) -> Void
    
    let _subscribeHandler: SubscribeHandler
    
    init(_ subscribeHandler: @escaping SubscribeHandler) {
        _subscribeHandler = subscribeHandler
    }
    
    override func run<O : ObserverType>(_ observer: O) -> (Void) where O.E == Element {
        let sink = AnonymousObservableSink(observer: observer)
        sink.run(self)
    }
}


