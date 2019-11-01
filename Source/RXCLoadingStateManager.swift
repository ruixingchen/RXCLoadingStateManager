//
//  RXCLoadingStateManager.swift
//  iOS-Sample
//
//  Created by ruixingchen on 1/18/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public enum RLSLoadingState {

    ///now loading
    case loading

    ///made a request successfully but get empty content
    case successWithoutContent

    ///request failed and no content
    case failedWithoutContent

    ///request finished and have content to show (ignore failed or success)
    case hasContent

}

///a presenter that presents the loading state, normally it is a ViewController
public protocol RLSLoadingStatePresenter: AnyObject {
    ///the view to present the loading state view, normally it is the ViewController's view
    func loadingStateManager(manager:RXCLoadingStateManager, presentViewFor loadingState:RLSLoadingState)->UIView
    ///the view to show loading state info, should bind the info in this function
    func loadingStateManager(manager:RXCLoadingStateManager, placeholderViewFor loadingState: RLSLoadingState)->UIView
    ///did add loadingStateView, presenter has a chance to modify it, like change the frame
    func loadingStateManager(manager: RXCLoadingStateManager, didAddPlaceholderView placeholderView:UIView, for loadingState:RLSLoadingState)
    ///is there content to show? or we show empty loadingStateView
    func loadingStateManager_hasContent()->Bool
}

public final class RXCLoadingStateManager {

    public private(set) var loadingState:RLSLoadingState = .hasContent
    public private(set) var placeholderView:UIView?
    public weak var presenter:RLSLoadingStatePresenter!

    ///if this is false, manager will not set the frame for loading state views and
    ///you should handle the frame when returning view
    public var placeholderViewFillPresentView:Bool = true

    public init(presenter:RLSLoadingStatePresenter) {
        self.presenter = presenter
    }

    ///loading started, if we have no content, show the loading view
    public func startLoading() {
        self.loadingState = .loading
        self.placeholderView?.removeFromSuperview()
        self.placeholderView = self.presenter.loadingStateManager(manager: self, placeholderViewFor: self.loadingState)
        let presenter = self.presenter.loadingStateManager(manager: self, presentViewFor: self.loadingState)
        if self.placeholderViewFillPresentView {
            self.placeholderView?.frame = presenter.bounds
        }
        presenter.addSubview(self.placeholderView!)
        self.presenter.loadingStateManager(manager: self, didAddPlaceholderView: self.placeholderView!, for: self.loadingState)
    }

    ///finish loading with success flag
    public func finishLoading(success:Bool) {
        if success {
            if self.presenter.loadingStateManager_hasContent() {
                //success with content, remove all placeholderView
                self.loadingState = .hasContent
                self.placeholderView?.removeFromSuperview()
                self.placeholderView = nil
            }else {
                //we have no content
                self.loadingState = .successWithoutContent
                self.placeholderView?.removeFromSuperview()
                self.placeholderView = self.presenter.loadingStateManager(manager: self, placeholderViewFor: self.loadingState)
                let presenter = self.presenter.loadingStateManager(manager: self, presentViewFor: self.loadingState)
                if self.placeholderViewFillPresentView {
                    self.placeholderView?.frame = presenter.bounds
                }
                presenter.addSubview(self.placeholderView!)
                self.presenter.loadingStateManager(manager: self, didAddPlaceholderView: self.placeholderView!, for: self.loadingState)
            }
        }else {
            if self.presenter.loadingStateManager_hasContent() {
                //success with content, remove all placeholderView
                self.loadingState = .hasContent
                self.placeholderView?.removeFromSuperview()
                self.placeholderView = nil
            }else {
                //we have no content
                self.loadingState = .failedWithoutContent
                self.placeholderView?.removeFromSuperview()
                self.placeholderView = self.presenter.loadingStateManager(manager: self, placeholderViewFor: self.loadingState)
                let presenter = self.presenter.loadingStateManager(manager: self, presentViewFor: self.loadingState)
                if self.placeholderViewFillPresentView {
                    self.placeholderView?.frame = presenter.bounds
                }
                presenter.addSubview(self.placeholderView!)
                self.presenter.loadingStateManager(manager: self, didAddPlaceholderView: self.placeholderView!, for: self.loadingState)
            }
        }
    }

}
