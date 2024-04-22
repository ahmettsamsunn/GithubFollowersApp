//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 18.04.2024.
//

import Foundation
enum ErrorMessage : String,Error {
    case invalidUsername = "Girdiğiniz kullanıcı adına sahip bir kullanıcı bulunamadı.Lütfen tekrar deneyiniz"
    case unableToComplete = "İsteğiniz tamamlanamadı.Lütfen internet bağlantınızı kontrol ediniz"
    case invalidResponse = "Geçersiz cevap.Lütfen tekrar deneyiniz"
    case invalidData = "Gelen datalar geçersiz.Lütfen tekrar deneyiniz."
}
