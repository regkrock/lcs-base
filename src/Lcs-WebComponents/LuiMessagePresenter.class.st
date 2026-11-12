Class {
	#name : 'LuiMessagePresenter',
	#superclass : 'LuiDomainPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiMessagePresenter >> initialize [
	super initialize.
	self componentName: 'homePresenter'.
	self addComponent: (LuiDiv new
		text: '....';
		styleString: 'display: flex; justify-content: center; align-items: center; font-weight: bold; padding: 100px; ';
		yourself)
]

{ #category : 'as yet unclassified' }
LuiMessagePresenter >> message: aString [
	self firstComponent text: aString
]
