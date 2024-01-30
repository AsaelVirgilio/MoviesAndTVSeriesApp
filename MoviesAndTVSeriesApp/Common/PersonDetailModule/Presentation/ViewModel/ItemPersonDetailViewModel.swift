//
//  ItemPersonDetailViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

struct ItemPersonDetailViewModel {
    private(set) var personDetail: PersonDetail
    
    var id: Int {
        personDetail.id
    }
    var name: String {
        personDetail.name
    }
    
    var biography: String {
        personDetail.biography ?? ""
    }
    
    var birthday: String {
        personDetail.birthday ?? ""
    }
    
    var placeOfBirth: String {
        personDetail.placeOfBirth ?? ""
    }
    
      
}
