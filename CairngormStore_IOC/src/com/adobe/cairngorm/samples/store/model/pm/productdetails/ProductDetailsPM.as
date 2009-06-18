package com.adobe.cairngorm.samples.store.model.pm.productdetails
{
	import com.adobe.cairngorm.samples.store.event.UpdateShoppingCartEvent;
	import com.adobe.cairngorm.samples.store.model.Products;
	import com.adobe.cairngorm.samples.store.vo.ProductVO;
	
	import mx.binding.utils.BindingUtils;
	import mx.formatters.CurrencyFormatter;
	
	[Event(name="addProductToShoppingCart",type="com.adobe.cairngorm.samples.store.event.UpdateShoppingCartEvent")]
	[ManagedEvents("addProductToShoppingCart")]
	[InjectConstructor]
	public class ProductDetailsPM
	{
		[Bindable]
		private var products : Products;
		
		[Bindable]
		public var selectedItem : ProductVO;
		
		[Bindable]
		public var quantity : Number = 1;
		
		[Inject]
		[Bindable]
		public var currencyFormatter : CurrencyFormatter;
		
		
		public function ProductDetailsPM( products : Products )
		{
			this.products = products;
			BindingUtils.bindProperty( this, "selectedItem", products, "selectedItem" );
		}
		
		public function addProductToShoppingCart () : void
		{
		  var event : UpdateShoppingCartEvent =
			  new UpdateShoppingCartEvent(
				  UpdateShoppingCartEvent.ADD );
		  
			event.product = products.selectedItem;
			event.quantity = quantity;
		
			dispatchEvent( event );
		}	
		
		public function formatPrice( value : Number ) : String 
		{
			return currencyFormatter.format( value );
		}
		
	}
}