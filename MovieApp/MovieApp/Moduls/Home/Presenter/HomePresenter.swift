import UIKit

protocol HomePresenterProtocol {
    init(
        view: HomeViewControllerProtocol,
        storageManager: StorageManagerProtocol,
        router: HomeRouterProtocol,
        networkingManager: NetworkingManager
    )
    var filmsData: [MovieCellModel] { get }
    var categoryData: [CatergoriesModel] { get }
    var categoriesFilmData: [PopularCategoryMovieCellModel] { get }
    func setUser()
    func showFavoritesScreen()
    func setSelections()
    
    var selections: [Collections.Collection] { get }
}

final class HomePresenter: HomePresenterProtocol {

    private weak var view: HomeViewControllerProtocol?
    private let dataSource: StorageManagerProtocol
    private let router: HomeRouterProtocol
    private let networkingManager: NetworkingManager
    
    var selections: [Collections.Collection] = []
    
    //MARK: - Mock data
    var filmsData = [
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
    ]
    
    var categoryData = [
        CatergoriesModel(name: "All"),
        CatergoriesModel(name: "Action"),
        CatergoriesModel(name: "Comedy"),
        CatergoriesModel(name: "Drama"),
        CatergoriesModel(name: "Horror"),
        CatergoriesModel(name: "Thriller"),
        CatergoriesModel(name: "Animation"),
    ]
    
    var categoriesFilmData = [
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
    ]
    
    init(view: HomeViewControllerProtocol, storageManager: StorageManagerProtocol, router: HomeRouterProtocol, networkingManager: NetworkingManager) {
        self.view = view
        self.dataSource = storageManager
        self.router = router
        self.networkingManager = networkingManager
        
        setSelections()
    }
    
    func setUser() {
        guard let user = dataSource.fetchUser() else { return }
        view?.setUserInfo(with: user)
    }
    
    func showFavoritesScreen() {
        router.showFavorites()
    }
    
    func setSelections() {
        networkingManager.getCollections { result in
            switch result {
                
            case .success(let collections):
                self.selections = collections.docs
                
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}
