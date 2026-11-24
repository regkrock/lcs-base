Class {
	#name : 'LuiBrand',
	#superclass : 'LuiDiv',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'isntance creation' }
LuiBrand class >> named: aName logoComponent: aLogoComponent text: aHoverText [

	^ self new
		initializeNamed: aName logoComponent: aLogoComponent text: aHoverText;
		yourself
]

{ #category : 'isntance creation' }
LuiBrand class >> newSeasBrand [
	^ self
		named: 'brand'
		logoComponent: LuiAnchor newSeasLogo
		text: 'SEAS Monmouth'
]

{ #category : 'components - updating' }
LuiBrand >> brandName: aString [
	(self componentNamed: 'brandName') text: aString
]

{ #category : 'initialize' }
LuiBrand >> initializeNamed: aName logoComponent: aLogoComponent text: aBrandName [ 
	self initializeNamed: aName. 
	self
		cssClass: LuiCssClassesMap / #'brand';
		addComponent: aLogoComponent;
		addComponent: (
			(LuiLabel named: 'brandName')
				text: aBrandName;
				yourself)
]
