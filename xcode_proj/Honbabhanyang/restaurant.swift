//
//  restaurant.swift
//  Honbabhanyang
//
//  Created by hojun on 19/04/2018.
//  Copyright © 2018 hojun. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String;
    var region: Region;
    // menu
    //var genre: Genre;
    var phoneNumber: String;
    // location
    
    init(name: String, region: Region, phoneNumber: String){
        self.name = name;
        self.region = region;
        self.phoneNumber = phoneNumber;
    }
}

enum Region {
    case 사근동
    case 왕십리
    case 왕십리엔터식스
    case 한양대엔터식스및근처
    case 상왕십리
}

enum Genre {
    case 한식
    case 중국집
    case 치킨
    case 양식
    case 분식
    case 일식
    case 고기
    case 패스트푸드
}

func getRestaurant() -> [Restaurant] {
    return [
    Restaurant.init(name: "다시올치킨", region: .사근동, phoneNumber: "123123"),
    Restaurant.init(name: "Thai in Plate", region: .사근동,phoneNumber: "123123"),
    Restaurant.init(name: "일락", region: .왕십리, phoneNumber: "123123"),
    Restaurant.init(name: "자연별곡", region: .한양대엔터식스및근처, phoneNumber: "123123"),
    Restaurant.init(name: "악어떡볶이", region: .왕십리, phoneNumber: "123123"),
    Restaurant.init(name: "금계찜닭", region: .왕십리, phoneNumber: "123123"),
    Restaurant.init(name: "맥도날드", region: .한양대엔터식스및근처, phoneNumber: "123123"),
    Restaurant.init(name: "호남감자탕", region: .왕십리, phoneNumber: "123123"),
    Restaurant.init(name: "육앤샤", region: .왕십리, phoneNumber: "123123"),
    Restaurant.init(name: "금룡", region: .왕십리, phoneNumber: "123123")
]
}
