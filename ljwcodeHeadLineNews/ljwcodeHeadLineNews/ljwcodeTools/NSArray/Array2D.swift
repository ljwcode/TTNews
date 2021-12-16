//
//  Array2D.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/10/9.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation

public struct Array2D<T>{
    public let columns : Int
    public let rows : Int
    fileprivate var array : [T]
    
    public init(columns:Int,rows:Int,initialValue:T){
        self.columns = columns
        self.rows = rows
        array = .init(repeating: initialValue, count: rows * columns)
    }
    
    public subscript(column:Int,row:Int) -> T{
        get {
          precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
          precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
          return array[row*columns + column]
        }
        set {
          precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
          precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
          array[row*columns + column] = newValue
        }
    }
}
