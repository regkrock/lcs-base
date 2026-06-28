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
	"^ self name asString ~= 'LuiFormFunctionalTest'"
	^ true
]

{ #category : 'presenter' }
LuiFormFunctionalTest >> functionTestPresenter [
	self subclassResponsibility
]

{ #category : 'initialize' }
LuiFormFunctionalTest >> initialize [
	| personPresenter form |
	super initialize.
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	self model: LxxPersonExamples new johnFreeman.
	self componentName: 'root'.
	self componentId: 'root'.
	personPresenter := (LuiDomainPresenter named: 'personPresenter')
			cssClass: 'twoColumnsBySixRows';
			model: self model;
			yourself.
	form := LuiMainForm newWith: personPresenter.
	self addComponent: form.
	form addComponent: LuiSaveAndCancelButtonBar new.

	personPresenter 
		addLabelAndWidgetComponentFor: 'firstName';
		addLabelAndWidgetComponentFor: 'lastName';
		addLabelAndWidgetComponentFor: 'age' widgetClass: LuiNumberInput;
		addLabelAndWidgetComponentFor: 'mainSkill';
		addLabelAndWidgetComponentFor: 'mainSkill' widgetClass: LuiRadioButtons inputComponentName: 'mainSkillRadioButtons';
		addLabelAndWidgetComponentFor: 'balance';
		addLabelAndWidgetComponentFor: 'skills' widgetClass: LuiMultipleSelect;
		addLabelAndWidgetComponentFor: 'hasRedHair' widgetClass: LuiCheckboxAndLabel;
		addLabelAndWidgetComponentFor: 'dateOfBirth';
		addLabelAndWidgetComponentFor: 'weight';
		addLabelAndWidgetComponentFor: 'weight' widgetClass: LuiRangeInput inputComponentName: 'weightRange';
		addLabelAndWidgetComponentFor: 'comment'.
		
]

{ #category : 'initialize' }
LuiFormFunctionalTest >> initializeNew [
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
