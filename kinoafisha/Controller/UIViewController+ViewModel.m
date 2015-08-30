//
//  UIViewController+ViewModel.m
//  kinoafisha
//
//  Created by Eugene Dorfman on 8/30/15.
//  Copyright (c) 2015 justadreamer. All rights reserved.
//

#import "UIViewController+ViewModel.h"
#import <objc/runtime.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BaseViewModel.h"

@interface UIViewController()<ViewModelSupport>
@end

@implementation UIViewController (ViewModel)

- (void)defineDefaultBindings {
    @weakify(self)
    [RACObserve(self.viewModel,isLoading) subscribeNext:^(NSNumber *isLoading) {
        @strongify(self)
        if ([isLoading boolValue]) {
            [SVProgressHUD showWithStatus:self.viewModel.loadingIndicatorMessage];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
    [RACObserve(self.viewModel, dataModel) subscribeNext:^(id dataModel) {
        @strongify(self)
        [self redisplayData];
    }];
}

@end
