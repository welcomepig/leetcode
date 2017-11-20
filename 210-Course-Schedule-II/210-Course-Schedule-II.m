#import <Foundation/Foundation.h>

// Kahn's Algorithm: O(V*V)
NSArray* findOrder(NSUInteger numCourses, NSArray<NSArray*> *preRequisites) {
    NSInteger refs[numCourses];
    NSInteger i, j, s;
    
    for (i = 0;i < numCourses; i++) {
        refs[i] = 0;
    }
    for (NSArray *pair in preRequisites) {
        refs[[pair[0] integerValue]]++;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (j = 0;j < numCourses; j++) {
        for (i = 0;i < numCourses; i++) {
            if (refs[i] == 0) {
                s = i;
                break;
            }
        }
        if (i == numCourses) return @[];   // cycle => no valid solution
        refs[s] = -1;
        [result addObject:@(s)];
        
        for (NSArray *pair in preRequisites) {
            if ([pair[1] integerValue] == s) {
                refs[[pair[0] integerValue]]--;
            }
        }
    }
    return [result copy];
}

NSArray* findOrderBFS(NSUInteger numCourses, NSArray<NSArray*> *preRequisites) {
    NSMutableArray *zeroes = [NSMutableArray array];
    NSMutableDictionary<NSNumber*,NSMutableSet*> *graph = [NSMutableDictionary dictionary];
    NSInteger degrees[numCourses];
    
    for (NSInteger i = 0;i < numCourses; i++) {
        degrees[i] = 0;
    }
    for (NSArray *pair in preRequisites) {
        if (!graph[pair[1]]) {
            graph[pair[1]] = [NSMutableSet set];
        }
        [graph[pair[1]] addObject:pair[0]];
        degrees[[pair[1] integerValue]]++;
    }
    for (NSInteger i = 0;i < numCourses; i++) {
        if (!graph[@(i)]) [zeroes addObject:@(i)];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0;i < numCourses; i++) {
        if (zeroes.count == 0) return @[];      // cycle => no valid solution
        NSNumber *s = zeroes.lastObject;
        [result addObject:s];
        [zeroes removeLastObject];
        
        for (NSNumber *n in (NSMutableSet*)graph[s]) {
            degrees[[n integerValue]]--;
            if (degrees[[n integerValue]] == 0) {
                [zeroes addObject:n];
            }
        }
    }
    
    return [result copy];
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
    }
}

