//
//  SearchInfo.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SearchInfo.h"
#import "Result.h"


NSString *const kSearchInfoResults = @"results";
NSString *const kSearchInfoCurrentPage = @"currentPage";
NSString *const kSearchInfoTotalCount = @"totalCount";
NSString *const kSearchInfoTotalPage = @"totalPage";
NSString *const kSearchInfoPageSize = @"pageSize";


@interface SearchInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchInfo

@synthesize results = _results;
@synthesize currentPage = _currentPage;
@synthesize totalCount = _totalCount;
@synthesize totalPage = _totalPage;
@synthesize pageSize = _pageSize;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedResults = [dict objectForKey:kSearchInfoResults];
    NSMutableArray *parsedResults = [NSMutableArray array];
    if ([receivedResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedResults addObject:[Result modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedResults isKindOfClass:[NSDictionary class]]) {
       [parsedResults addObject:[Result modelObjectWithDictionary:(NSDictionary *)receivedResults]];
    }

    self.results = [NSArray arrayWithArray:parsedResults];
            self.currentPage = [[self objectOrNilForKey:kSearchInfoCurrentPage fromDictionary:dict] doubleValue];
            self.totalCount = [[self objectOrNilForKey:kSearchInfoTotalCount fromDictionary:dict] doubleValue];
            self.totalPage = [[self objectOrNilForKey:kSearchInfoTotalPage fromDictionary:dict] doubleValue];
            self.pageSize = [[self objectOrNilForKey:kSearchInfoPageSize fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForResults = [NSMutableArray array];
    for (NSObject *subArrayObject in self.results) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResults addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kSearchInfoResults];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:kSearchInfoCurrentPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalCount] forKey:kSearchInfoTotalCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPage] forKey:kSearchInfoTotalPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kSearchInfoPageSize];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.results = [aDecoder decodeObjectForKey:kSearchInfoResults];
    self.currentPage = [aDecoder decodeDoubleForKey:kSearchInfoCurrentPage];
    self.totalCount = [aDecoder decodeDoubleForKey:kSearchInfoTotalCount];
    self.totalPage = [aDecoder decodeDoubleForKey:kSearchInfoTotalPage];
    self.pageSize = [aDecoder decodeDoubleForKey:kSearchInfoPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_results forKey:kSearchInfoResults];
    [aCoder encodeDouble:_currentPage forKey:kSearchInfoCurrentPage];
    [aCoder encodeDouble:_totalCount forKey:kSearchInfoTotalCount];
    [aCoder encodeDouble:_totalPage forKey:kSearchInfoTotalPage];
    [aCoder encodeDouble:_pageSize forKey:kSearchInfoPageSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchInfo *copy = [[SearchInfo alloc] init];
    
    if (copy) {

        copy.results = [self.results copyWithZone:zone];
        copy.currentPage = self.currentPage;
        copy.totalCount = self.totalCount;
        copy.totalPage = self.totalPage;
        copy.pageSize = self.pageSize;
    }
    
    return copy;
}


@end
