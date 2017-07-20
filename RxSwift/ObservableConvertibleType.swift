//
//  ObservableConvertibleType.swift
//  RxSwiftSubDemo
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yuxiang. All rights reserved.
//


public protocol ObservableConvertibleType {
    
    associatedtype E
    
    func asObservable() -> Observable<E>
}

