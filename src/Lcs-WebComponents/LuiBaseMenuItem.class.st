Class {
	#name : 'LuiBaseMenuItem',
	#superclass : 'LuiMenuObject',
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'defaults' }
LuiBaseMenuItem >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #'nav-item'
]

{ #category : 'gt views' }
LuiBaseMenuItem >> gtViewTagName [
	^ '<li>'
]

{ #category : 'rendering' }
LuiBaseMenuItem >> renderComponentOn: html [
	html listItem
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
