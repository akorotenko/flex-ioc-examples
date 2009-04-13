package com.adobe.dashboard.presentationModel
{
	import com.adobe.dashboard.domain.Friends;
	import com.adobe.dashboard.domain.User;
	import com.adobe.dashboard.presentationModel.user.ProfilePM;
	
	[Bindable]
	public class DashboardPM
	{
		public var user : User;
		
		public var profilePM : ProfilePM;
		
		public function DashboardPM( user : User, friends : Friends )
		{
			this.user = user;
			
			profilePM = new ProfilePM( user, friends );
		}

	}
}