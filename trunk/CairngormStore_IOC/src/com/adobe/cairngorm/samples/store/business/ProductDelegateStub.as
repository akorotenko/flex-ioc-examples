package com.adobe.cairngorm.samples.store.business
{
	import com.adobe.cairngorm.samples.store.business.stub.ProductFactory;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class ProductDelegateStub implements IProductDelegate
	{
		private var responder : IResponder;

		public function getProducts() : void
		{			
			responder.result( 
					new ResultEvent( 
						ResultEvent.RESULT, 
						false, 
						true, 
						ProductFactory.createProducts()
						) 
					);
		}
		
		public function addResponder( responder : IResponder ) : void
		{
			this.responder = responder;
		}
		
	}
}