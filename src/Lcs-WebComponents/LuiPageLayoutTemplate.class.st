Class {
	#name : 'LuiPageLayoutTemplate',
	#superclass : 'LcsObject',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'defaults' }
LuiPageLayoutTemplate class >> hamburgerCodePointString [
	^ String with: (Character codePoint: 16r2630)
]

{ #category : 'building' }
LuiPageLayoutTemplate >> buildLayoutFor: aRoot [
	aRoot addComponent: self pageHeaderComponentDefinition.
	aRoot addComponent: self mainFormComponentDefinition.
]

{ #category : 'components - definition' }
LuiPageLayoutTemplate >> homePresenter [
	^ LuiHomePresenter new
]

{ #category : 'components - definition' }
LuiPageLayoutTemplate >> mainFormComponentDefinition [
	^ LuiMainForm new
		switchToComponent: self homePresenter;
		yourself
]
