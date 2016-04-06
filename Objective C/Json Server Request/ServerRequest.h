//
//  ServerRequest.h
//  Created by Yahia on 4/5/16.
//  Copyright © 2016 nichepharma.com. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol RequestDelegate <NSObject>

-(void) didFinshRequest:(NSMutableDictionary*) dict;
@optional
-(void) didFinshRequestWithError :(NSError *) ErrorCode ;

@end



@interface ServerRequest : NSObject
-(id)initWithPostName :(NSString *)str_POST_name ;
-(void)set_paramWithData :(id) data_Value :  (NSString *)arr_Key ; 
@property  (strong,nonatomic) id <RequestDelegate> requestDelegate ;
-(void)execute ;


@end
