//
//  HomeDataResource.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 25/06/23.
//

import Foundation

struct HomeDataResource
{
    func getHomeData(completion : @escaping (_ result: HomeResponseModel?) -> Void)
    {
        let channelUrl = URL(string: ApiEndpoints.homeApi)!
        let httpUtility = HttpUtility.shared
        httpUtility.getApiData(requestUrl: channelUrl, resultType: HomeResponseModel.self) { (homeApiResponse) in
            _ = completion(homeApiResponse)
        }
    }
}
