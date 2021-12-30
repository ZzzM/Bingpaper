//
//  ViewState.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
enum ViewState: Equatable {

    case idle,
    onRefresh,
    refreshCompleted,
    refreshError(String),
    onLoading,
    loadComplete,
    loadNoData,
    loadError(String),
    empty


}
