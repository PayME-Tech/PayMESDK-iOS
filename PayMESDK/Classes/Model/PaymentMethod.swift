//
//  UserInfo.swift
//  PayMESDK
//
//  Created by HuyOpen on 9/29/20.
//  Copyright © 2020 PayME. All rights reserved.
//

import Foundation

class PaymentMethod {
    var methodId: Int!
    var type: String = ""
    var title: String = ""
    var label: String = ""
    var fee: Int!
    var minFee: Int!
    var dataWallet: WalletInformation?
    var dataLinked: LinkedInformation?
    var active: Bool!

    init(
        methodId: Int?,
        type: String,
        title: String,
        label: String,
        fee: Int,
        minFee: Int,
        dataWallet: WalletInformation?,
        dataLinked: LinkedInformation?,
        active: Bool
    ) {
        self.methodId = methodId
        self.type = type
        self.title = title
        self.label = label
        self.fee = fee
        self.minFee = minFee
        self.dataWallet = dataWallet
        self.dataLinked = dataLinked
        self.active = active
    }
}

