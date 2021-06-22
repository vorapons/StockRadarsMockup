//
//  IndicesList.swift
//  StockRadarsMockUp
//
//  Created by Vorapon Sirimahatham on 15/6/21.
//

import Foundation
import CoreData

struct IndiceList : Codable {
    
    var symbol : String
    var description : String
    var country : String
    var currency : String
}
// List of Indices for selection to add
// All support in API
let listJson = """
    [
        {
            "symbol": "AAX ",
            "description": "AEX ALL-SHARE ",
            "country": "Netherlands ",
            "currency": "EUR "
        },
        {
            "symbol": "AAXG ",
            "description": "AEX ALL-SHARE GR ",
            "country": "Netherlands ",
            "currency": "EUR "
        },
        {
            "symbol": "AEX ",
            "description": "AEX-INDEX ",
            "country": "Netherlands ",
            "currency": "EUR "
        },
        {
            "symbol": "AEX7L ",
            "description": "AEX X7 LEVERAGE NR ",
            "country": "Netherlands ",
            "currency": "EUR "
        },
        
        {
            "symbol": "AEXEW ",
            "description": "AEX EQUAL WEIGHT ",
            "country": "Netherlands ",
            "currency": "EUR "
        },
        {
            "symbol": "AEXGR ",
            "description": "AEX GR ",
            "country": "Netherlands ",
            "currency": "EUR "
        },
        {
            "symbol": "DJI ",
            "description": "Dow Jones Industrial Average ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJI2MN ",
            "description": "Dow Jones Industrial Average ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJT ",
            "description": "Dow Jones Transportation Averag ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAE ",
            "description": "Dow Jones U.S. Aerospace & Defe ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAF ",
            "description": "Dow Jones U.S. Delivery Service ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAG ",
            "description": "Dow Jones U.S. Asset Managers I ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAI ",
            "description": "Dow Jones U.S. Electronic Equip ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAL ",
            "description": "Dow Jones U.S. Aluminum Index ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAM ",
            "description": "Dow Jones U.S. Medical Equipmen ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAP ",
            "description": "Dow Jones U.S. Automobiles & Pa ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "DJUSAR ",
            "description": "Dow Jones U.S. Airlines Index ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "HCX ",
            "description": "S&P 500 Health Care ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "HSI ",
            "description": "HANG SENG INDEX ",
            "country": "Hong Kong ",
            "currency": "HKD "
        },
        {
            "symbol": "HT ",
            "description": "Habita Index ",
            "country": "Mexico ",
            "currency": "MXN "
        },
        {
            "symbol": "KQ100 ",
            "description": "Kosdaq 100 Index ",
            "country": "South Korea ",
            "currency": "KRW "
        },
        {
            "symbol": "KQ11 ",
            "description": "Kosdaq Composite Index ",
            "country": "South Korea ",
            "currency": "KRW "
        },
        {
            "symbol": "N225 ",
            "description": "Nikkei 225 ",
            "country": "Japan ",
            "currency": "JPY "
        },
        {
            "symbol": "NDX ",
            "description": "NASDAQ 100 ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "SPC ",
            "description": "S&P 500 ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "SP100 ",
            "description": "S&P 100 ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "SP1500 ",
            "description": "S&P Composite 1500 ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "SP400 ",
            "description": "S&P 400 ",
            "country": "United States ",
            "currency": "USD "
        },
        {
            "symbol": "STI ",
            "description": "STI Index ",
            "country": "Singapore ",
            "currency": "SGD "
        },
        {
            "symbol": "SZSC ",
            "description": "Shenzhen Component ",
            "country": "China ",
            "currency": "CNY "
        },
        {
            "symbol": "WLENV ",
            "description": "EN CDP E W EW D5% ",
            "country": "Netherlands ",
            "currency": "EUR "
        },
        {
            "symbol": "XSP ",
            "description": "S&P 500 MINI SPX OPTIONS INDEX ",
            "country": "United States of America ",
            "currency": "USD "
        },
    ]
"""


