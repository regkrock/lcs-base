Class {
	#name : 'LuiHomePresenter',
	#superclass : 'LuiDomainPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiHomePresenter >> initialize [
	super initialize.
	self componentName: 'homePresenter'.
	self addComponent: (LuiDiv new
		text: 'Home Presenter';
		styleString: 'display: flex; justify-content: center; align-items: center; font-weight: bold; padding: 100px; ';
		yourself)
]
