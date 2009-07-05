package com.adobe.login.service
{
	import com.adobe.login.control.event.LoginResultEvent;
	import com.adobe.login.service.mock.MockModelFactory;
	import com.adobe.util.logging.LogUtil;
	
	import mx.logging.ILogger;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	
	public class LoginDelegate
	{
		private static const LOGIN_DELEGATE : String  = "LOGIN_DELEGATE";
		
		public var responder : IResponder;
		
		[Inject]
		public var remoteObject : RemoteObject;
		
		private var log : ILogger = LogUtil.getLogger( this );
		
		public function authenticate( username : String, password : String ) : void
		{
			log.info("remote object: " );
			log.info("destination: " + remoteObject.destination );
					
			if( username.indexOf( "invalidUsername" ) == -1 )
			{
				responder.result( 
						new LoginResultEvent( 
								MockModelFactory.createUser( username ), 
								MockModelFactory.createFriends()
								) 
							);
			}
		}
		
	}
}