import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // MARK: - Private properties
    private var movieStoryScenarioBuilder: MovieStoryScenarioBuilderProtocol?

    func scene(
        _ scene: UIScene, willConnectTo
        session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow()
        window?.windowScene = scene
        movieStoryScenarioBuilder = MovieStoryScenarioBuilder()
        window?.rootViewController = movieStoryScenarioBuilder?.makeMovieListViewController()
        window?.makeKeyAndVisible()
    }

}

