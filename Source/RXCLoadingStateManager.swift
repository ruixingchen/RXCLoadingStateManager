//
//  RXCLoadingStateManager.swift
//  iOS-Sample
//
//  Created by ruixingchen on 1/18/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public enum RXCLoadingState: Equatable {
    public static func == (lhs: RXCLoadingState, rhs: RXCLoadingState) -> Bool {
        return lhs.key == rhs.key
    }

    ///we never make a request, means empty
    case none
    case empty(userInfo:[String:Any]?)
    case loading(userInfo:[String:Any]?)
    case failure(userInfo:[String:Any]?)
    case success

    var key:String {
        switch self {
        case .none:
            return "none"
        case .empty(_):
            return "empty"
        case .loading(_):
            return "loading"
        case .failure(_):
            return "failure"
        case .success:
            return "success"
        }
    }
}

public protocol RXCLoadingStatePresenter: AnyObject {
    func loadingStateManager(presentViewFor manager:RXCLoadingStateManager)->UIView
    func loadingStateManager(placeholderViewFor manager:RXCLoadingStateManager,loadingState:RXCLoadingState)->UIView
    ///did add placeholder, presenter has a chance to modify it, like change the frame
    func loadingStateManager(manager: RXCLoadingStateManager, didAddPlaceholderView placeholder:UIView, forState state:RXCLoadingState)
    func hasContent()->Bool
}

open class RXCLoadingStateManager {

    public private(set) var loadingState:RXCLoadingState = .none

    private var viewDict:[String:UIView] = [:]

    public weak var presenter:RXCLoadingStatePresenter!

    open var layoutPlaceholderClosure:((RXCLoadingState, UIView)->Void)?

    ///init placeholder view even it already exists
    //works for page that can show a different content with different errors
    ///if your placeholder view only shows a fixed content, keep it false to save CPU
    public var initViewEveryTime:Bool = false
    ///relaod placeholder view even the new state is the same as current state
    public var reloadViewEveryTime:Bool = false
    ///if this is false, manager will not set the frame for placeholder views
    ///you should handle the frame when returning placeholders
    public var shouldLayoutPlaceholder:Bool = true

    public convenience init(presenter:RXCLoadingStatePresenter) {
        self.init()
        self.presenter = presenter
    }

    ///show an empty view ignoring other conditions
    open func showEmpty(){
        self.loadingStateChanged(state: .empty(userInfo: nil))
    }

    open func startLoading(userInfo:[String:Any]?=nil){
        self.loadingStateChanged(state: RXCLoadingState.loading(userInfo: userInfo))
        #if HasXCGLogger
        logger.debugVerbose("进入加载状态")
        #endif
    }

    open func loadingFinish(success:Bool, userInfo:[String:Any]?=nil){
        #if canImport(XCGLogger)
        logger.debugVerbose("进入加载结束状态, success:\(success)")
        #endif
        let newState:RXCLoadingState
        if success {
            if self.presenter.hasContent() {
                newState = .success
            }else{
                newState = .empty(userInfo: userInfo)
            }
        }else{
            newState = .failure(userInfo: userInfo)
        }
        self.loadingStateChanged(state: newState)
    }

    private func loadingStateChanged(state:RXCLoadingState, force:Bool=false){
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }

        #if canImport(XCGLogger)
        logger.debugVerbose("加载状态切换:\(state),旧状态:\(self.loadingState), force:\(force)")
        #endif

        if state == self.loadingState && !force && !reloadViewEveryTime {return}
        //remove old view first
        let oldState:RXCLoadingState = self.loadingState
        if let oldPlaceholder = self.viewDict[oldState.key] {
            oldPlaceholder.removeFromSuperview()
        }

        let newState = state
        self.loadingState = newState

        if self.presenter.hasContent() {
            //we do't show any placeholders when we have content
            return
        }
        let newPlaceholder:UIView = self.placeholderView(forState: newState)
        let presenterView:UIView = self.presenter.loadingStateManager(presentViewFor: self)
        if shouldLayoutPlaceholder {
            if let closure = self.layoutPlaceholderClosure {
                closure(newState, newPlaceholder)
            }else{
                newPlaceholder.frame = presenterView.bounds
            }
        }
        presenterView.addSubview(newPlaceholder)
        self.presenter.loadingStateManager(manager: self, didAddPlaceholderView: newPlaceholder, forState: newState)
    }

    private func placeholderView(forState state:RXCLoadingState)->UIView{
        if self.initViewEveryTime {
            let view:UIView = self.presenter.loadingStateManager(placeholderViewFor: self, loadingState: state)
            self.viewDict[state.key] = view
            return view
        }else{
            var view:UIView? = self.viewDict[state.key]
            if view == nil {
                view = self.presenter.loadingStateManager(placeholderViewFor: self, loadingState: state)
                self.viewDict[state.key] = view
            }
            return view!
        }
    }

    ///release views that are not using
    open func releaseViews(){
        for i in self.viewDict {
            if i.value.superview == nil {
                viewDict[i.key] = nil
            }
        }
    }
}
