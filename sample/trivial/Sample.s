
let _ = require( 'wpersistent' );

/* */

var structure1 = { a : '1' };
var persistent = _.persistent.open( '.persistent.sample' );
persistent.array( 'account' ).append( structure1 );
persistent.close();

var persistent = _.persistent.open( '.persistent.sample' );
var read = persistent.array( 'account' ).read();
persistent.close();
console.log( read );

/* log : [ { a : '1' } ] */
