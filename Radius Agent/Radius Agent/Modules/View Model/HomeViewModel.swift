
import Foundation

protocol HomeViewModelDelegate {
    func didReceiveHomeResponse(homeResponse: HomeResponseModel?)
}

struct HomeViewModel
{
    var delegate : HomeViewModelDelegate?

    func getHomeData()
    {
        let homeResource = HomeDataResource()
        homeResource.getHomeData { (homeApiResponse) in
            DispatchQueue.main.async {
                self.delegate?.didReceiveHomeResponse(homeResponse: homeApiResponse)
            }
        }
    }
}

