package com.adobe.samplestore.model.pm.checkout
{
	import com.adobe.samplestore.model.domain.order.PaymentDetails;
	import com.adobe.samplestore.model.pm.navigation.BaseShowable;
	
	public class PaymentInformationPM extends BaseShowable
	{
		[Bindable]
		public var months : Array = [1,2,3,4,5,6,7,8,9,10,11,12];
	
		[Bindable]
		public var years : Array = [2009,2010,2011,2012,2013,2014];
	
		//[Inject]
		//[Bindable]
		//public var paymentInfo : Payment;
		
		private var _paymentInfo : PaymentDetails;
		
		public function set paymentInfo( value : PaymentDetails  ) : void
		{
			_paymentInfo = value;
		}
		[Inject]
		[Bindable]
		public function get paymentInfo() : PaymentDetails
		{
			return _paymentInfo;
		}
		
		public function getExpYearIndex( expiryYear : String ) : int 
		{
			return getItemIndex( years, expiryYear );
		}	
		
		public function getExpiryMonth( expiryMonth : String ) : int
		{
			return getItemIndex( months, expiryMonth );
		}	

		private function getItemIndex( array : Array, value : String ) : int 
		{
			for( var i : int = 0 ; i < array.length ; i++ )
			{
				var item : String = array[ i ].toString();
				if( item == value )
				{
					return i;
				}
			}
			return -1;
		}	
		
		override public function get name() : String
		{
			return "PAYMENT_INFORMATION";
		}
		
	}
}