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

function basicArray( test )
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

  test.description = 'written 3';
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

  _.persistent.open({ name : '.' + test.suite.name }).clean();
}

basicArray.description =
`
- method structureAppend appends element of array and store the structure
- method structurePrepend prepends element of array and store the structure
- method clean deletes collection
`

//

function basicMap( test )
{

  test.description = 'was clean';
  var exp = {}
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.map( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  test.description = 'writing';
  var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.map( 'account' ).structureInsert( 's1', structure1 );
  persistent.close();

  var structure2 = { a : '21', b : { c : [ 21, 22, 23 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.map( 'account' ).structureInsert( 's2', structure2 );
  persistent.close();

  var structure3 = { a : '31', b : { c : [ 31, 32, 33 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.map( 'account' ).structureInsert( 's3', structure3 );
  persistent.close();

  test.description = 'written 3';
  var exp =
  {
    s3 : { a : '31', b : { c : [ 31, 32, 33 ], d : null } },
    s1 : { a : '1', b : { c : [ 1, 2, 3 ], d : null } },
    s2 : { a : '21', b : { c : [ 21, 22, 23 ], d : null } },
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.collection( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  test.description = 'clean';
  _.persistent.open( '.' + test.suite.name ).array( 'account' ).clean();
  var exp =
  {
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.map( 'account' ).structureRead();
  persistent.close();
  test.identical( read, exp );

  _.persistent.open({ name : '.' + test.suite.name }).clean();
}

basicMap.description =
`
- method structureAppend insert element of map and store the structure
- method clean deletes collection
`
//
// //
//
// function secondLevel( test )
// {
//
//   test.description = 'was clean';
//   var exp = {}
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var read = persistent.map( 'account' ).structureRead();
//   persistent.close();
//   test.identical( read, exp );
//
//   test.description = 'writing';
//   var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   persistent.map( 'account' ).structureInsert( 's1', structure1 );
//   persistent.close();
//
//   var structure2 = { a : '21', b : { c : [ 21, 22, 23 ], d : null } }
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   persistent.map( 'account' ).array( 'l2' ).structureAppend( structure2 );
//   persistent.close();
//
//   // var structure3 = { a : '31', b : { c : [ 31, 32, 33 ], d : null } }
//   // var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   // persistent.map( 'account' ).array( 'l2' ).map( 'l3' ).structureInsert( 's3', structure3 );
//   // persistent.close();
//
//   test.description = 'written 3';
//   var exp =
//   {
//   }
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var read = persistent.collection( 'account' ).structureRead();
//   persistent.close();
//   test.identical( read, exp );
//
//   test.description = 'clean';
//   _.persistent.open( '.' + test.suite.name ).array( 'account' ).clean();
//   var exp =
//   {
//   }
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var read = persistent.map( 'account' ).structureRead();
//   persistent.close();
//   test.identical( read, exp );
//
//   _.persistent.open({ name : '.' + test.suite.name }).clean();
// }
//
// secondLevel.description =
// `
// - method structureAppend appends element of array and store structure
// - method structurePrepend prepends element of array and store structure
// - method clean deletes collection
// `

//

function secondLevel( test )
{

  test.description = 'was clean';
  var exp = {}
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead();
  persistent.close();
  test.identical( read, exp );

  test.description = 'writing';
  var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.structureInsert( '/account/s1', structure1 );
  persistent.close();

  test.description = 'written 1';
  var exp =
  {
    'account' :
    {
      's1' :
      {
        'a' : '1',
        'b' :
        {
          'c' : [ 1, 2, 3 ],
          'd' : null
        }
      }
    }
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead( '/' );
  persistent.close();
  test.identical( read, exp );

  test.description = 'written 1';
  var exp =
  {
    's1' :
    {
      'a' : '1',
      'b' :
      {
        'c' : [ 1, 2, 3 ],
        'd' : null
      }
    }
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead( '/account' );
  persistent.close();
  test.identical( read, exp );

  test.description = 'written 1';
  var exp =
  {
    'a' : '1',
    'b' :
    {
      'c' : [ 1, 2, 3 ],
      'd' : null
    }
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead( '/account/s1' );
  persistent.close();
  test.identical( read, exp );

  var structure2 = { a : '21', b : { c : [ 21, 22, 23 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  persistent.structureAppend( '/account/s1/x', structure2 );
  persistent.close();

  test.description = 'written 2';
  var exp =
  {
    'a' : '1',
    'b' :
    {
      'c' : [ 1, 2, 3 ],
      'd' : null
    },
    'x' :
    [
      {
        'a' : '21',
        'b' :
        {
          'c' : [ 21, 22, 23 ],
          'd' : null
        }
      }
    ]
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead( '/account/s1' );
  persistent.close();
  test.identical( read, exp );

  test.description = 'written 2';
  var exp =
  {
    's1' :
    {
      'a' : '1',
      'b' :
      {
        'c' : [ 1, 2, 3 ],
        'd' : null
      },
      'x' :
      [
        {
          'a' : '21',
          'b' :
          {
            'c' : [ 21, 22, 23 ],
            'd' : null
          }
        }
      ]
    }
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead( '/account' );
  persistent.close();
  test.identical( read, exp );

  test.description = 'written 2';
  var exp =
  {
    'account' :
    {
      's1' :
      {
        'a' : '1',
        'b' :
        {
          'c' : [ 1, 2, 3 ],
          'd' : null
        },
        'x' :
        [
          {
            'a' : '21',
            'b' :
            {
              'c' : [ 21, 22, 23 ],
              'd' : null
            }
          }
        ]
      }
    }
  }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead( '/' );
  persistent.close();
  test.identical( read, exp );

  test.description = 'clean';
  _.persistent.open( '.' + test.suite.name ).clean().close();
  var exp ={}
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var read = persistent.structureRead( '/' );
  persistent.close();
  test.identical( read, exp );

}

secondLevel.description =
`
- method structureAppend appends element of array and store structure
- method structurePrepend prepends element of array and store structure
- method clean deletes collection
`

//

function structureProxy( test )
{

  test.description = 'clean';
  var persistent = _.persistent.open({ name : '.' + test.suite.name }).clean().close();

  test.description = 'writing';
  var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
  var persistent = _.persistent.open({ name : '.' + test.suite.name });
  var account = persistent.structure.account = [];
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

// function structureProxy( test )
// {
//
//   test.description = 'was clean';
//   var exp = {}
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var read = persistent.structure;
//   test.identical( read, exp );
//   persistent.close();
//
//   test.description = 'writing';
//   var structure1 = { a : '1', b : { c : [ 1, 2, 3 ], d : null } }
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var account = persistent.structure.account = [];
//   account.push( structure1 );
//   // persistent.structureWrite();
//   // persistent.collection( 'account' ).structureWrite( account );
//   persistent.close();
//   var structure2 = { a : '21', b : { c : [ 21, 22, 23 ], d : null } }
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var account = persistent.structure.account;
//   account.push( structure2 );
//   // persistent.collection( 'account' ).structureWrite( account );
//   persistent.close();
//
//   test.description = 'written 2';
//   var exp =
//   [
//     { a : '1', b : { c : [ 1, 2, 3 ], d : null } },
//     { a : '21', b : { c : [ 21, 22, 23 ], d : null } },
//   ]
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var read = persistent.array( 'account' ).structureRead();
//   persistent.close();
//   test.identical( read, exp );
//
//   test.description = 'written 2';
//   var exp =
//   [
//     { a : '1', b : { c : [ 1, 2, 3 ], d : null } },
//     { a : '21', b : { c : [ 21, 22, 23 ], d : null } },
//   ]
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var read = persistent.structure.account;
//   persistent.close();
//   test.identical( read, exp );
//
//   test.description = 'clean';
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   persistent.structure.account = [];
//   var exp =
//   [
//   ]
//   persistent.close();
//   var persistent = _.persistent.open({ name : '.' + test.suite.name });
//   var read = persistent.array( 'account' ).structureRead();
//   persistent.close();
//   test.identical( read, exp );
//
// }
//
// structureProxy.description =
// `
// - persistent.structure can be used to read struture
// - setting field of persistent.structure write structure
// `

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

    basicArray,
    basicMap,
    secondLevel,
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
