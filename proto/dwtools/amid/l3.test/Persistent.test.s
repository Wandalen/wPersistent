( function _Persistent_test_s_( ) {

'use strict';

/*
*/

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );;

  require( '../l3/persistent/Include.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// tests
// --

function basic( test )
{

  test.description = 'was clean';
  var exp =
  [
  ]
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  test.description = 'writing';
  var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.array( 'account' ).structureAppend( structure1 );
  persistent.close();

  var structure2 = { a : '21', b : { c : [ 21, 22, 23 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.array( 'account' ).structureAppend( structure2 );
  persistent.close();

  var structure3 = { a : '31', b : { c : [ 31, 32, 33 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.array( 'account' ).structurePrepend( structure3 );
  persistent.close();

  test.description = 'written 2';
  var exp =
  [
    { a : '31', b : { c : [ 31, 32, 33 ], d : null } },
    { a : '1', b : { c : [ 1, 2, 3 ], d : null } },
    { a : '21', b : { c : [ 21, 22, 23 ], d : null } },
  ]
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  test.description = 'clean';
  _.persistent.open( '.' + test.suite.name ).array( 'account' ).clean();
  var exp =
  [
  ]
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

}

basic.description =
`
- method structureAppend appends element of array and store structure
- method structurePrepend prepends element of array and store structure
- method clean deletes collection
`

//

function structureProxy( test )
{

  test.description = 'was clean';
  var exp = {}
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structure;
  test.identical( read, exp );
  persistent.close();

  test.description = 'writing';
  var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var account = persistent.structure.account;
  account.push( structure1 );
  persistent.collection( 'account' ).structureWrite( account );
  persistent.close();
  var structure2 = { a : '21', b : { c : [ 21, 22, 23 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var account = persistent.structure.account;
  account.push( structure2 );
  persistent.collection( 'account' ).structureWrite( account );
  persistent.close();

  test.description = 'written 2';
  var exp =
  [
    { a : '1', b : { c : [ 1, 2, 3 ], d : null } },
    { a : '21', b : { c : [ 21, 22, 23 ], d : null } },
  ]
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  test.description = 'written 2';
  var exp =
  [
    { a : '1', b : { c : [ 1, 2, 3 ], d : null } },
    { a : '21', b : { c : [ 21, 22, 23 ], d : null } },
  ]
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structure.account;
  persistent.close();
  test.identical( read, exp );

  test.description = 'clean';
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.structure.account = [];
  var exp =
  [
  ]
  persistent.close();
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

}

structureProxy.description =
`
- persistent.structure can be used to read struture
- setting field of persistent.structure write structure
`

//

function persistentClean( test )
{

  test.description = 'writing';
  var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var account = persistent.structure.account;
  account.push( structure1 );
  persistent.array( 'account' ).structureWrite( account );
  persistent.close();

  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var got = persistent.exists();
  test.identical( got, true );

  test.description = 'written 2';
  var exp =
  [
    { a : '1', b : { c : [ 1, 2, 3 ], d : null } },
  ]
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  test.description = 'clean';
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.clean()
  persistent.close();
  var exp =
  [
  ]
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var got = persistent.exists();
  test.identical( got, false );

}

persistentClean.description =
`
- removes whole persistent
- persistent.exists give true if persistent exists, otherwise false
`

// --
// define class
// --

var Self =
{

  name : 'Tools.amid.Persistent',
  silencing : 1,

  tests :
  {
    basic,
    structureProxy,
    persistentClean,
  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
