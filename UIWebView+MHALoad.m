//
//  UIWebView+MHALoad.m
//
//  Created by Med on 28/05/15.
//  Copyright (c) 2015 Med. All rights reserved.
//

#import "UIWebView+MHALoad.h"

@implementation UIWebView(MHALoad)

- (void)loadURL:(NSString *)url {
    if (!url || [url isEqualToString:@""]) {
        [self reportError:@"Empty URLs are not allowed"];
        return;
    }
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [self reportError:[NSString stringWithFormat:@"Cannot load URL '%@'", url]];
        return;
    }

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self loadRequest:requestObj];
}

         
#pragma mark - Utils
- (void)reportError:(NSString *)errorMsg {
    if (!self.delegate ||
        ![self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        //UIWebViewDelegate not implemented
        return;
    }
    
    NSDictionary *errDetails = @{NSLocalizedDescriptionKey : errorMsg};
    [self.delegate webView:self didFailLoadWithError:[NSError errorWithDomain:@"UIWebView" code:200 userInfo:errDetails]];
}

@end
