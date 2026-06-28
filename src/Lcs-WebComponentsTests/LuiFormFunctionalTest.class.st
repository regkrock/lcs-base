Class {
	#name : 'LuiFormFunctionalTest',
	#superclass : 'LuiFunctionalTest',
	#instVars : [
		'model'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'testing' }
LuiFormFunctionalTest class >> isLcsFunctionalTest [
	^ self name asString ~= 'LuiFormFunctionalTest'
]

{ #category : 'presenter' }
LuiFormFunctionalTest >> functionTestPresenter [
	self subclassResponsibility
]

{ #category : 'initialize' }
LuiFormFunctionalTest >> initialize [
	| form |
	super initialize.
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	self componentName: 'root'.
	self componentId: 'root'.
	form := self addComponent: LuiMainForm new.
	form addComponent: self functionTestPresenter.
	form addComponent: LuiSaveAndCancelButtonBar new
]

{ #category : 'accessing' }
LuiFormFunctionalTest >> model [
	^ model
]

{ #category : 'accessing' }
LuiFormFunctionalTest >> model: anObject [
	model := anObject
]

{ #category : 'rendering' }
LuiFormFunctionalTest >> renderComponentOn: html [
	super renderComponentOn: html
]
