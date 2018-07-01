#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		NSString *inputFileName = @"input.csv";
		NSString *outputFileName = @"output.csv";
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
		NSString *desktopDirectory = paths[0];
		desktopDirectory = [desktopDirectory stringByAppendingString:@"/"];
		
		NSError *error;
		NSString *fullContent = [NSString stringWithContentsOfFile:[desktopDirectory stringByAppendingString:inputFileName] encoding:NSUTF8StringEncoding error:&error];

		if (!error) {
			NSMutableArray *selectedRows = @[].mutableCopy;
			NSArray *allRows = [fullContent componentsSeparatedByString:@"\n"];

            //---------------------------------
			// Insert SELECTING CODE HERE:
			//---------------------------------

            NSLog(@"Original file had %lu rows", (unsigned long)allRows.count);
            NSLog(@"Output file has %lu rows", (unsigned long)selectedRows.count);
            
            // Save the captured lines into a file:
			NSString *result = @"".mutableCopy;
			
			for (NSString *row in selectedRows) {
				result = [result stringByAppendingString:[row stringByAppendingString:@"\n"]];
			}
			
			if ([[NSFileManager defaultManager] fileExistsAtPath:[desktopDirectory stringByAppendingString:outputFileName]]) {
				[[NSFileManager defaultManager] removeItemAtPath:[desktopDirectory stringByAppendingString:outputFileName] error:&error];
			}
			
			[[NSFileManager defaultManager] createFileAtPath:[desktopDirectory stringByAppendingString:outputFileName] contents:[result dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
			
		}
	}

	return 0;
}

/**

// Skip every 2 rows:
for (NSInteger i = 1; i < productIdentifiers.count - 1; i = i + 3) {
	[uniqueIdentifiers addObject:productIdentifiers[i]];
}
//-------------------------------------------------------------------
// Skip every third element starting from the second:
// Used to remove color_number and only get color_name and product_name
// Must run the import script first.
// Runs over the generated code.
NSInteger i = 0;

while (i < allRows.count) {
	if ( ((i+3) % 3) == 1) {
		i++;
		continue;
	} else {
		[selectedRows addObject:allRows[i]];
		i++;
	}
}
//-------------------------------------------------------------------
// Skip the rows that are not_used:
for (NSString *row in allRows) {
	if (![row containsString:@"not_used"]) {
		[selectedRows addObject:row];
	}
}
//-------------------------------------------------------------------
// Skip every two rows creating Product with ID and Color and removing leading zeros (removes conflicts w/octal notation)
//
// Used for importing product id's and colors.
//
// Uses helper function:  (needs to be before main)
NSString *recursivelyRemoveLeadingZeros(NSString *arg) {
	if ([arg characterAtIndex:0] != '0') {
		return arg;
	} else {
		return recursivelyRemoveLeadingZeros([arg substringFromIndex:1]);
	}
}

for (NSInteger i = 1; i < allRows.count - 1; i = i + 3) {
	NSString *row = allRows[i];
	NSArray *rowElements = [row componentsSeparatedByString:@","];
	NSString *first = [rowElements firstObject];
	NSString *second = rowElements[1];
	NSString *objcLine;
	
	if ([second isEqualToString:@""]) {
		second = @"nil";
		objcLine = [NSString stringWithFormat:@"[ELProductRealm productWithId:@\"%@\" color:%@],", first, second];
	} else {
		second = recursivelyRemoveLeadingZeros(second);
		objcLine = [NSString stringWithFormat:@"[ELProductRealm productWithId:@\"%@\" color:@(%@)],", first, second];
	}
	
	[selectedRows addObject:objcLine];
}
 
 // Remove quotes from my custom chrome extension to output tabs to text links:
 int i = 0;
 
while (i < allRows.count) {
    NSString *quotedString = allRows[i];
    NSString *unQuotedString = [quotedString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    [selectedRows addObject:unQuotedString];
    i += 3;
}
 
//--------------------------------------------------------------------

*/
