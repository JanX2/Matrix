//
//  main.m
//  Matrix
//
//  Created by Christopher Miller on 12/14/11.
//  Copyright (c) 2011 FSDEV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FSMatrix.h"
#import "FSMutableMatrix.h"

int main (int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        FSMatrix* matrix = [[FSMatrix alloc] init];
        NSLog(@"Matrix: %@", matrix);
        
        FSMutableMatrix* mutableMatrix = [[FSMutableMatrix alloc] initWithRowCount:10
                                                                       columnCount:10
                                                                       initializer:FSNullInitializer];
        for (NSUInteger i=0; i<10; ++i)
            for (NSUInteger j=0; j<10; ++j)
                [mutableMatrix setObject:[NSString stringWithFormat:@"(%2lu,%2lu)", i,j] atRowIndex:i columnIndex:j];
        NSLog(@"Mutable Matrix: %@", mutableMatrix);
        
        matrix = [mutableMatrix copy];
        
        NSLog(@"Matrix: %@", matrix);
        
        FSMatrix* deadFolks = [[FSMatrix alloc] initWithRows:
                               [NSArray arrayWithObjects:@"Franklin Roosevelt", @"Lyndon Johnson", @"Ronald Reagan", nil],
                               [NSArray arrayWithObjects:@"Josef Stalin", @"Vladimir Lenin", @"Leon Trotsky", nil],
                               nil,nil];
        
        NSLog(@"Dead folks: %@", deadFolks);
        
        FSMutableMatrix* mutationExample = [[FSMutableMatrix alloc] init];
        NSLog(@"Mutation Example: %@", mutationExample);
        
        [mutationExample setObject:@"Hello, world!" atRowIndex:3 columnIndex:3];
        NSLog(@"Mutation Example: %@", mutationExample);
        
        NSUInteger centerColumnIndex = (mutationExample.columnCount + 1) / 2;
        [mutationExample insertObject:@"Top of the world."
                           atRowIndex:0 newRow:NO
                          columnIndex:centerColumnIndex
                            newColumn:YES];
        NSLog(@"Insertion Example #1: %@", mutationExample);
        
        NSUInteger centerRowIndex = (mutationExample.rowCount + 1) / 2;
        [mutationExample insertObject:@"Center of the world."
                           atRowIndex:centerRowIndex
                               newRow:YES
                          columnIndex:centerColumnIndex
                            newColumn:NO];
        NSLog(@"Insertion Example #2: %@", mutationExample);
        
        NSMutableString *enumerationString = [NSMutableString string];
        NSUInteger lastColumnIndex = mutationExample.columnCount - 1;
        NSUInteger padToLength = 20;
        [mutationExample enumerateObjectsUsingBlock:^(id obj, NSUInteger rowIndex, NSUInteger columnIndex, BOOL *stop) {
            [enumerationString appendString:@" | "];
            NSString *description = [obj description];
            description = [description stringByPaddingToLength:padToLength
                                                    withString:@" "
                                               startingAtIndex:0];
            [enumerationString appendString:description];
            if (columnIndex == lastColumnIndex) {
                [enumerationString appendString:@" |\n"];
            }
        }];
        NSLog(@"Enumeration Example: \n%@", enumerationString);

    }
    
    return 0;
}

