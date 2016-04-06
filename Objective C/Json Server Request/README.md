/*
How to use it 
1. in .m File set urlPATH 
2. use Delegate in ur class
3.  ServerRequest *sRequest = [[ServerRequest alloc] initWithPostName:@"insert_workshop"];
        [sRequest set_paramWithData:@"Value 1" :@"tag1" ] ;
        [sRequest set_paramWithData:@"Value 2" :@"tag2" ] ;
        sRequest.requestDelegate = self;
        [sRequest execute ];



*/
