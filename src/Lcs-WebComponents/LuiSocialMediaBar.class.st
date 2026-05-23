Class {
	#name : 'LuiSocialMediaBar',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiSocialMediaBar class >> newSeasSocialMediaBar [
	^ self new
		initializeSeasSocialMediaBar;
		yourself
]

{ #category : 'defaults' }
LuiSocialMediaBar >> defaultCssClasses [
	^ #(socialMedia)
]

{ #category : 'instance creation' }
LuiSocialMediaBar >> initializeSeasSocialMediaBar [
	self componentName: 'socialMedia'.
	self cssClass: 'sm-links'.
	self addComponent: (
		(LuiAnchor named: 'facebookLink') 
			beBlankTarget;
			url: 'https://www.facebook.com/groups/114024915284555/';
			addImageComponent: LuiImage newFacebookIcon;
			yourself).
	self addComponent: (
		(LuiAnchor named: 'meetupLink') 
			beBlankTarget;
			url: 'http://www.meetup.com/sailseas-com-monmouth/';
			addImageComponent: LuiImage newMeetupIcon;
			yourself)
]
