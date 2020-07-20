//
//  SceneDelegate.swift
//  tuner
//
//  Created by Brian Huang on 6/30/20.
//  Copyright © 2020 hbm. All rights reserved.
//

import UIKit
import SwiftUI
import AVKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .authorized: // The user has previously granted access to the camera.
                self.setupCaptureSession()
            
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    if granted {
                        self.setupCaptureSession()
                    }
                }
            
            case .denied: // The user has previously denied access.
                return


            case .restricted: // The user can't grant access due to restrictions.
                return
        @unknown default:
            return
        }
    }

    func setupCaptureSession() {
        // Create the capture session.
        let captureSession = AVCaptureSession()


        // Find the default audio device.
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
        var audioInput : AVCaptureDeviceInput? = nil
        var audioOutput : AVCaptureAudioDataOutput? = nil


        do {
            // Wrap the audio device in a capture device input.
            audioInput = try AVCaptureDeviceInput(device: audioDevice)
            audioOutput = AVCaptureAudioDataOutput()
            // If the input can be added, add it to the session.
            if captureSession.canAddInput(audioInput!) {
                captureSession.addInput(audioInput!)
            }
            if captureSession.canAddOutput(audioOutput!) {
                captureSession.addOutput(audioOutput!)
            }
        } catch {
            // Configuration failed. Handle error.
        }
//        captureSession.startRunning()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

