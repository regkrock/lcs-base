Class {
	#name : 'LuiDemoAddressFormFunctionalTest',
	#superclass : 'LuiFormFunctionalTest',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'presenter' }
LuiDemoAddressFormFunctionalTest >> functionTestPresenter [
	LcsApplicationEnvironment ensureCurrentSystemIsDemoSystem.
	self model: LcsAddress new.
	^ (LuiDomainPresenter named: 'addressPresenter' model: self model)
		addLabelAndWidgetComponentFor: 'addressType';
		addLabelAndWidgetComponentFor: 'streetName';
		addLabelAndWidgetComponentFor: 'streetNumber';
		addLabelAndWidgetComponentFor: 'unit';
		yourself

]
