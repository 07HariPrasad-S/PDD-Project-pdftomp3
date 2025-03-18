//
//  Constants.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 08/02/25.
//

import Foundation

struct APIList {
    static let baseURL = "https://q694t46c-8000.inc1.devtunnels.ms/"
    static let login = baseURL + "Login"
    static let signup = baseURL + "Signup"
    static let otpRegister = baseURL + "verify"
    static let forgotpassword = baseURL + "sendotp"
    static let forgotverify = baseURL + "verifyotp"
    static let resetpassword = baseURL + "resetpassword"
    static let viewprofile = baseURL + "profile"
    static let editprofile = baseURL + "edit"
    static let deleteaccount = baseURL + "deleteprofile"
    static let choosevoice = baseURL + "Voice"
    static let uploadpdf = baseURL + "upload"
    static let fileslist = baseURL + "files"
    static let addfavorite = baseURL + "addfavorite"
    static let favorite = baseURL + "favorite"
    
}

class Constants {
    static var loginDataResponse: LoginData?
    static var lastUploadedPDF: UploadedPDFModel?
}
