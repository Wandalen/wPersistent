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
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.array( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

}

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
  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
