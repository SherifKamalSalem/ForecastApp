//
//  Formatters.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 25/04/2023.
//

import Foundation

let dayFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd"
  return formatter
}()

let monthFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMMM"
  return formatter
}()
