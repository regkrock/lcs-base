Class {
	#name : 'LuiCancelButton',
	#superclass : 'LuiSubmitButton',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'button action' }
LuiCancelButton >> cancelChanges [
	^ LcsApplicationEnvironment currentSystem clearUnitOfWork
]

{ #category : 'initialize' }
LuiCancelButton >> initialize [
	super initialize.
	self componentName: 'cancelButton'.
	self imageUrl: LcsFileLibrary / #cancel24Svg.
	self spanComponent text: 'Cancel'.
	self callback: [ self cancelChanges ]
]
