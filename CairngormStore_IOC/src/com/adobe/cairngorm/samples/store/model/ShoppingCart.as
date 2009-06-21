
package com.adobe.cairngorm.samples.store.model
{
	import com.adobe.cairngorm.samples.store.event.ShoppingCartEvent;
	import com.adobe.cairngorm.samples.store.event.TestEvent;
	import com.adobe.cairngorm.samples.store.model.domain.DeliverableItem;
	import com.adobe.cairngorm.samples.store.vo.ProductVO;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	[Event(name="cartChanged",type="com.adobe.cairngorm.samples.store.event.ShoppingCartEvent")]
	[ManagedEvents("cartChanged")]
	[Bindable]
	public class ShoppingCart extends EventDispatcher implements DeliverableItem
	{
		public var elements : ArrayCollection = new ArrayCollection();
	
		public var totalProductPrice : Number = 0;
		
		public var shippingCost : Number = 0;
		
		public function addElement( element : ProductVO, quantity : Number = 1 ) : void 
		{		
			if( quantity <= 0 ) 
			{
				quantity = 1;
			}
			
			for( var i : uint = 0; i < elements.length; i++ ) 
			{			
				var shoppingCartElement : ShoppingCartElement = elements[ i ];
				
				if( shoppingCartElement.element.id == element.id ) 
				{			
					shoppingCartElement.quantity += quantity;
					shoppingCartElement.totalProductPrice = shoppingCartElement.price * shoppingCartElement.quantity;
					totalProductPrice += shoppingCartElement.price * quantity;
					
					elements.dispatchEvent( new CollectionEvent( CollectionEvent.COLLECTION_CHANGE ) );
							
					return;
				}
			}
			
			addNewElementToCart( element, quantity );
		}
		
		public function deleteElement( element : ProductVO ) : Boolean
		{
			var deleted : Boolean = false;
			
			var i : int;
			for( i = 0; i < elements.length; i++ ) 
			{
				var shoppingCartElement : ShoppingCartElement = elements[ i ];
				if(shoppingCartElement.element.id === element.id) 
				{
					totalProductPrice -= shoppingCartElement.totalProductPrice;
					elements.removeItemAt( i );				
					deleted = true;
					break;
				}
			}		
			dispatchUpdate();
			return deleted;
		}
		
		public function getElements() : ArrayCollection
		{
			return elements;
		}
		
		private function addNewElementToCart( element : ProductVO, quantity : Number ):void
		{
			var shoppingCartElement : ShoppingCartElement = new ShoppingCartElement( element );
			shoppingCartElement.quantity = quantity;
			shoppingCartElement.name = element.name;
			shoppingCartElement.price = element.price;
			shoppingCartElement.totalProductPrice = element.price * quantity;
			elements.addItem( shoppingCartElement );
			totalProductPrice += shoppingCartElement.totalProductPrice;	
			dispatchUpdate();
		}				
		
		private function dispatchUpdate() : void
		{
			dispatchEvent( new ShoppingCartEvent() );
		}
		
		[Bindable("cartChanged")]
		public function get cartEmpty() : Boolean
		{
			return getElements().length == 0;
		}
		
		[MessageHandler]
		public function handlePurchaseComplete( purchaseEvent : TestEvent ) : void
		{
			trace(">>>> ");
		}
	}

}