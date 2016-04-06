//
//  ServerRequest.m

//  Created by Yahia on 4/5/16.
//  Copyright © 2016 nichepharma.com. All rights reserved.
//

#import "ServerRequest.h"
#define URL @"http://www.tacitapp.com/new-tacit/test2"
#define GO_TO_POST @"action"
@interface ServerRequest (){
    
@private NSString *str_Tag_name ;
@private NSMutableDictionary *dic_request_Data;
    
}
@end

@implementation ServerRequest

-(id)initWithPostName :(NSString *)str_POST_name {
    str_Tag_name = [NSString stringWithFormat:@"&%@=%@",GO_TO_POST,str_POST_name];
    return self ;
}


-(void)execute{
    

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic_request_Data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString ;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
    
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //! 1. Set post string with actual Data
    NSString *post =[NSString stringWithFormat:@"%@&data=%@" ,str_Tag_name ,jsonString];
        //! 2. Encode the post string using NSASCIIStringEncoding and also the post string you need to send in NSData format.
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        //! 3. Create a Urlrequest with all the properties like HTTP method, http header field with length of the post string. Create URLRequest object and initialize it.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;

    [request setURL:[NSURL URLWithString: URL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
  
    //! 4. Now, create URLConnection object. Initialize it with the URLRequest.
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
        
        
       }

}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@" >>>>>> %@ ", myString);
    if ([myString isEqualToString:@"1"]) {
    NSString *str_MyRequst = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSMutableDictionary *did_Endcoding_Data =
    [NSJSONSerialization JSONObjectWithData:[str_MyRequst dataUsingEncoding:NSUTF8StringEncoding]
                                    options:NSJSONReadingMutableContainers
                                      error:&err];
    
    [[self requestDelegate] didFinshRequest:did_Endcoding_Data] ;
 }
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
   
     NSLog(@"didFailWithError %@",error);
     [self.requestDelegate didFinshRequestWithError:error];
}



//// This method is used to process the data after connection has made successfully.
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    NSLog(@"connectionDidFinishLoading %@",connection);
//}

-(void)set_paramWithData :(id) data_Value :  (NSString *)arr_Key {
    if (!dic_request_Data) {
        dic_request_Data = [[NSMutableDictionary alloc] init];
    }

    [dic_request_Data setObject:data_Value forKey:arr_Key];
    
}

@end
