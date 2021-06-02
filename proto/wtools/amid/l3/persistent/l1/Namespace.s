( function _Tools_s_()
{

'use strict';

// let persistent = _.persistent.open({ name : '.system.wcloud' });
// persistent.array( 'account' ).write( structure );

const _ = _global_.wTools;
_.persistent = _.persistent || Object.create( null );

// --
// inter
// --

function open( o )
{


  if( _.strIs( arguments[ 0 ] ) )
  o = { name : arguments[ 0 ] }

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.name ) )

  return _.persistent.Repo( o );
}

//

function close( repo )
{
  _.assert( repo instanceof _.persistent.Repo )
  repo.finit();
}

// --
// declare
// --

let Extension =
{

  open,
  close,

}

/* _.props.extend */Object.assign( _.persistent, Extension );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
