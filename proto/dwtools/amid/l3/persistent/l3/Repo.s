( function _Repo_s_( ) {

'use strict';

//

let _ = _global_.wTools;
let Parent = null;
let Self = function wRepo( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Repo';

// --
// inter
// --

function init( o )
{
  let repo = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.workpiece.initFields( repo );
  Object.preventExtensions( repo );

  if( o )
  repo.copy( o );

  /* */

  _.sure( _.strDefined( repo.name ) && repo.name[ 0 ] === '.', `Expects name of repositroy {- name -} which begins with dot, but got ${repo.name}` );

}

//

function close()
{
  let repo = this;

  repo.finit();
}

//

function clean()
{
  let repo = this;
  let path = _.fileProvider.path;

  let filePath = repo.filePathGet();

  _.fileProvider.filesDelete( filePath );

  return repo;
}

//

function exists()
{
  let repo = this;
  let path = _.fileProvider.path;

  let filePath = repo.filePathGet();

  return _.fileProvider.isDir( filePath );
}

//

function _collection( o )
{
  let repo = this;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.name ) );

  return _.persistent.Collection
  ({
    repo : repo,
    name : o.name,
    kind : o.kind,
  });
}

//

function collection( collectionName )
{
  let repo = this;

  _.assert( arguments.length === 1 );

  return repo._collection({ name : collectionName });
}

//

function array( collectionName )
{
  let repo = this;

  _.assert( arguments.length === 1 );

  return repo._collection({ name : collectionName, kind : 'array' });
}

//

function map( collectionName )
{
  let repo = this;

  _.assert( arguments.length === 1 );

  return repo._collection({ name : collectionName, kind : 'map' });
}

//

function collectionsNames()
{
  let repo = this;
  let result = _.fileProvider.dirRead( repo.filePathGet() );
  if( !result )
  return [];
  return result;
}

//

function structureRead( selector )
{
  let repo = this;
  let result = repo._fileRead( selector );

  if( result.structure === undefined )
  return result.structure;

  if( !result.selector2 || result.selector2 === '/' )
  return result.structure;
  else
  return _.select( result.structure, result.selector2 );

}

//

function _fileRead( selector )
{
  let repo = this;
  let result = Object.create( null );

  result.selector = selector || '/';

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let selectorArray = _.path.split( result.selector );
  if( !selectorArray[ 0 ] )
  selectorArray.splice( 0, 1 );
  result.selector1 = selectorArray[ 0 ];
  result.selector2 = selectorArray.slice( 1 ).join( '/' );
  result.filePath = repo.filePathFor( result.selector1 );

  if( result.selector1 === '' )
  {
    result.structure = Object.create( null );
    let names = repo.collectionsNames();
    names.forEach( ( name ) => result.structure[ name ] = repo.structureRead( `/${name}` ) );
    return result;
  }

  if( !_.fileProvider.isTerminal( result.filePath ) )
  {
    return result;
  }

  result.structure = _.fileProvider.fileRead({ filePath : result.filePath, encoding : 'json' });

  return result;
}

//

function structureWrite( selector, structure )
{
  let repo = this;
  let selectorArray = _.path.split( selector );
  if( !selectorArray[ 0 ] )
  selectorArray.splice( 0, 1 );
  let selector2 = selectorArray.slice( 1 ).join( '/' );
  let selector1 = selectorArray[ 0 ];
  let filePath = repo.filePathFor( selector1 );

  _.assert( arguments.length === 2 );

  if( selector2 && selector2 !== '/' && selector2 !== '.' )
  {
    debugger;
    let read = repo.structureRead( selector1 );
    _.selectSet({ src : read, selector : selector2, set : structure });
    structure = read;
  }

  if( _.fileProvider.isDir( filePath ) )
  throw _.err( `${filePath} is directory, cant overwrite!` );
  _.fileProvider.fileWrite( filePath, _.toJson( structure ) );

}

//

function structureInsert( selector, structure )
{
  let repo = this;
  let read = repo._fileRead( selector );

  if( read.structure === undefined )
  read.structure = Object.create( null );
  _.selectSet
  ({
    src : read.structure,
    selector : read.selector2,
    set : structure,
  })

  repo.structureWrite( read.selector1, read.structure );
  return read;
}

//

function structureAppend( selector, structure )
{
  let repo = this;
  let read = repo._fileRead( selector );
  let dir = read.selector2;

  debugger;
  let selected = _.select
  ({
    src : read.structure,
    selector : dir,
  })

  if( read.structure === undefined )
  read.structure = Object.create( null );
  if( !selected )
  {
    selected = [];
    _.selectSet
    ({
      src : read.structure,
      selector : dir,
      set : selected,
    })
  }

  selected.push( structure )
  repo.structureWrite( read.selector1, read.structure );
}

//

function structureGet()
{
  let repo = this;

  let original = Object.create( null );
  let handler =
  {
    get : function( original, key, proxy )
    {
      if( _.symbolIs( key ) )
      return undefined;
      return repo.collection( key ).structureRead();
    },
    set : function( original, key, val, proxy )
    {
      if( _.symbolIs( key ) )
      return false;
      repo.collection( key ).structureWrite( val );
      return true;
    },
    ownKeys : function( original )
    {
      let result = repo.collectionsNames();
      return result;
    }
  }

  let result = new Proxy( original, handler );

  return result;
}

//

function filePathGet()
{
  let repo = this;
  let path = _.fileProvider.path;
  let filePath = path.join( path.dirUserHome(), repo.name );
  return filePath;
}

//

function filePathFor( collectionName )
{
  let repo = this;
  let path = _.fileProvider.path;

  _.assert( _.strIs( collectionName ) );
  _.assert( !_.strHas( collectionName, '/' ) );
  _.assert( arguments.length === 1 );

  let filePath = path.join( path.dirUserHome(), repo.name, collectionName );
  return filePath;
}

// --
// relations
// --

let Composes =
{
  name : null,
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
  read : null,
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{
  structure : {},
}

// --
// declare
// --

let Proto =
{

  // inter

  init,
  close,
  clean,
  exists,

  _collection,
  collection,
  array,
  map,
  collectionsNames,

  _fileRead,
  structureRead,
  structureWrite,
  structureInsert,
  structureAppend,

  structureGet,
  filePathGet,
  filePathFor,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

// --
// export
// --

_.persistent[ Self.shortName ] = Self;
if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

})();
