//
//  ProductViewModel.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

// MARK: - SearchViewModelDelegate protocol
protocol ProductViewModelDelegate {
    func loadProductSuccessfully()
    func failedToLoadProductList(error: NetworkError)
}

class ProductViewModel {
    
    // MARK: - Properties
    var delegate: ProductViewModelDelegate?
    var apiClient = APIClient()
    var productItems = [Product]()
    var filteredItems = [Product]()
    
    // Product:-
    
    func getProductList() {
        let productRequest = ProductRequest.getProductList
        apiClient.fetch(request: productRequest, basePath: NetworkConstant.ProductBase.url, keyDecodingStrategy: .useDefaultKeys) { (result: Result<[Product], NetworkError>) in
            switch result {
            case .success(let list):
                self.productItems = list
                self.filteredItems = list
                self.delegate?.loadProductSuccessfully()
            case .failure(let error):
                self.delegate?.failedToLoadProductList(error: error)
            }
        }
    }
    
    // This var retun the product items count
    var count: Int  {
        return self.filteredItems.count
    }
    
    // This function retturn product object for the given index.
    func getProduct(index: Int) -> Product{
        return filteredItems[index]
    }
    
    func filterObjectWith(category: String) {
        filteredItems = productItems.filter { $0.category == category }
    }
}

