Class {
	#name : 'LuiLxxPersonsFormTest',
	#superclass : 'LuiRoot',
	#instVars : [
		'model'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'register' }
LuiLxxPersonsFormTest class >> initialize [
	self registerApplication: 'LxxPersonsForm'
]

{ #category : 'presenter' }
LuiLxxPersonsFormTest >> functionTestPresenter [
	| presenter |
	self model: LxxPersonsExamples new freemanClan.
	presenter := (LuiDomainPresenter named: 'personsPresenter' model: self model).
	"presenter addComponent: (
		LuiTable onDomainCollection: self model)."

	^ presenter

]

{ #category : 'initialize' }
LuiLxxPersonsFormTest >> initialize [
	| form |
	super initialize.
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	LcsApplicationEnvironment currentUnitOfWork clearUnitOfWork.
	self componentName: 'root'.
	self componentId: 'root'.
	form := self addComponent: LuiMainForm new.
	form addComponent: self functionTestPresenter.
	form addComponent: LuiSaveAndCancelButtonBar new.
	^ self
]

{ #category : 'accessing' }
LuiLxxPersonsFormTest >> model [
	^ model 
]

{ #category : 'accessing' }
LuiLxxPersonsFormTest >> model: anObject [ 
	model := anObject
]

{ #category : 'rendering' }
LuiLxxPersonsFormTest >> renderComponentOn: html [
	super renderComponentOn: html		
]

{ #category : 'initialize' }
LuiLxxPersonsFormTest >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
