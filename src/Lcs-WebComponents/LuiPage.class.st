Class {
	#name : #LuiPage,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'as yet unclassified' }
LuiPage >> addComponent: aComponent [
	^ self components add: aComponent
]

{ #category : #'as yet unclassified' }
LuiPage >> removeComponent: aComponent [
	^ self components remove: aComponent ifAbsent: []
]

{ #category : #'as yet unclassified' }
LuiPage >> renderContentOn: aRenderer [
	self renderPageOn: aRenderer
]

{ #category : #'as yet unclassified' }
LuiPage >> renderPageOn: aRenderer [ 
	aRenderer form: [super renderSubcomponentsOn: aRenderer]
]
