Class {
	#name : 'LuiDiv',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiDiv class >> mobileMenuButton [
	^ self new
		componentName: 'mobileMenuButton';
		cssClass: 'mobile-menu-btn';
		addComponent: LuiImage newMobileMenuIcon;
		yourself
]
