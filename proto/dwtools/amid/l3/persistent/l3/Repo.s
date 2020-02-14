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

function collectionsNames()
{
  let repo = this;
  let result = _.fileProvider.dirRead( repo.filePathGet() );
  if( !result )
  return [];
  return result;
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
  collectionsNames,

  structureGet,
  filePathGet,

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
