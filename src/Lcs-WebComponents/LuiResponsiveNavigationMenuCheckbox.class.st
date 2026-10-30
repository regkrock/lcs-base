"
This is used for managing the Responsive Nav Bar. It does not call back to the server.
"
Class {
	#name : 'LuiResponsiveNavigationMenuCheckbox',
	#superclass : 'LuiCheckbox',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'rendering' }
LuiResponsiveNavigationMenuCheckbox >> renderComponentOn: html [
	html checkbox
		addCommonAttributes: self;
		value: self valueAccessor contents == true
]
