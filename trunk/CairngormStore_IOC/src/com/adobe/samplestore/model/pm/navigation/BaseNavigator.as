package com.adobe.samplestore.model.pm.navigation
{
	import com.adobe.ac.navigation.INavigator;
	import com.adobe.ac.navigation.IShowable;
	import com.adobe.ac.navigation.event.NavigationEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.IList;
	
	public class BaseNavigator extends EventDispatcher implements INavigator
	{
		private var _currentChild : IShowable;
		
		private var _children : IList;
		
		public function get children() : IList
		{
			return _children;
		}
		
		public function set children( value : IList ) : void
		{
			_children = value;
			for each( var showable : IShowable in _children )
			{
				showable.addEventListener( NavigationEvent.MOVE_TO_NEXT, handleMoveToNext );
			}		
			
			currentChild = IShowable( _children.getItemAt( 0 ) );
		}	
		
		private function handleMoveToNext( event : NavigationEvent ) : void
		{
			if( canMoveToNext )
			{
				moveToNext();
			}
		}
		
		private function handleMoveToPrevious( event : NavigationEvent ) : void
		{
			if( canMoveToPrevious )
			{
				moveToPrevious();
			}
		}
		
		[Bindable("navigation")]
		public function get selectedIndex() : int
		{
			return _children.getItemIndex( currentChild );
		}
		
		public function set selectedIndex( value : int ) : void
		{
			currentChild = IShowable( _children.getItemAt( value ) );
			dispatchEvent( new Event("navigation") );
		}
		
		[Bindable("navigation")]
		public function get currentChild() : IShowable
		{
			return _currentChild;
		}
		
		public function set currentChild( value : IShowable ) : void
		{
			_currentChild = value;
			dispatchEvent( new Event("navigation") );
		}


		public function get canMoveToNext() : Boolean
		{
			return currentChild.canHide;
		}
		
		public function get canMoveToPrevious() : Boolean
		{
			return currentChild.canHide;
		}
		
		public function moveToNext() : void
		{
			var currentChildIndex : int = children.getItemIndex( currentChild );
			currentChild = IShowable( children.getItemAt( currentChildIndex + 1 ) );
			dispatchEvent( new Event( "navigation" ) );
		}
		
		public function moveToPrevious() : void
		{
			var currentChildIndex : int = children.getItemIndex( currentChild );
			currentChild = IShowable( children.getItemAt( currentChildIndex - 1  ) );
			dispatchEvent( new Event( "navigation" ) );
		}
		
		
	}
}