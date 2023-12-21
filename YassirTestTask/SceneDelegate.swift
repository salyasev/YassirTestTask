import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // MARK: - Private properties
    private let movieStoryScenarioBuilder: MovieStoryScenarioBuilderProtocol = MovieStoryScenarioBuilder()
    private var navigationController: UINavigationController?
    
    // MARK: - UIWindowSceneDelegate
    func scene(
        _ scene: UIScene, willConnectTo
        session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow()
        window?.windowScene = scene
        let mainViewController = movieStoryScenarioBuilder.makeMovieListViewController()
        navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

