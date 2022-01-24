//
//  ViewState.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

enum ViewState: Equatable {

    case idle,
    onRefresh,
    refreshCompleted,
    refreshError(LocalizedStringKey),
    onLoading,
    loadComplete,
    loadNoData,
    loadError(LocalizedStringKey),
    empty


}
