/* Copyright (c) 2009 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GDataAtomServiceDocument.h
//

#if !GDATA_REQUIRE_SERVICE_INCLUDES || GDATA_INCLUDE_SERVICE_INTROSPECTION

// app:workspace, per http://tools.ietf.org/html/rfc5023#section-8.3.2
//
// For example,
//  <workspace>
//    <atom:title>Main Site</atom:title>
//    <collection href="http://example.org/blog/main" >
//      <atom:title>My Blog Entries</atom:title>
//      <categories href="http://example.com/cats/forMain.cats" />
//    </collection>
//  </workspace>

#import "GDataObject.h"

@class GDataAtomWorkspace;

@interface GDataAtomServiceDocument : GDataObject

- (NSArray *)workspaces;
- (void)setWorkspaces:(NSArray *)array;
- (GDataAtomWorkspace *)primaryWorkspace; // returns the first workspace, or nil

@end

@interface GDataAtomServiceDocument1_0 : GDataAtomServiceDocument
// older namespace URI
@end

#endif // !GDATA_REQUIRE_SERVICE_INCLUDES || GDATA_INCLUDE_SERVICE_INTROSPECTION
